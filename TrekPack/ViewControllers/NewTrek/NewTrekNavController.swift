//
//  NewTrekNavController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class NewTrekNavController: UINavigationController {
    
    let hostViewController = NewTrekViewController()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            setupNavigationBar()
        }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.isBeingPresented){
            print("Presenting navigation controller");
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if (self.isBeingDismissed){
            print("Dismissing navigation controller")
        }
    }
        
        
        
        private func setupNavigationBar(){
            navigationBar.barTintColor = ColorStruct.titleColor
            navigationBar.tintColor = ColorStruct.pinkColor
            
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(NewTrekNavController.onCancel))
        
            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(NewTrekNavController.onSave))
            
            
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.title = "My Trek"
            
            
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorStruct.pinkColor]
        
            navigationBar.setItems([navigationItem], animated: true)
            
            

        }
    
        @objc func onSave(){
            print("ass")
            hostViewController.checkData()
        }
    
        @objc func onCancel(){
            dismiss(animated: true, completion: nil)
            print("ook")
        }

    }


