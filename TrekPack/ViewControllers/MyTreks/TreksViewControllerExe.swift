//
//  TreksViewControllerExe.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-06-01.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit

extension TreksTableViewController {
    
    //NAV BAR STUFF
    func setupNavigationBar(){
        navigationController!.navigationBar.barTintColor = SingletonStruct.testBlue
        navigationController!.navigationBar.tintColor = SingletonStruct.newWhite
    
        let logoutButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(TreksTableViewController.onLogout))
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "sliders"), style: .plain, target: self, action: #selector(TreksTableViewController.onFilter))
        
    
    
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.title = "My Treks"
        
        navigationController!.navigationBar.setItems([navigationItem], animated: true)
        
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: SingletonStruct.navTitle]

    }
    @objc func onLogout(){
        print("Shite")
    }
    @objc func onFilter(){
        
    }

    
}
