//
//  ThirdViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-23.
//  Copyright © 2019 Moktar. All rights reserved.
//

import Foundation
import UIKit

//ViewControlle for MY TRIPS
class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        setupUI()
    }
    
    
    let titleView:UITextView = {
        
            let textView = UITextView()
        
            let attributeText = NSMutableAttributedString(string:"My Trips View", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: ColorStruct.titleColor, NSAttributedString.Key.backgroundColor: ColorStruct.backgroundColor])
            
            textView.backgroundColor = .clear
            textView.attributedText = attributeText
            textView.translatesAutoresizingMaskIntoConstraints = false
                
            textView.textAlignment = .center
            textView.isEditable = false
            textView.isScrollEnabled = false
            return textView
    }()
    
    
    func setupUI(){
        
        view.addSubview(titleView)
        
       // view.backgroundColor = UIColor(red: 7/255, green: 7/255, blue: 7/255, alpha: 1)
        view.backgroundColor = ColorStruct.backgroundColor
        
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
//        titleView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        titleView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
//        titleView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
//        titleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }


}


