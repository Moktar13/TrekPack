//
//  NTN3.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-02.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class NTN3: UINavigationController {

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupNavBar()
        }
        
        
        private func setupNavBar(){
            let cancelBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(NewTripPage1NavigationController.doCancel))
            
            let nextBtn = UIBarButtonItem(title: "Next", style: UIBarButtonItem.Style.plain, target: nil, action: #selector(NewTripPage1NavigationController.doNext))
            
         
            cancelBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ColorStruct.titleColor, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16)], for: .normal)
            
            nextBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ColorStruct.subColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], for: .normal)
            
            
            navigationItem.leftBarButtonItem = cancelBtn
            navigationItem.rightBarButtonItem = nextBtn
            
            self.navigationBar.setItems([navigationItem], animated: false)
            
            self.navigationBar.barTintColor = ColorStruct.backgroundColor
            self.navigationBar.tintColor = ColorStruct.titleColor
        }
        
        //TODO: Clear all the input text fields, etc (done by itself i think?)
        @objc func doCancel(){
            self.dismiss(animated: true, completion: nil)
        }
        
        //Todo: add some save functionality here
        @objc func doSave(){
            print("save")
        }
        
        @objc func doNext(){
            let secondVC:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NV2") as! UINavigationController
            self.present(secondVC, animated: true, completion: nil)
            
            
        }
    }


