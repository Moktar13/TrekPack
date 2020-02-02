//
//  ItemsExtension.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-02-01.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

extension ItemPageViewController{
    
    func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        
      

        
        view.addSubview(tableView)
        
        tableView.layer.borderColor = UIColor.clear.cgColor
        tableView.layer.borderWidth = 2
        tableView.layer.cornerRadius = 3
        
        tableView.contentInset = UIEdgeInsets(top: 0,left: -7,bottom: 0,right:0 )
    
       
       // tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
     
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       
        
       
        
   
        
        
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        

        cell.textLabel?.attributedText = NSAttributedString(string: itemsArr[indexPath.row], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: ColorStruct.titleColor])


        
//        cell.layer.borderColor = UIColor.clear.cgColor
//        cell.layer.borderWidth = 10
//        cell.layer.cornerRadius = 4
        cell.backgroundColor = ColorStruct.backgroundColor2
    
        
        
        return cell
    }
    
    //Setting height of each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
