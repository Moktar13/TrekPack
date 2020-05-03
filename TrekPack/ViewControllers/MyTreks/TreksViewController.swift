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
        
        ///BAKGROUND
        view.viewAddBackground(imgName: "sm")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        
        tableView.tableFooterView = UIView()
        
        setupTableView()
    }
    
   
    func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
         
        tableView.contentInset = .zero
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        
        
        
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        
        print("Curr Row: \(indexPath.row)")
        
        cell.backgroundColor = .clear
    
        
        //If its the last item in the array (array should never be in empty in this case)
        if (indexPath.row+1 == AllTreks.treksArray.count || AllTreks.treksArray.count-1 == -1){
            
            let addSignText = NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font
                : UIFont.boldSystemFont(ofSize: 23)])
            let addText = NSAttributedString(string: " New Trek", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 19)])
    
            let mutableString = NSMutableAttributedString()
            
            mutableString.append(addSignText)
            mutableString.append(addText)
            
        
            cell.textLabel?.attributedText = mutableString
            cell.textLabel?.textColor =  ColorStruct.titleColor
            
         
           
        }else{

            
            print("fucking bug")
            
            let tripName = NSAttributedString(string: AllTreks.treksArray[indexPath.row].name, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19)])
            
//            cell.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.75)
            
            cell.textLabel?.attributedText = tripName
            
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        ///Todo: clean up this if statement
        if (indexPath.row == AllTreks.treksArray.count-1 || AllTreks.treksArray.count-1 == -1){
            
            let firstVC:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewTrekNavCon") as! UINavigationController
            
            presentInFullScreen(firstVC, animated: true)
        
        }else{
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

