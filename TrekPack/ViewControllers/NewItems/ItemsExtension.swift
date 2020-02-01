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
        tableView.backgroundColor = ColorStruct.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = ColorStruct.titleColor
        
        view.addSubview(tableView)
        
        tableView.layer.borderColor = ColorStruct.titleColor.cgColor
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 4
        
        tableView.contentInset = UIEdgeInsets(top: 0,left: -7,bottom: 0,right:0 )
    
       
       // tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
     
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
       
        
        tableView.backgroundColor = ColorStruct.backgroundColor
        
        
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
        
        cell.textLabel?.text = itemsArr[indexPath.row]
        
        cell.backgroundColor = ColorStruct.backgroundColor
        
        
        
        return cell
    }
    
    //Setting height of each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
