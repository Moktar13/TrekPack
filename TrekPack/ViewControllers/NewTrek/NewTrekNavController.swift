//
//  NewTrekNavController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class NewTrekNavController: UINavigationController {
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
            navigationBar.barTintColor = ColorStruct.subColor
            navigationBar.tintColor = ColorStruct.titleColor
            
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(NewTrekNavController.onCancel))
        
            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(TreksNavController.onFilter))
            
            
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.title = "My Trek"
            
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorStruct.titleColor]
        
            navigationBar.setItems([navigationItem], animated: true)
            
            

        }
    
        @objc func onSave(){
            //Todo: Save the trip information
        }
    
        @objc func onCancel(){
            dismiss(animated: true, completion: nil)
            print("ook")
        }

    }


