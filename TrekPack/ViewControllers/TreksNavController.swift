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
        navigationBar.barTintColor = ColorStruct.subColor
        navigationBar.tintColor = ColorStruct.titleColor
    
        let logoutButton = UIBarButtonItem(barButtonSystemItem: .reply, target: nil, action: #selector(TreksNavController.onLogout))
        
        logoutButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ColorStruct.titleColor], for: .normal)
        
        let filterButton = UIBarButtonItem(barButtonSystemItem: .organize, target: nil, action: #selector(TreksNavController.onFilter))
        
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItem = filterButton
    
        navigationBar.setItems([navigationItem], animated: true)

    }
    
    @objc func onLogout(){
        
    }
    
    @objc func onFilter(){
        
    }

}
