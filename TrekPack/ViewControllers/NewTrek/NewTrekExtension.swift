//
//  NewTrekExtension.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-02-01.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

extension NewTrekViewController{
    
    
    func setupUI(){
        
        //Picker properties
//        inputDeparture.inputView = datePicker
//        inputReturn.inputView = datePicker
//        tagsLabel.inputView = tagPicker
        
        //Trek name stack view + contents
        view.addSubview(trekNameVStack)
        trekNameVStack.addArrangedSubview(trekNameLabel)
        trekNameVStack.addArrangedSubview(inputTrekName)
        trekNameVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        trekNameVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        trekNameVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width/18).isActive = true
        inputTrekName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        inputTrekName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        
        //Trek destination stack view + contents
        view.addSubview(trekDestVStack)
        trekDestVStack.addArrangedSubview(trekDestinationLabel)
        trekDestVStack.addArrangedSubview(inputTrekDestination)
        trekDestVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        trekDestVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        trekDestVStack.topAnchor.constraint(equalTo: trekNameVStack.bottomAnchor, constant: view.frame.width/18).isActive = true
        inputTrekDestination.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        inputTrekDestination.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        
        //Trek departure stack view + contents
        view.addSubview(departureVStack)
        departureVStack.addArrangedSubview(departureLabel)
        departureVStack.addArrangedSubview(inputDeparture)
        departureVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/2 - view.frame.width/32).isActive = true
        departureVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        departureVStack.topAnchor.constraint(equalTo: trekDestVStack.bottomAnchor, constant: view.frame.width/18).isActive = true
        inputDeparture.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/2 - view.frame.width/32).isActive = true
        inputDeparture.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        
        
        //Trek return stack view + contents
        view.addSubview(returnVStack)
        returnVStack.addArrangedSubview(returnLabel)
        returnVStack.addArrangedSubview(inputReturn)
        returnVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        returnVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/2 + view.frame.width/32).isActive = true
        returnVStack.topAnchor.constraint(equalTo: trekDestVStack.bottomAnchor, constant: view.frame.width/18).isActive = true
        inputReturn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        inputReturn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/2 + view.frame.width/32).isActive = true
        
        
        //Trek items stack view + contents
        view.addSubview(itemVStack)
        itemVStack.addArrangedSubview(itemsLabel)
        itemVStack.addArrangedSubview(itemsField)
        itemVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        itemVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        itemVStack.topAnchor.constraint(equalTo: departureVStack.bottomAnchor, constant: view.frame.width/18).isActive = true
        itemsField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        itemsField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        
        
        view.addSubview(tagVStack)
        tagVStack.addArrangedSubview(tagsLabel)
        tagVStack.addArrangedSubview(tagsField)
        tagVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        tagVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        tagVStack.topAnchor.constraint(equalTo: itemVStack.bottomAnchor, constant: view.frame.width/18).isActive = true
        tagsField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        tagsField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true

    
    }
    
    //Setting up the table view
    func setupTableView(){
        
        
//        tagsLabel.inputView = tagPicker

        
        //Basic table properties
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        tableView.layer.cornerRadius = 3
        tableView.isScrollEnabled = false
        
        
        //Table layout properties
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        tableView.contentInsetAdjustmentBehavior = .never
        
        //Image button layour properties
        view.addSubview(imageButton)
        imageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        imageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageButton.widthAnchor.constraint(equalToConstant: imageButton.frame.width).isActive = true
        imageButton.heightAnchor.constraint(equalToConstant: imageButton.frame.width).isActive = true
        
        
        view.addSubview(clearImageButton)
        clearImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -imageButton.frame.width/2.0).isActive = true
        clearImageButton.topAnchor.constraint(equalTo: imageButton.topAnchor, constant: -imageButton.frame.height/16).isActive = true
        clearImageButton.widthAnchor.constraint(equalToConstant: clearImageButton.frame.width).isActive = true
        clearImageButton.heightAnchor.constraint(equalToConstant: clearImageButton.frame.height).isActive = true
        hideClearButton()
       
        
        //If a pre-existing trek has an image selected
        if (AllTreks.makingNewTrek == true){
//            hideClearButton()
        }else if (AllTreks.treksArray[AllTreks.selectedTrek].image != UIImage(named: "sm")){
            showClearButton()
        }
        
      
               

        
        
        
        
        
    }
    
    func showClearButton(){
        clearImageButton.isHidden = false
        clearImageButton.isEnabled = true
    }
    
    func hideClearButton(){
        clearImageButton.isHidden = true
        clearImageButton.isEnabled = false
    }
   

    //TODO: Fix this where nav bar unselectable after cell vc return on back button
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if (indexPath.row == 0){
            inputTrekName.becomeFirstResponder()
            
        }else if (indexPath.row == 1){
            inputTrekDestination.becomeFirstResponder()
        }else if (indexPath.row == 2){
            inputDeparture.becomeFirstResponder()
        }else if (indexPath.row == 3){
            inputReturn.becomeFirstResponder()
        }else if (indexPath.row == 4){
            
            let itemVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NTIP")
            let navController = UINavigationController(rootViewController: itemVC)
                
            present(navController, animated: true)

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
//        cell.backgroundColor = SingletonStruct.backgroundColor2
        cell.backgroundColor = .clear
        
        
        
        
        if (indexPath.row == 0){
            
            trekNameVStack.addArrangedSubview(trekNameLabel)
            trekNameVStack.addArrangedSubview(inputTrekName)
        
            cell.addSubview(trekNameVStack)
            
            trekNameVStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            trekNameVStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
            trekNameVStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            
            trekNameLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            trekNameLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            
            inputTrekName.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputTrekName.leadingAnchor.constraint(equalTo: trekNameLabel.trailingAnchor).isActive = true

        }else if (indexPath.row == 1){
            
            trekDestVStack.addArrangedSubview(trekDestinationLabel)
            trekDestVStack.addArrangedSubview(inputTrekDestination)
            
            cell.addSubview(trekDestVStack)
            
            trekDestVStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            trekDestVStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
            trekDestVStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true

            trekDestinationLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            trekDestinationLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            
            inputTrekDestination.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputTrekDestination.leadingAnchor.constraint(equalTo: trekDestinationLabel.trailingAnchor).isActive = true
        
            
        }else if (indexPath.row == 2){
            
//            departureHStack.addArrangedSubview(departureLabel)
//            departureHStack.addArrangedSubview(inputDeparture)
//            
//            cell.addSubview(departureHStack)
//            
//            departureHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
//            departureHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
//            departureHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true

            departureLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            departureLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true

            
            inputDeparture.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputDeparture.leadingAnchor.constraint(equalTo: departureLabel.trailingAnchor).isActive = true
  
        }else if (indexPath.row == 3){
            returnVStack.addArrangedSubview(returnLabel)
            returnVStack.addArrangedSubview(inputReturn)
            
            cell.addSubview(returnVStack)
            
            returnVStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            returnVStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
            returnVStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true

            returnLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            returnLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true

            
            inputReturn.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputReturn.leadingAnchor.constraint(equalTo: returnLabel.trailingAnchor).isActive = true
            
        }else if (indexPath.row == 4){
//            itemHStack.addArrangedSubview(itemsLabel)
//            itemHStack.addArrangedSubview(itemsLabel)
//
//            cell.addSubview(itemHStack)
//
//            itemHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
//            itemHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
//            itemHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
//
//            itemsLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
//            itemsLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
//
//            
//            itemsLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
//            itemsLabel.leadingAnchor.constraint(equalTo: itemsLabel.trailingAnchor).isActive = true
            
         
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
//            tagHStack.addArrangedSubview(tagsIcon)
//            tagHStack.addArrangedSubview(tagsLabel)
//
//            cell.addSubview(tagHStack)
//
//            tagHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
//            tagHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 5).isActive = true
//            tagHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
//
//            tagsIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
//            tagsIcon.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
//
//            tagsLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
//            tagsLabel.leadingAnchor.constraint(equalTo: tagsIcon.trailingAnchor).isActive = true
            
           
            
            
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
