//
//  FirstViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-23.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit


//ViewController for HOME   
class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
        setupUINavBar()
        
    }
    
    let titleTextView:UITextView = {
        let textView = UITextView()

        let attributeText = NSMutableAttributedString(string:"Home View", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: ColorStruct.titleColor, NSAttributedString.Key.backgroundColor: ColorStruct.backgroundColor])
        
    
        textView.backgroundColor = .clear
        textView.attributedText = attributeText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    
    func setupUI(){
         
        view.addSubview(titleTextView)
            
        view.backgroundColor = ColorStruct.backgroundColor
        
        titleTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    private func setupUINavBar(){

        let logoutBtn = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: #selector(FirstViewController.logoutSelected))
        
        
        logoutBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: ColorStruct.titleColor], for: .normal)
 
        self.navigationItem.leftBarButtonItem = logoutBtn
        
        self.navigationController?.navigationBar.barTintColor = ColorStruct.backgroundColor
       // self.navigationController?.navigationBar.tintColor = ColorStruct.backgroundColor
    }
    
    @objc func logoutSelected(){
        //Todo: logout of the user account
    }


}

