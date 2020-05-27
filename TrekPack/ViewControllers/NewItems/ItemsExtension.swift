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
        
        itemsTableView.tintColor = .red
        
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
    
    //For deleting from the table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if (AllTreks.makingNewTrek == true){
                AllTreks.treksArray[AllTreks.treksArray.count-1].items.remove(at: indexPath.row)
            }else{
                AllTreks.treksArray[AllTreks.selectedTrek].items.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .top)
        
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
            return AllTreks.treksArray[AllTreks.selectedTrek].items.count
        }
        
        
    }
    
    
    //Going through each cell and populating them with the data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        cell.textLabel?.attributedText = NSAttributedString(string: AllTreks.treksArray[trekToWorkWith-1].items[indexPath.row], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])

        cell.backgroundColor = .clear
        
        cell.textLabel?.font = SingletonStruct.inputItemFont
     
        cell.selectionStyle = .none
        
//        cell.textLabel!.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.5)
    
        return cell
    }
    
    //Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

