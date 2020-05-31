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
        
        navigationController!.navigationBar.barTintColor = SingletonStruct.testBlack
        navigationController!.navigationBar.tintColor = SingletonStruct.testGold
        
        let closeButton = UIBarButtonItem(image: UIImage(named: "x"), style: .plain, target: self, action: #selector(ViewTrekViewController.closeTrek))
    
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(ViewTrekViewController.openSettings))
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = settingsButton
        navigationItem.title = "TrekPack"
          
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
           view.addSubview(trekName)
           trekName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
           trekName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
           trekName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
    


       }
    
    
    
    
    
}
