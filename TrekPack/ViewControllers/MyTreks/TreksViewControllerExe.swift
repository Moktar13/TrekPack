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
        navigationController!.navigationBar.barTintColor = SingletonStruct.testBlack
        navigationController!.navigationBar.tintColor = SingletonStruct.testGold
    
        let logoutButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(TreksTableViewController.onLogout))
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "sliders"), style: .plain, target: self, action: #selector(TreksTableViewController.onFilter))
        
    
    
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.title = "My Treks"
        navigationItem.rightBarButtonItem = filterButton
        
        navigationController!.navigationBar.setItems([navigationItem], animated: true)
        
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SingletonStruct.testWhite, NSAttributedString.Key.font: SingletonStruct.navTitle]

    }
    @objc func onLogout(){
        print("Shite")
    }
    @objc func onFilter(){
        
    }

    
}
