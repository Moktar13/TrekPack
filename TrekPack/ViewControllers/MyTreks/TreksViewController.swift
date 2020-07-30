//
//  TreksTableViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//
import UIKit
import CoreLocation

class TreksTableViewController: UITableViewController, UINavigationControllerDelegate{
    
    fileprivate var refreshedView = false
    fileprivate let cellId = "id"
    
    fileprivate let locManager = CLLocationManager()
    
    let defaults = UserDefaults.standard
    
    deinit {
        print("OS reclaiming TreksView memory")
    }
   
  
    override func viewWillAppear(_ animated: Bool) {
        
        guard let trekData = defaults.object(forKey: "saved") as? Data else {
            print("Couldn't find saved data")
            return
        }
        
        guard let treks = try? PropertyListDecoder().decode([TrekStruct].self, from: trekData) else {
            print("Some other shit went wrong")
            return
        }
        
        
        print("Treks: \(treks.count)")
        AllTreks.treksArray = treks
        
        if (AllTreks.treksArray.count > 3){
            tableView.alwaysBounceVertical = true
        }else{
            tableView.alwaysBounceVertical = false
        }
        
        
        checkForTreks()
        tableView.reloadData()
        
    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light

        view.backgroundColor = .systemPink

        tableView.backgroundView = UIImageView(image: UIImage(named: "balloon"))
        tableView.register(TrekCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.alwaysBounceHorizontal = false
        
        //Used to request location
        
        locManager.requestWhenInUseAuthorization()
        
        
        
        setupUI()
        setupNavigationBar()
    }
    
    func checkForTreks(){
        if (AllTreks.treksArray.isEmpty){
            imgView.isHidden = false
            noTrekLabel.isHidden = false
        }else{
            imgView.isHidden = true
            noTrekLabel.isHidden = true
        }
    }
    
    
    
    @objc func createTrek(){
        AllTreks.makingNewTrek = true
        let newTrekPage = NewTrekVC()
        self.presentInFullScreen(newTrekPage, animated:true, completion: nil)
    }
    
    
   
    func setupUI(){
        //NEW TREK BUTTON
        view.addSubview(newTrekButton)
        newTrekButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        newTrekButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newTrekButton.widthAnchor.constraint(equalToConstant: newTrekButton.frame.width).isActive = true
        newTrekButton.heightAnchor.constraint(equalToConstant: newTrekButton.frame.width).isActive = true
        
        //NO TREK ICONS
        view.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.width/6).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: view.frame.width/1.25).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: view.frame.width/1.25).isActive = true
        
        //NO TREK LABEL
        view.addSubview(noTrekLabel)
        noTrekLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noTrekLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -view.frame.width/6).isActive = true
        noTrekLabel.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        noTrekLabel.widthAnchor.constraint(equalToConstant: view.frame.width/1.25).isActive = true
    }
    
    
    
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TrekCell
        
        cell.selectionStyle = .none
           
            
        cell.nameLabel.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
            
         
        cell.destinationLabel.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
            
            
          
        
        if (AllTreks.treksArray[indexPath.row].returnDate != ""){
            cell.depRetLabel.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].departureDate) - \(AllTreks.treksArray[indexPath.row].returnDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
        }else{
            cell.depRetLabel.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].departureDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
        }
    
        cell.img = UIImage(data: Data.init(base64Encoded: AllTreks.treksArray[indexPath.row].imgData, options: .init(rawValue: 0))!)!
        cell.layer.masksToBounds = true
        cell.screenWidth = Double(tableView.frame.width)
        cell.awakeFromNib()
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        AllTreks.selectedTrek = indexPath.row
        AllTreks.makingNewTrek = false
        SingletonStruct.isViewingPage = true

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        self.navigationController?.pushViewController(ViewTrekViewController(), animated: true)
        
        presentInFullScreen(ViewTrekViewController(), animated: true)
//        self.present(ViewTrekViewController(), animated: true, completion: nil)

    }
    
    //For deleting from the table view
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AllTreks.treksArray.remove(at: indexPath.row)
            defaults.set(try? PropertyListEncoder().encode(AllTreks.treksArray), forKey: "saved")
            SingletonStruct.deleteCellHeight = tableView.cellForRow(at: indexPath)!.frame.height
            tableView.deleteRows(at: [indexPath], with: .bottom)
            checkForTreks()

        }
    }
    
    //UI STUFF
    let imgView:UIImageView = {
        let view = UIImageView()
            view.layer.cornerRadius = 0
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .scaleAspectFill
            view.layer.masksToBounds = true
            view.image = UIImage(named: "no_treks")

            view.alpha = 1.0
        return view
    }()
    let noTrekLabel:UILabel = {
        var label = UILabel()
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.attributedText = NSAttributedString(string: "No Treks Found!\n", attributes: [NSAttributedString.Key.font: SingletonStruct.headerFont]) + NSAttributedString(string: "Add a new trek by tapping the button below", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv2])
            label.textColor = SingletonStruct.testWhite
        return label
    }()
    let newTrekButton:UIButton = {
      let button = UIButton(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
      button.layer.cornerRadius = 0.5 * button.bounds.size.width
      button.backgroundColor = SingletonStruct.testBlue
      button.layer.borderWidth = 0
      button.addTarget(self, action: #selector(TreksTableViewController.createTrek), for: .touchDown)
      button.translatesAutoresizingMaskIntoConstraints = false
      let plusString = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
      let icon = NSTextAttachment()
      icon.image = UIImage(named: "plus")
      icon.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
      let string = NSAttributedString(attachment: icon)
      plusString.append(string)
      button.setAttributedTitle(plusString, for: .normal)

      return button
 }()
}


//MARK: TrekCell
class TrekCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let destinationLabel = UILabel()
    let depRetLabel = UILabel()
    
    var screenWidth = 0.0
    var backdropView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    var img = UIImage()
    
    let destinationIcon:UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "map-pin-treks")
        
        return imgView
    }()
    
    
    let calendarIcon:UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "calendar-treks")
        
        return imgView
    }()

    
    //MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        backdropView.image = img
        backdropView.widthAnchor.constraint(equalToConstant: CGFloat(screenWidth-20)).isActive = true
    }

    
    //MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    
    //MARK: setupUI
    func setupUI(){
        
        //cell general
        backgroundColor = .clear
        layer.cornerRadius = 30
        
        //backdrop view
        backdropView.translatesAutoresizingMaskIntoConstraints = false
        backdropView.backgroundColor = .white
        backdropView.clipsToBounds = true
        backdropView.layer.cornerRadius = 20
        backdropView.contentMode = .scaleAspectFill

        //destination label
        destinationLabel.layer.shadowColor = UIColor.black.cgColor
        destinationLabel.layer.shadowRadius = 3.0
        destinationLabel.layer.shadowOpacity = 1.0
        destinationLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        destinationLabel.layer.masksToBounds = false
        destinationLabel.backgroundColor = .clear
        destinationLabel.textColor = .white
        destinationLabel.minimumScaleFactor = 0.5
        destinationLabel.adjustsFontSizeToFitWidth = true
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        destinationLabel.numberOfLines = 1
        
        //name label
        nameLabel.layer.shadowColor = UIColor.black.cgColor
        nameLabel.layer.shadowRadius = 3.0
        nameLabel.layer.shadowOpacity = 1.0
        nameLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        nameLabel.layer.masksToBounds = false
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .white
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1

        
        //dep ret label
        depRetLabel.layer.shadowColor = UIColor.black.cgColor
        depRetLabel.layer.shadowRadius = 3.0
        depRetLabel.layer.shadowOpacity = 1.0
        depRetLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        depRetLabel.layer.masksToBounds = false
        depRetLabel.backgroundColor = .clear
        depRetLabel.textColor = .white
        depRetLabel.minimumScaleFactor = 0.5
        depRetLabel.adjustsFontSizeToFitWidth = true
        depRetLabel.translatesAutoresizingMaskIntoConstraints = false
        depRetLabel.numberOfLines = 1
    }
    
    func setupConstraints(){
        //backdrop
        addSubview(backdropView)
        backdropView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backdropView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backdropView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        //destination icon
        addSubview(destinationIcon)
        destinationIcon.leadingAnchor.constraint(equalTo: backdropView.leadingAnchor, constant: 5).isActive = true
    
        //destination
        addSubview(destinationLabel)
        destinationLabel.leadingAnchor.constraint(equalTo: destinationIcon.trailingAnchor, constant: 5).isActive = true
        destinationLabel.trailingAnchor.constraint(equalTo: backdropView.trailingAnchor, constant: -5).isActive = true
        destinationLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        //destination icon
        destinationIcon.centerYAnchor.constraint(equalTo: destinationLabel.centerYAnchor).isActive = true
        destinationIcon.heightAnchor.constraint(equalTo: destinationLabel.heightAnchor, constant: -5).isActive = true
        destinationIcon.widthAnchor.constraint(equalTo: destinationLabel.heightAnchor, constant: -5).isActive = true
        
        //name
        addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: backdropView.leadingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: backdropView.trailingAnchor, constant: -5).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: destinationLabel.topAnchor).isActive = true
        
        //calendar icon
        addSubview(calendarIcon)
        calendarIcon.leadingAnchor.constraint(equalTo: backdropView.leadingAnchor, constant: 5).isActive = true
        
        //dep & ret
        addSubview(depRetLabel)
        depRetLabel.leadingAnchor.constraint(equalTo: calendarIcon.trailingAnchor, constant: 5).isActive = true
        depRetLabel.trailingAnchor.constraint(equalTo: backdropView.trailingAnchor, constant: -5).isActive = true
        depRetLabel.topAnchor.constraint(equalTo: destinationLabel.bottomAnchor).isActive = true
        depRetLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        
        //calendar icon
        calendarIcon.centerYAnchor.constraint(equalTo: depRetLabel.centerYAnchor).isActive = true
        calendarIcon.heightAnchor.constraint(equalTo: destinationIcon.heightAnchor).isActive = true
        calendarIcon.widthAnchor.constraint(equalTo: destinationIcon.heightAnchor).isActive = true
    }
    
  required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




