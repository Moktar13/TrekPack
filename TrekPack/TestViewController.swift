//
//  TestViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-06-22.
//  Copyright © 2020 Moktar. All rights reserved.
//

//
//  TestViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-06-22.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class TableViewControllerCust: UITableViewController {
    
    fileprivate var refreshedView = false
    
    var counter = 0
    var screenWidth = 0.0
    fileprivate let cellId = "id"
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        refreshedView = true
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        
//        tableView.reloadData()
//        scrollToBottom()
    }
    
 
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
    

    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: AllTreks.treksArray.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToTop(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad() called")
        
        
        screenWidth = Double(view.frame.width)
        view.backgroundColor = .systemPink

        tableView.backgroundView = UIImageView(image: UIImage(named: "balloon"))
        tableView.register(TrekCell.self, forCellReuseIdentifier: cellId)
        

       
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        
        
//        tableView.preservesSuperviewLayoutMargins = false
//               tableView.separatorInset = UIEdgeInsets.zero
//               tableView.layoutMargins = UIEdgeInsets.zero
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TrekCell
        
        print("enqueing cell: \(indexPath.row+1)")
        
        cell.nameLabel.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
            
         
        cell.destinationLabel.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
        
        
      
        
        if (AllTreks.treksArray[indexPath.row].returnDate != ""){
            cell.depRetLabel.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].departureDate) - \(AllTreks.treksArray[indexPath.row].returnDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
        }else{
            cell.depRetLabel.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].departureDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
        }
    
        

        cell.img = UIImage(data: Data.init(base64Encoded: AllTreks.treksArray[indexPath.row].imgData, options: .init(rawValue: 0))!)!
        cell.layer.masksToBounds = true
            

        
        
        
        
        
        cell.awakeFromNib()
        
        

        return cell
    }
    
}


class TrekCell: UITableViewCell {
    
    
    
    let nameLabel = UILabel()
    let destinationLabel = UILabel()
    let depRetLabel = UILabel()
    
    var backdropView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    
    var topImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    
    var sepView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    

    
    var testImage = UIImageView()
    
    var imgView = UIImageView(image: UIImage(named: "wallpaper_1"))
    var test = UIView()
    
    var img = UIImage()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        backdropView.image = img

    
    }
    
    
    
 
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        layer.cornerRadius = 30
        
        
        setupUI()
    }
    
    
    
    
    
    
    func setupUI(){
        
        //backdrop view
        backdropView.translatesAutoresizingMaskIntoConstraints = false
        backdropView.backgroundColor = .white
        backdropView.clipsToBounds = true
        backdropView.layer.cornerRadius = 20
        backdropView.contentMode = .scaleAspectFill

        
        addSubview(backdropView)
        backdropView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backdropView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backdropView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        backdropView.widthAnchor.constraint(equalToConstant: frame.width+30).isActive = true
        

        //destination label
        destinationLabel.layer.shadowColor = UIColor.black.cgColor
        destinationLabel.layer.shadowRadius = 3.0
        destinationLabel.layer.shadowOpacity = 1.0
        destinationLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        destinationLabel.layer.masksToBounds = false
        destinationLabel.backgroundColor = .clear
        destinationLabel.textColor = .white
        destinationLabel.minimumScaleFactor = 0.5
        destinationLabel.adjustsFontSizeToFitWidth = true
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        destinationLabel.numberOfLines = 1
        
        addSubview(destinationLabel)
        destinationLabel.leadingAnchor.constraint(equalTo: backdropView.leadingAnchor, constant: 5).isActive = true
        destinationLabel.trailingAnchor.constraint(equalTo: backdropView.trailingAnchor, constant: -5).isActive = true
        destinationLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        //name label
        nameLabel.layer.shadowColor = UIColor.black.cgColor
        nameLabel.layer.shadowRadius = 3.0
        nameLabel.layer.shadowOpacity = 1.0
        nameLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        nameLabel.layer.masksToBounds = false
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .white
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1

        addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: backdropView.leadingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: backdropView.trailingAnchor, constant: -5).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: destinationLabel.topAnchor).isActive = true
        
        //dep ret label
        depRetLabel.layer.shadowColor = UIColor.black.cgColor
        depRetLabel.layer.shadowRadius = 3.0
        depRetLabel.layer.shadowOpacity = 1.0
        depRetLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        depRetLabel.layer.masksToBounds = false
        depRetLabel.backgroundColor = .clear
        depRetLabel.textColor = .white
        depRetLabel.minimumScaleFactor = 0.5
        depRetLabel.adjustsFontSizeToFitWidth = true
        depRetLabel.translatesAutoresizingMaskIntoConstraints = false
        depRetLabel.numberOfLines = 1
        
        addSubview(depRetLabel)
        depRetLabel.leadingAnchor.constraint(equalTo: backdropView.leadingAnchor, constant: 5).isActive = true
        depRetLabel.trailingAnchor.constraint(equalTo: backdropView.trailingAnchor, constant: -5).isActive = true
        depRetLabel.topAnchor.constraint(equalTo: destinationLabel.bottomAnchor).isActive = true
        depRetLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        
    }
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func setupBackdrop(){
        print("Cell height: \(frame.size.height)")
       
        
        
        

        
        
//        imgView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
//        imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        imgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
//        imgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    
    
  

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


