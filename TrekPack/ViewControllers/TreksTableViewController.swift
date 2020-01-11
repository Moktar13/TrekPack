//
//  TreksTableViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class TreksTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var tableView = UITableView()
    
    //Todo: Will contain all the users treks
    let trips = ["My Trip 1", ""]

    let cellReuseID = "cell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        view.backgroundColor = ColorStruct.backgroundColor
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        
        tableView.tableFooterView = UIView()
        
        setupTableView()
    }
    
   
    func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
         
        tableView.contentInset = .zero
        tableView.separatorColor = ColorStruct.backgroundColor
        
        
        view.addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        
        
        //If its the last item in the array (array should never be in empty in this case)
        if (indexPath.row == trips.count-1){
            
            let addSignText = NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font
                : UIFont.systemFont(ofSize: 23)])
            let addText = NSAttributedString(string: " New Trek", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19)])
    
            let mutableString = NSMutableAttributedString()
            
            mutableString.append(addSignText)
            mutableString.append(addText)
            
            cell.textLabel?.attributedText = mutableString
            cell.textLabel?.textColor = ColorStruct.subColor
            
        }else{
            
            let tripName = NSAttributedString(string: trips[indexPath.row], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19)])
            
            cell.textLabel?.attributedText = tripName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.row == trips.count-1){
            
            let firstVC:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewTrekNavCon") as! UINavigationController
            
            presentInFullScreen(firstVC, animated: true)
        
        }else{
            print("Some trip selected")
        }
    }
    
}
