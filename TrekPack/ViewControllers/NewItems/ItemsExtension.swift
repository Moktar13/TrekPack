//
//  ItemsExtension.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-02-01.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

extension ItemPageViewController{
    
    //SETTING ATTRIBUTES FOR THE TABLE VIEW
    func setupTableView(){
        itemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        itemsTableView.tableFooterView = UIView()
        itemsTableView.translatesAutoresizingMaskIntoConstraints = false
        itemsTableView.separatorColor = SingletonStruct.testBlack
        itemsTableView.separatorInset = .zero
        itemsTableView.layoutMargins = .zero
        itemsTableView.preservesSuperviewLayoutMargins = false
        itemsTableView.layer.borderColor = SingletonStruct.testBlue.cgColor
        itemsTableView.layer.borderWidth = 1
        itemsTableView.layer.cornerRadius = 10
        itemsTableView.contentInsetAdjustmentBehavior = .never
        itemsTableView.backgroundColor = SingletonStruct.testWhite.withAlphaComponent(0.80)
    }
    
    //For deleting from the table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if (AllTreks.makingNewTrek == true){
                AllTreks.treksArray[AllTreks.treksArray.count-1].items.remove(at: indexPath.row)
                AllTreks.treksArray[AllTreks.treksArray.count-1].crosses.remove(at: indexPath.row)
            }else{
                SingletonStruct.tempTrek.items.remove(at: indexPath.row)
                SingletonStruct.tempTrek.crosses.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .bottom)
        
        }
    }
    
    //Number of sections in the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Number of items in the table view -- number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if (AllTreks.makingNewTrek == true)
        {
            return AllTreks.treksArray[AllTreks.treksArray.count-1].items.count
        }else{
            return SingletonStruct.tempTrek.items.count
        }
        
        
    }
    
    //Going through each cell and populating them with the data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        
        if (AllTreks.makingNewTrek == true){
            cell.textLabel?.attributedText = NSAttributedString(string: AllTreks.treksArray[trekToWorkWith-1].items[indexPath.row], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])
        }else{
            cell.textLabel?.attributedText = NSAttributedString(string: SingletonStruct.tempTrek.items[indexPath.row], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])
        }
        
        

        cell.backgroundColor = .clear
        
        cell.textLabel?.font = SingletonStruct.inputItemFont
        
        
     
        cell.selectionStyle = .none
        

    
        return cell
    }
    
    //Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

