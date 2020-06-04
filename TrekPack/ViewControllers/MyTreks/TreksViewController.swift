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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        checkForTreks()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imgView.isHidden = true
        noTrekLabel.isHidden = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
    
        view.backgroundColor = SingletonStruct.newWhite
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        
        tableView.tableFooterView = UIView()
        
        tableView.estimatedRowHeight = 125
        tableView.rowHeight = UITableView.automaticDimension
        
        setupUI()
        setupNavigationBar()
        checkForTreks()
        
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
        
       
        label.attributedText = NSAttributedString(string: "No Treks Found!\n", attributes: [NSAttributedString.Key.font: SingletonStruct.headerFont]) + NSAttributedString(string: "Add a new trek by tapping the button below", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFont])
        
        label.textColor = SingletonStruct.testBlue
        
             
        
        return label
    }()
    
    
   
    //For creating a new trek
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
    @objc func createTrek(){
        
        
        AllTreks.makingNewTrek = true
  
        ///Todo: Change this so it has a proper name!
       let ass = NewTrekVC()
       

       self.presentInFullScreen(ass, animated:true, completion: nil)
      
       print("Adding new trek")
              
        
    }
    
    
   
    func setupUI(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = .zero
        tableView.separatorColor = SingletonStruct.testBlack
        tableView.backgroundColor = .clear
        
        //TABLE VIEW
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
        
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
        
        view.addSubview(noTrekLabel)
        noTrekLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noTrekLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -view.frame.width/6).isActive = true
        noTrekLabel.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        noTrekLabel.widthAnchor.constraint(equalToConstant: view.frame.width/1.25).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray.count
    }
    
    //Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.sizeToFit()
    

            
        //If there is no destination and no departure date (including return date
        if (AllTreks.treksArray[indexPath.row].destination.isEmpty && (AllTreks.treksArray[indexPath.row].departureDate.isEmpty)){
            
            print("Tag Count: \(AllTreks.treksArray[indexPath.row].tags.count)")
            

            //Showing the trek name
            cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testGold])

        
        //If there is a destination but not departure date
        }else if (AllTreks.treksArray[indexPath.row].destination.isEmpty == false && (AllTreks.treksArray[indexPath.row].departureDate.isEmpty)){
            
            //Adding Trek name
            cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +

            //Adding Trek destination
            NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
       
            
        //If there is both dep and dest present
        }else if (AllTreks.treksArray[indexPath.row].destination.isEmpty == false && AllTreks.treksArray[indexPath.row].departureDate.isEmpty == false) {
            
            
            //If there is no return
            if (AllTreks.treksArray[indexPath.row].returnDate.isEmpty){
                
                //Adding Trek name
                cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +
                    
                //Adding Trek destination
                NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont]) +

                //Adding the departure/return dates
                NSAttributedString(string: "\n\(AllTreks.treksArray[indexPath.row].departureDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
            }
                
            //Else if there is a return
            else{
                //Adding Trek name
                cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +
                    
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
                cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +

                //Adding the departure date
                NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].departureDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.secondaryHeaderFont])
            }
                
            //Else if there is a return
            else{
                
                
                //Adding Trek name
                cell.textLabel?.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +

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
            imageView.alpha = 0.60
            
        

        }
        cell.backgroundColor = SingletonStruct.testWhite
        cell.backgroundView = imageView
        cell.textLabel?.textColor = SingletonStruct.testBlack
        

        return cell
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
    
    //For deleting from the table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AllTreks.treksArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            checkForTreks()
        
        }
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



