//
//  NavigationController.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-25.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    
    fileprivate func setupNavBar(){
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(doCancel))
        
        let navigationItem = UINavigationItem()
        navigationItem.leftBarButtonItem = cancelBtn
        
        
        self.navigationBar.setItems([navigationItem], animated: false)
        self.navigationBar.barTintColor = ColorStruct.titleColor
        self.navigationBar.tintColor = ColorStruct.backgroundColor
    }
    
    @objc func doCancel(){
        
    }
    
}
