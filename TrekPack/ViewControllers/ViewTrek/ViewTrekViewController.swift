//
//  ViewTrekViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-06.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit


class ViewTrekViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        ///BAKGROUND
        view.viewAddBackground(imgName: "sm")
        
        setupNavBar()
        
    }
    
    
    func setupNavBar(){
          
          navigationController!.navigationBar.barTintColor = ColorStruct.titleColor
          navigationController!.navigationBar.tintColor = ColorStruct.pinkColor
        
          let backButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(ViewTrekViewController.goBack))
    
          let editButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil )
        
          navigationItem.leftBarButtonItem = backButton
          navigationItem.rightBarButtonItem = editButton
          navigationItem.title = "\(AllTreks.treksArray[AllTreks.selectedTrek].name)"
          
          navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorStruct.pinkColor]
      }
    
    
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func edit(){
        
    }
    
}
