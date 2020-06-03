//
//  ViewTrekExe.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-27.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit


//EXTENSION FOR MAIN UI STUFF
extension ViewTrekViewController{
    
    
    //NAVBAR
    func setupNavBar(){
        
        navigationController!.navigationBar.barTintColor = SingletonStruct.testBlue
        navigationController!.navigationBar.tintColor = SingletonStruct.testWhite
        
        let closeButton = UIBarButtonItem(image: UIImage(named: "x"), style: .plain, target: self, action: #selector(ViewTrekViewController.closeTrek))
    
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(ViewTrekViewController.openSettings))
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = settingsButton
        
        let navTitle = "\(AllTreks.treksArray[AllTreks.selectedTrek].tags[0]) \(AllTreks.treksArray[AllTreks.selectedTrek].tags[1]) \(AllTreks.treksArray[AllTreks.selectedTrek].tags[2])"
        
        
        if (navTitle.trimmingCharacters(in: .whitespaces).isEmpty == true){
            navigationItem.title = "TrekPack"
        }else{
            navigationItem.title = navTitle
        }
        
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SingletonStruct.testWhite, NSAttributedString.Key.font: SingletonStruct.navTitle]
      }
    
    //SCREEN
    func setupScreen(){
        
           
        //IMG VIEW
        view.addSubview(imgView)
        imgView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imgView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
           
        //TREK INFO
        view.addSubview(trekInformation)
        trekInformation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/24).isActive = true
        trekInformation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/24).isActive = true
        trekInformation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
        trekInformation.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        trekInformation.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(trekItem)
        trekItem.topAnchor.constraint(equalTo: trekInformation.bottomAnchor, constant: view.frame.width/16).isActive = true
        trekItem.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/24).isActive = true
        trekItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/24).isActive = true
        
        
        
        
        
        
        view.addSubview(itemsTableView)
        itemsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/24).isActive = true
        itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/24).isActive = true
        itemsTableView.topAnchor.constraint(equalTo: trekItem.bottomAnchor).isActive = true
        
        
        if (heightID == 1){
            itemsTableView.heightAnchor.constraint(equalToConstant: view.frame.height/2 + view.frame.height/16).isActive = true
        }else if (heightID == 2){
            itemsTableView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        }else if (heightID == 3){
            itemsTableView.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.width/8).isActive = true
        }
        
    


       }
    
    
    
    
    
}
