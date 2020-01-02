//
//  NewTripPage2NavigationController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-02.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class NewTripPage2NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    private func setupNavBar(){
 
       let backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(NewTripPage2NavigationController.goBack))
               
           let nextBtn = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(NewTripPage2NavigationController.doNext))
           
        
           backBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ColorStruct.titleColor, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16)], for: .normal)
           
           nextBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ColorStruct.subColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], for: .normal)
           
           
           navigationItem.leftBarButtonItem = backBtn
           navigationItem.rightBarButtonItem = nextBtn
           
           self.navigationBar.setItems([navigationItem], animated: false)
           
           self.navigationBar.barTintColor = ColorStruct.backgroundColor
           self.navigationBar.tintColor = ColorStruct.titleColor
        }
        
        //TODO: Clear all the input text fields, etc (done by itself i think?)
        @objc func goBack(){
            self.dismiss(animated: true, completion: nil)
        }
        
        //Todo: add some save functionality here
        @objc func doSave(){
            print("save")
        }
        
        @objc func doNext(){
            //proceed to the next view controller
            //also check to make sure the saved informatin is valid?
        }
    }


