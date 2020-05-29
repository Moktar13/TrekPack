//
//  TreksTableViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class TreksTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate{
    
    var tableView = AutomaticHeightTableView()
    
    //Todo: Will contain all the users treks
    let trips:[String] = []

    let cellReuseID = "cell"
    
    override func viewDidAppear(_ animated: Bool) {
        print("LOADING \(AllTreks.treksArray.count) treks")
        tableView.reloadData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
    
        view.backgroundColor = SingletonStruct.testBlack
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        
        tableView.tableFooterView = UIView()
        
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        navigationController!.navigationBar.barTintColor = SingletonStruct.testBlack
        navigationController!.navigationBar.tintColor = SingletonStruct.testGold
    
        let logoutButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(TreksTableViewController.onLogout))
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "sliders"), style: .plain, target: self, action: #selector(TreksTableViewController.onFilter))
        
     
    
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.title = "My Treks"
        navigationItem.rightBarButtonItem = filterButton
        
        navigationController!.navigationBar.setItems([navigationItem], animated: true)
        
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SingletonStruct.testWhite, NSAttributedString.Key.font: SingletonStruct.navTitle]

    }
    
    @objc func onLogout(){
        print("Shite")
    }
    
    @objc func onFilter(){
        
    }

    //For creating a new trek
    let newTrekButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
              
       let plusTxt = NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35), NSAttributedString.Key.foregroundColor: UIColor.white])
  
       button.layer.cornerRadius = 0.5 * button.bounds.size.width
       button.backgroundColor = SingletonStruct.blackColor
       button.layer.borderColor = SingletonStruct.blackColor.cgColor
       button.layer.borderWidth = 2
       button.addTarget(self, action: #selector(TreksTableViewController.createTrek), for: .touchDown)
      
  
       let full = NSMutableAttributedString(string: "")
      
       let icon = NSTextAttachment()
      
       icon.image = UIImage(named: "plus")
       icon.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
      
       let string = NSAttributedString(attachment: icon)
      
       full.append(string)
      
      
       button.setAttributedTitle(full, for: .normal)
      
      
       button.translatesAutoresizingMaskIntoConstraints = false
    
       return button
   }()
    @objc func createTrek(){
        
        
        AllTreks.makingNewTrek = true
      
       //Getting the view controller and repspective nav controller and then presenting the navigation controller in full screen
//       let firstVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NTVC")
        
        ///Todo: Change this so it has a proper name!
       let ass = NewTrekVC()
       
//       let navController = UINavigationController(rootViewController: firstVC)
       self.presentInFullScreen(ass, animated:true, completion: nil)
      
       print("Adding new trek")
              
        
    }
    
    
   
    func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
         
        tableView.contentInset = .zero
        tableView.separatorColor = .black
        tableView.backgroundColor = .clear
        
        
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
        
        //Adding the new trek button (not part of the table view so change func name)
        view.addSubview(newTrekButton)

        newTrekButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        newTrekButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newTrekButton.widthAnchor.constraint(equalToConstant: newTrekButton.frame.width).isActive = true
        newTrekButton.heightAnchor.constraint(equalToConstant: newTrekButton.frame.width).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray.count
    }
    
    //Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        
        //If there is no destination and no departure date (including return date
        if (AllTreks.treksArray[indexPath.row].destination.isEmpty && (AllTreks.treksArray[indexPath.row].departureDate.isEmpty)){
            
            print("Tag Count: \(AllTreks.treksArray[indexPath.row].tags.count)")
            

            //Showing the trek name
            cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)", attributes: [NSAttributedString.Key.font: SingletonStruct.headerFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testGold])

        
        //If there is a destination but not departure date
        }else if (AllTreks.treksArray[indexPath.row].destination.isEmpty == false && (AllTreks.treksArray[indexPath.row].departureDate.isEmpty)){
            
            //Adding Trek name
            cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.headerFont]) +

            //Adding Trek destination
            NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
       
            
        //If there is both dep and dest present
        }else if (AllTreks.treksArray[indexPath.row].destination.isEmpty == false && AllTreks.treksArray[indexPath.row].departureDate.isEmpty == false) {
            
            
            //If there is no return
            if (AllTreks.treksArray[indexPath.row].returnDate.isEmpty){
                
                //Adding Trek name
                cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.headerFont]) +
                    
                //Adding Trek destination
                NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont]) +

                //Adding the departure/return dates
                NSAttributedString(string: "\n\(AllTreks.treksArray[indexPath.row].departureDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
            }
                
            //Else if there is a return
            else{
                //Adding Trek name
                cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.headerFont]) +
                    
                //Adding Trek destination
                NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont]) +

                //Adding the departure/return dates
                    NSAttributedString(string: "\n\(AllTreks.treksArray[indexPath.row].departureDate) - \(AllTreks.treksArray[indexPath.row].returnDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
            }
            
            
        //If there is dep but no dest
        }else if (AllTreks.treksArray[indexPath.row].destination.isEmpty && AllTreks.treksArray[indexPath.row].departureDate.isEmpty == false){
            
            //If there is no return
            if (AllTreks.treksArray[indexPath.row].returnDate.isEmpty){
                
                //Adding Trek name
                cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.headerFont]) +

                //Adding the departure date
                NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].departureDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
            }
                
            //Else if there is a return
            else{
                
                
                //Adding Trek name
                cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.headerFont]) +

                //Adding the departure/return dates
                    NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].departureDate) - \(AllTreks.treksArray[indexPath.row].returnDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
            }
        }
        
        
        
        cell.contentView.layoutMargins.left = view.frame.width/11
        
        
        
        
        
        
        
        let imageView = UIImageView(image: (AllTreks.treksArray[indexPath.row].image))
        
        if (AllTreks.treksArray[indexPath.row].imageName == "img"){
            imageView.image = nil
            imageView.backgroundColor = SingletonStruct.testGold
            print("EQUAL MAFK")
        }else{
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true;
            imageView.alpha = 0.75
            
        
//            cell.contentView.layoutMargins.left = 35
        }
        cell.backgroundView = imageView
        cell.textLabel?.textColor = SingletonStruct.testBlack
        

        return cell
    }
    
    func areEqualImages(img1: UIImage, img2: UIImage) -> Bool {

        guard let data1 = img1.pngData() else { return false }
        guard let data2 = img2.pngData() else { return false }
        
        print("Data 1: \(data1)")
        print("Data 2: \(data2)")
        
        if (data1 == data2){
            return true
        }else{
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        AllTreks.selectedTrek = indexPath.row
        AllTreks.makingNewTrek = false
        
        let viewVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VTC")
        let navController = UINavigationController(rootViewController: viewVC)
        self.presentInFullScreen(navController, animated:true, completion: nil)
        
        print("Some trip selected")
    }
}

//Code for adding a line underneath the textfield input (idk what it does!!)
enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

extension UIView {
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}

//Use to dimiss the keyboard on tap
extension UIViewController {
    
    //Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    // Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}

extension UIViewController {
  func presentInFullScreen(_ viewController: UIViewController,
                           animated: Bool,
                           completion: (() -> Void)? = nil) {
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: animated, completion: completion)
  }
}

