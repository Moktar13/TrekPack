//
//  NTPage2ViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-29.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

class NTPage2ViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        setupCurrentView()
        //setupUINavBar()
    }
    
    let pageNumber:UITextView = {
            let pn = UITextView()
            
            pn.attributedText = NSAttributedString(string: "Page 2", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            
            pn.backgroundColor = .clear
            
            pn.translatesAutoresizingMaskIntoConstraints = false
            pn.textAlignment = .center
           
            pn.isEditable = false
            pn.isScrollEnabled = false
            
            return pn
        }()
        
        
        private func setupCurrentView(){
            view.backgroundColor = ColorStruct.backgroundColor
            
            view.addSubview(pageNumber)
            
            pageNumber.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            pageNumber.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    
    private func setupUINavBar(){

           let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(NTPage1ViewController.cancelSelected))

           self.navigationItem.leftBarButtonItem = cancelBtn
       
    
          
           self.navigationController?.navigationBar.barTintColor = ColorStruct.titleColor
           self.navigationController?.navigationBar.tintColor = ColorStruct.backgroundColor
       }
       
       @objc func cancelSelected(){
           
       }
    }

