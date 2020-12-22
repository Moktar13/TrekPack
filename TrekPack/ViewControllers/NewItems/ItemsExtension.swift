//
//  ItemsExtension.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-02-01.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

//~ This extension contains table view functions ~
extension ItemPageViewController{
    
    //MARK: setupTableView
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
    
    //MARK: editingStyle
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //If the user deletes an item
        if editingStyle == .delete {
            
            //If the user is making a new trek then remove the item and crosses from the trek at the end of the all treks array
            if (SingletonStruct.makingNewTrek == true){
                SingletonStruct.allTreks[SingletonStruct.allTreks.count-1].items.remove(at: indexPath.row)
                SingletonStruct.allTreks[SingletonStruct.allTreks.count-1].crosses.remove(at: indexPath.row)
            //else delete the item and crosses from the temp trek
            }else{
                SingletonStruct.tempTrek.items.remove(at: indexPath.row)
                SingletonStruct.tempTrek.crosses.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    //MARK: numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (SingletonStruct.makingNewTrek == true)
        {
            return SingletonStruct.allTreks[SingletonStruct.allTreks.count-1].items.count
        }else{
            return SingletonStruct.tempTrek.items.count
        }
    }
    
    //MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        //If the user is making a new trek, then retrieve the item from the end of the trek at the end of the treks array (most recently added trek)
        if (SingletonStruct.makingNewTrek == true){
            cell.textLabel?.attributedText = NSAttributedString(string: SingletonStruct.allTreks[trekToWorkWith-1].items[indexPath.row], attributes: [NSAttributedString.Key.font: SingletonStruct.inputItemFont, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])
            
        //else get the item from the temp trek (most recently selected trek)
        }else{
            cell.textLabel?.attributedText = NSAttributedString(string: SingletonStruct.tempTrek.items[indexPath.row], attributes: [NSAttributedString.Key.font: SingletonStruct.inputItemFont, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])
        }
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
    
        return cell
    }
    
    //MARK: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
