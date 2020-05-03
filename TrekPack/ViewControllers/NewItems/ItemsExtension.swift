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
        
       // tableView.backgroundColor = ColorStruct.testTransparent
        tableView.tintColor = .clear
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.separatorColor = .black
        
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.preservesSuperviewLayoutMargins = false
       
      
        tableView.backgroundColor = .clear
      

        
        view.addSubview(tableView)
        
        tableView.layer.borderColor = UIColor.clear.cgColor
        
        tableView.layer.cornerRadius = 3
        tableView.layer.borderWidth = 3

      
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        
       
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray[trekToWorkWith-1].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        

        cell.textLabel?.attributedText = NSAttributedString(string: AllTreks.treksArray[trekToWorkWith-1].items[indexPath.row], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: ColorStruct.titleColor])

        cell.backgroundColor = .clear
     
        cell.selectionStyle = .none
        
        ///Todo: make bottom of table view rounded so that the cell looks rounded
//        if (indexPath.row >= 2){
//            tableView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
//        }
        
        
        
        
        return cell
    }
    
    
    
    //Setting height of each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
 
    
}

