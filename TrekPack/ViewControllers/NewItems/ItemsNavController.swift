//
//  ItemsNavController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-22.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class ItemNavController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigationBar()
    }
    
    
    private func setupNavigationBar(){
        navigationBar.barTintColor = ColorStruct.subColor
        navigationBar.tintColor = ColorStruct.titleColor
        
//        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(NewTrekNavController.onCancel))
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: #selector(NewTrekNavController.onCancel))
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(NewTrekNavController.onSave))
    
//        let saveButton = UIBarButtonItem(barButtonSystemItem: ., target: nil, action: #selector(TreksNavController.onFilter))
        
        
        
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = "Items"
        
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorStruct.titleColor]
       
        navigationBar.setItems([navigationItem], animated: true)
    }
    
    
  
    
}
