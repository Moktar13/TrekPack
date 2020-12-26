//
//  TreksTableViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//
import UIKit
import CoreLocation
import CoreData

//TreksTableViewController class which shows all the treks in tabelview style
class TreksTableViewController: UIViewController, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate{
    
    //Class variables
    fileprivate let cellId = "id"
    fileprivate let locManager = CLLocationManager()
    var tableView = UITableView()
    
    //MARK: deinit
    deinit {
        print("OS reclaiming TreksView memory")
    }
   
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
//        CoreDataOperations.fetchCoreData()
//        CoreDataOperations.setupTrekFormat()
        
        //Used to create a seamless transition between view contrllers and their different navigation bar colors/images
        navigationController?.navigationBar.barTintColor = SingletonStruct.testBlue
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        
        
        //Allowing vertical scrolling or not based on the number of treks
        if (SingletonStruct.allTreks.count > 3){
            tableView.alwaysBounceVertical = true
        }else{
            tableView.alwaysBounceVertical = false
        }
        
        
        checkForTreks()
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("Treks in CoreData: \(SingletonStruct.treksCoreData.count)")
              
    }
        
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //SingletonStruct.allTreks.removeAll()
        
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = SingletonStruct.testBlue

        //TableView settings
        tableView.backgroundView = UIImageView(image: UIImage(named: "balloon"))
        tableView.register(TrekCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.alwaysBounceHorizontal = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //Used to request location
        locManager.requestWhenInUseAuthorization()
        locManager.delegate = self
        
        //Method calls
        setupUI()
        setupNavigationBar()
    }
    
    
    //MARK: checkForTreks
    func checkForTreks(){
        
        //Checking if there are any treks in the allTreks and based onthe result show/hide UI
        if (SingletonStruct.allTreks.count == 0){
            imgView.isHidden = false
            noTrekLabel.isHidden = false
        }else{
            imgView.isHidden = true
            noTrekLabel.isHidden = true
        }
    }
    
    
    //MARK: setupNavigationBar
    func setupNavigationBar(){
        navigationItem.title = "My Treks"
    
        //Navigation Contoller settings
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = SingletonStruct.testBlue
        navigationController?.navigationBar.tintColor = SingletonStruct.newWhite
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: SingletonStruct.navTitle, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setItems([navigationItem], animated: true)
    }
    
    //MARK: createTrek
    @objc func createTrek(){
        SingletonStruct.makingNewTrek = true
        self.presentInFullScreen(NewTrekVC(), animated:true, completion: nil)
    }
    
    
    //MARK: setupUI
    func setupUI(){
        
        //NSLayoutConstraint for newTrekButton
        view.addSubview(newTrekButton)
        newTrekButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        newTrekButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newTrekButton.widthAnchor.constraint(equalToConstant: newTrekButton.frame.width).isActive = true
        newTrekButton.heightAnchor.constraint(equalToConstant: newTrekButton.frame.width).isActive = true
        
        //NSLayoutConstraint for imgView
        view.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.width/6).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: view.frame.width/1.25).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: view.frame.width/1.25).isActive = true
        
        //NSLayoutConstraint for noTrekLabel
        view.addSubview(noTrekLabel)
        noTrekLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noTrekLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -view.frame.width/6).isActive = true
        noTrekLabel.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        noTrekLabel.widthAnchor.constraint(equalToConstant: view.frame.width/1.25).isActive = true
        
        //NSLayoutConstraint for tableView
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
        //Bringing some UI to the front so its not hidden behind the tableview or other UI
        view.bringSubviewToFront(newTrekButton)
        view.bringSubviewToFront(noTrekLabel)
        view.bringSubviewToFront(imgView)
    }
    
    
    //MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SingletonStruct.allTreks.count
    }
    
    
    //MARK: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    //MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TrekCell
        
        //Cell settings
        cell.selectionStyle = .none
        cell.layer.masksToBounds = true
        cell.img = UIImage(data: Data.init(base64Encoded: SingletonStruct.allTreks[indexPath.row].imgData, options: .init(rawValue: 0))!)!
        cell.screenWidth = Double(tableView.frame.width)
        cell.nameLabel.attributedText = NSAttributedString(string: "\(SingletonStruct.allTreks[indexPath.row].name)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
        cell.destinationLabel.attributedText = NSAttributedString(string: "\(SingletonStruct.allTreks[indexPath.row].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
            
         //Setting departure & return text based on the treks values for those fields
        if (SingletonStruct.allTreks[indexPath.row].returnDate != ""){
            cell.depRetLabel.attributedText = NSAttributedString(string: "\(SingletonStruct.allTreks[indexPath.row].departureDate) - \(SingletonStruct.allTreks[indexPath.row].returnDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
        }else{
            cell.depRetLabel.attributedText = NSAttributedString(string: "\(SingletonStruct.allTreks[indexPath.row].departureDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
        }
    
        //Called to set the background image of the cell and the proper width anchor of it
        cell.awakeFromNib()
        return cell
    }
    
    
    //MARK: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Setting global variables
        SingletonStruct.selectedTrek = indexPath.row
        SingletonStruct.makingNewTrek = false
        SingletonStruct.isViewingPage = true

        //Setting navigation bar so that it has back button with no back word & so it pushes the ViewTrekController
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(ViewTrekViewController(), animated: true)
    }
    
    //MARK: editingStyle
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //If the editingStyle is type delete, then remove the Trek from AllTreks.allTreks and then save the updated array of treks
        if editingStyle == .delete {
            
            SingletonStruct.allTreks.remove(at: indexPath.row)
            
            CoreDataOperations.deleteAllCoreData()
            CoreDataOperations.saveCoreData()
            
            
            tableView.deleteRows(at: [indexPath], with: .bottom)
            checkForTreks()
        }
    }
    
    //MARK: UI Declarations
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
            label.attributedText = NSAttributedString(string: "No Treks Found\n", attributes: [NSAttributedString.Key.font: SingletonStruct.headerFont]) + NSAttributedString(string: "Add a new trek by tapping the button below", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv2])
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
    
    //TrekCell variable declarations
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
    
    //MARK: setupConstraints
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
