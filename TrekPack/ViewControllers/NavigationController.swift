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
        
        let saveBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: nil, action: #selector(doSave))
        
        cancelBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ColorStruct.titleColor, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        
        saveBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemPink, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        
        
        navigationItem.leftBarButtonItem = cancelBtn
        navigationItem.rightBarButtonItem = saveBtn
        
        
        self.navigationBar.setItems([navigationItem], animated: false)
        
        self.navigationBar.barTintColor = ColorStruct.backgroundColor
        self.navigationBar.tintColor = ColorStruct.titleColor
    }
    
    @objc func doCancel(){
        
    }
    
    @objc func doSave(){
        print("save")
    }
    
}
