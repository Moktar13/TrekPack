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
    
    //MARK: setupNavigationBar
    func setupNavigationBar(){
        
        //Nav bar buttons
//        let logoutButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(TreksTableViewController.onLogout))
//        let filterButton = UIBarButtonItem(image: UIImage(named: "sliders"), style: .plain, target: self, action: #selector(TreksTableViewController.onFilter))
    
        //NavigationItem settings
//        navigationItem.leftBarButtonItem = logoutButton
//        navigationItem.rightBarButtonItem = filterButton
        navigationItem.title = "My Treks"
        
        //Navigation Contoller settings
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = SingletonStruct.testBlue
        navigationController?.navigationBar.tintColor = SingletonStruct.newWhite
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: SingletonStruct.navTitle, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setItems([navigationItem], animated: true)
    }
    
    //MARK: onLogout
    @objc func onLogout(){
        print("onLogout")
    }
    
    //MARK: onFilter
    @objc func onFilter(){
        navigationController?.pushViewController(TestViewController(), animated: true)
    }
}
