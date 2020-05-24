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

        //Trek name stack view + contents
        view.addSubview(trekNameVStack)
        trekNameVStack.addArrangedSubview(trekNameLabel)
        trekNameVStack.addArrangedSubview(inputTrekName)
        trekNameVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        trekNameVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        trekNameVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width/16).isActive = true
        inputTrekName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        inputTrekName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        inputTrekName.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        //Trek destination stack view + contents
        view.addSubview(trekDestVStack)
        trekDestVStack.addArrangedSubview(trekDestinationLabel)
        trekDestVStack.addArrangedSubview(inputTrekDestination)
        trekDestVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        trekDestVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        trekDestVStack.topAnchor.constraint(equalTo: inputTrekName.bottomAnchor, constant: view.frame.width/16).isActive = true
        inputTrekDestination.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        inputTrekDestination.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        inputTrekDestination.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        //Trek departure stack view + contents
        view.addSubview(departureVStack)
        departureVStack.addArrangedSubview(departureLabel)
        departureVStack.addArrangedSubview(inputDeparture)
        departureVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/2 - view.frame.width/32).isActive = true
        departureVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        departureVStack.topAnchor.constraint(equalTo: trekDestVStack.bottomAnchor, constant: view.frame.width/16).isActive = true
        inputDeparture.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/2 - view.frame.width/32).isActive = true
        inputDeparture.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        inputDeparture.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
 
        //Trek return stack view + contents
        view.addSubview(returnVStack)
        returnVStack.addArrangedSubview(returnLabel)
        returnVStack.addArrangedSubview(inputReturn)
        returnVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        returnVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/2 + view.frame.width/32).isActive = true
        returnVStack.topAnchor.constraint(equalTo: trekDestVStack.bottomAnchor, constant: view.frame.width/16).isActive = true
        inputReturn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        inputReturn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/2 + view.frame.width/32).isActive = true
        inputReturn.heightAnchor.constraint(equalToConstant: 25).isActive = true

        //Trek items stack view + contents
        view.addSubview(itemVStack)
        itemVStack.addArrangedSubview(itemsLabel)
        itemVStack.addArrangedSubview(itemsField)
        itemVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        itemVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        itemVStack.topAnchor.constraint(equalTo: departureVStack.bottomAnchor, constant: view.frame.width/16).isActive = true
        itemsField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        itemsField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        itemsField.heightAnchor.constraint(equalToConstant: 25).isActive = true


        //Trek tags stack view + contents
        view.addSubview(tagVStack)
        tagVStack.addArrangedSubview(tagsLabel)
        tagVStack.addArrangedSubview(tagsField)
        tagVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        tagVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        tagVStack.topAnchor.constraint(equalTo: itemVStack.bottomAnchor, constant: view.frame.width/16).isActive = true
        tagsField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        tagsField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        tagsField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        view.addSubview(imageButton)
        
//        let tagFieldBottomAnchor:NSLayoutAnchor = tagsField.bottomAnchor
        
        
        imageButton.topAnchor.constraint(equalTo: tagVStack.bottomAnchor, constant: view.frame.width/14 ).isActive = true
//        imageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/14).isActive = true
        imageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageButton.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        imageButton.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
       

    }
    
    
        
      
               


    func showClearButton(){
        clearImageButton.isHidden = false
        clearImageButton.isEnabled = true
    }
    
    func hideClearButton(){
        clearImageButton.isHidden = true
        clearImageButton.isEnabled = false
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
