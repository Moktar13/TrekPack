//
//  TreksNavController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class TreksNavController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        navigationBar.barTintColor = ColorStruct.titleColor
        navigationBar.tintColor = ColorStruct.pinkColor
    
        let logoutButton = UIBarButtonItem(image: UIImage(named: "log-out"), style: .plain, target: nil, action: #selector(TreksNavController.onLogout))
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: nil, action: #selector(TreksNavController.onFilter))
    
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.title = "My Treks"
        navigationItem.rightBarButtonItem = filterButton
    
        navigationBar.setItems([navigationItem], animated: true)
        
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorStruct.pinkColor]

    }
    
    @objc func onLogout(){
        
    }
    
    @objc func onFilter(){
        
    }

}
