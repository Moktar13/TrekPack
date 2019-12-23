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


}

