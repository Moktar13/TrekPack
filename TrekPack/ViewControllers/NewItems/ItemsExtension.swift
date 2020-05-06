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
        itemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        itemsTableView.tableFooterView = UIView()
        
        //Enabling the editing for the table
//        tableView.allowsSelectionDuringEditing = true
        
        
        itemsTableView.tintColor = .clear
        
        itemsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        itemsTableView.separatorColor = .black
        
        itemsTableView.separatorInset = .zero
        itemsTableView.layoutMargins = .zero
        itemsTableView.preservesSuperviewLayoutMargins = false
       
        itemsTableView.backgroundColor = .clear
    
        view.addSubview(itemsTableView)
        
        itemsTableView.layer.borderColor = UIColor.clear.cgColor
        
        itemsTableView.layer.cornerRadius = 3
        itemsTableView.layer.borderWidth = 3

      
        itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        itemsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        
        itemsTableView.contentInsetAdjustmentBehavior = .never
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AllTreks.treksArray[AllTreks.treksArray.count-1].items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray[AllTreks.treksArray.count-1].items.count
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

