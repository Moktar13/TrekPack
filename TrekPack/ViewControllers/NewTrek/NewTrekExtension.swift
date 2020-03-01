//
//  NewTrekExtension.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-02-01.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

extension NewTrekViewController{
    
    //Setting up the table view
    func setupTableView(){
        
        tableView.isScrollEnabled = false
        
        inputDeparture.inputView = datePicker
        inputReturn.inputView = datePicker
        
        tagsLabel.inputView = tagPicker

        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        tableView.layer.cornerRadius = 3
        
        
        view.addSubview(tableView)
        
    
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
       // tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       // tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        //tableView.heightAnchor.constraint(equalToConstant: view.frame.height/2 + view.frame.height/4 + 20).isActive = true
        
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        
    }

    //TODO: Fix this where nav bar unselectable after cell vc return on back button
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if (indexPath.row == 0){
            inputTripName.becomeFirstResponder()
            
        }else if (indexPath.row == 1){
            inputTripDestination.becomeFirstResponder()
        }else if (indexPath.row == 2){
            inputDeparture.becomeFirstResponder()
        }else if (indexPath.row == 3){
            inputReturn.becomeFirstResponder()
        }else if (indexPath.row == 4){
            
            //performSegue(withIdentifier: "showItems", sender: indexPath.row)
            
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "NTPage1") as! ItemPageViewController
          
//            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NTPage1") as? ItemPageViewController {
//                 if let navigator = navigationController{
//                    //navigator.pushViewController(viewController, animated: true)
//                    //navigator.present(viewController, animated: true, completion: nil)
//                    navigator.presentInFullScreen(viewController, animated: true)
//                }
//            }
//
//
        //let itemPage = ItemPageViewController()
            
    let testNavCon:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemNavCon") as! UINavigationController
            
        
        //self.navigationController?.pushViewController(testNavCon, animated: true)
            
        present(testNavCon, animated: true)
//
        }else if (indexPath.row == 5){
            tagsLabel.becomeFirstResponder()
        }
    }
    
    //Setting number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    //Setting each cell to its own conten
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
       //tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
        
        
        cell.selectionStyle = .none
//        cell.backgroundColor = ColorStruct.backgroundColor2
        cell.backgroundColor = .clear
        
        
        
        
        if (indexPath.row == 0){
            
            tripNameHStack.addArrangedSubview(nameLabel)
            tripNameHStack.addArrangedSubview(inputTripName)
        
            cell.addSubview(tripNameHStack)
            
            tripNameHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            tripNameHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
            tripNameHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            
            nameLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            nameLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            
            
            
            inputTripName.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputTripName.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true

           
            
          

        }else if (indexPath.row == 1){
            
            tripDestHStack.addArrangedSubview(destinationLabel)
            tripDestHStack.addArrangedSubview(inputTripDestination)
            
            cell.addSubview(tripDestHStack)
            
            tripDestHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            tripDestHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
            tripDestHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true

            destinationLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            destinationLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            
            inputTripDestination.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputTripDestination.leadingAnchor.constraint(equalTo: destinationLabel.trailingAnchor).isActive = true
        
            
        }else if (indexPath.row == 2){
            
            departureHStack.addArrangedSubview(departureLabel)
            departureHStack.addArrangedSubview(inputDeparture)
            
            cell.addSubview(departureHStack)
            
            departureHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            departureHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
            departureHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true

            departureLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            departureLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true

            
            inputDeparture.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputDeparture.leadingAnchor.constraint(equalTo: departureLabel.trailingAnchor).isActive = true
  
        }else if (indexPath.row == 3){
            returnHStack.addArrangedSubview(returnLabel)
            returnHStack.addArrangedSubview(inputReturn)
            
            cell.addSubview(returnHStack)
            
            returnHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            returnHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
            returnHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true

            returnLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            returnLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true

            
            inputReturn.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputReturn.leadingAnchor.constraint(equalTo: returnLabel.trailingAnchor).isActive = true
            
        }else if (indexPath.row == 4){
            itemHStack.addArrangedSubview(itemsIcon)
            itemHStack.addArrangedSubview(itemsLabel)
            
            cell.addSubview(itemHStack)
            
            itemHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            itemHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
            itemHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true

            itemsIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
            itemsIcon.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            
            
            itemsLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            itemsLabel.leadingAnchor.constraint(equalTo: itemsIcon.trailingAnchor).isActive = true
            
         
            //Todo: Add new indicator here!
            cell.accessoryType = .disclosureIndicator
            
            //tableView.bottomAnchor.constraint(equalTo: itemsLabel.bottomAnchor).isActive = true
            
            //            let sentImage = UIImage(named: "plus")
            //            let sentImageView = UIImageView(image: sentImage)
            //            sentImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            //            sentImageView.tintColor = .none
            //            sentImageView.backgroundColor = .clear
            //            cell.accessoryView = sentImageView
            
            
     
        }else if (indexPath.row == 5){
            tagHStack.addArrangedSubview(tagsIcon)
            tagHStack.addArrangedSubview(tagsLabel)
            
            cell.addSubview(tagHStack)
            
            tagHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            tagHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
            tagHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            
            tagsIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
            tagsIcon.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            
            tagsLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            tagsLabel.leadingAnchor.constraint(equalTo: tagsIcon.trailingAnchor).isActive = true
            
           
            
            
//            tableView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
            
//            let sentImage = UIImage(named: "up")
//            let sentImageView = UIImageView(image: sentImage)
//
//            sentImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//            sentImageView.tintColor = .none
//            sentImageView.backgroundColor = .clear
//
//            cell.accessoryView = sentImageView
        
        }
        
//        else{
//              cell.textLabel?.text = ""
//        }
        
       
        return cell
    }
    
    //Setting height of each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


class AutomaticHeightTableView: UITableView {

  override var contentSize: CGSize {
    didSet {
      self.invalidateIntrinsicContentSize()
    }
  }

  override var intrinsicContentSize: CGSize {
    self.layoutIfNeeded()
    return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
  }

}
