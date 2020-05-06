//
//  TreksTableViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class TreksTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var tableView = AutomaticHeightTableView()
    
    //Todo: Will contain all the users treks
    let trips:[String] = []

    let cellReuseID = "cell"
    
    override func viewDidAppear(_ animated: Bool) {
        print("LOADING \(AllTreks.treksArray.count) treks")
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        ///BACKGROUND
        view.viewAddBackground(imgName: "sm")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        
        tableView.tableFooterView = UIView()
        
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        navigationController!.navigationBar.barTintColor = ColorStruct.titleColor
        navigationController!.navigationBar.tintColor = ColorStruct.pinkColor
    
        let logoutButton = UIBarButtonItem(image: UIImage(named: "log-out"), style: .plain, target: nil, action: #selector(TreksTableViewController.onLogout))
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: nil, action: #selector(TreksTableViewController.onFilter))
    
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.title = "My Treks"
        navigationItem.rightBarButtonItem = filterButton
    
        navigationController!.navigationBar.setItems([navigationItem], animated: true)
        
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorStruct.pinkColor]

    }
    
    @objc func onLogout(){
        
    }
    
    @objc func onFilter(){
        
    }

    
   
    func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
         
        tableView.contentInset = .zero
        tableView.separatorColor = .black
        tableView.backgroundColor = .clear
        
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        print("Curr Row: \(indexPath.row)")
        
        cell.backgroundColor = .clear
        
        if (indexPath.row == AllTreks.treksArray.count){
            
            let addSignText = NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font
                                : UIFont.boldSystemFont(ofSize: 23)])
            let addText = NSAttributedString(string: " New Trek", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)])
            
            let mutableString = NSMutableAttributedString()
                    
            mutableString.append(addSignText)
            mutableString.append(addText)
                
            cell.textLabel?.attributedText = mutableString
            cell.textLabel?.textColor =  ColorStruct.titleColor
            
        }else{

            let tripName = NSAttributedString(string: "\(AllTreks.treksArray[indexPath.row].name)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19)])
                        
//            cell.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.75)
        
            cell.textLabel?.attributedText = tripName
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        ///Todo: clean up this if statement
        if (indexPath.row == AllTreks.treksArray.count){
            
            //Getting the view controller and repspective nav controller and then presenting the navigation controller in full screen
            let firstVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NTVC")
            let navController = UINavigationController(rootViewController: firstVC)
            self.presentInFullScreen(navController, animated:true, completion: nil)
            
            print("Adding new trek")
        
        }else{
            
            let firstVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VTC")
            let navController = UINavigationController(rootViewController: firstVC)
            self.presentInFullScreen(navController, animated:true, completion: nil)
            
            AllTreks.selectedTrek = indexPath.row
            
            print("Some trip selected")
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

extension UIViewController {
  func presentInFullScreen(_ viewController: UIViewController,
                           animated: Bool,
                           completion: (() -> Void)? = nil) {
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: animated, completion: completion)
  }
}

