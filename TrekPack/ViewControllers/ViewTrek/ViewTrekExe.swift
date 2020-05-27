//
//  ViewTrekExe.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-27.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit

extension ViewTrekViewController{
    
    
    //NAVBAR
    func setupNavBar(){
          
          navigationController!.navigationBar.barTintColor = SingletonStruct.titleColor
          navigationController!.navigationBar.tintColor = SingletonStruct.pinkColor
        
            let backButton:UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(ViewTrekViewController.goBack))
    
          let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil )
        
          navigationItem.leftBarButtonItem = backButton
          navigationItem.rightBarButtonItem = editButton
          navigationItem.title = "TrekPack"
          
          navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SingletonStruct.pinkColor]
      }
    
    
    
    
}
