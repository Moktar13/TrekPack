//
//  SecondViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-23.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

//ViewController for ADD TRIP
class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    let titleTextView:UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Add Trip View", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: ColorStruct.titleColor, NSAttributedString.Key.backgroundColor: ColorStruct.backgroundColor])
        
        
        
        textView.backgroundColor = .clear
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        
        
        return textView
        
    }()
    
    
    func setupUI(){
        //view.backgroundColor = UIColor(red: 7/255, green: 7/255, blue: 7/255, alpha: 1)
        view.backgroundColor = ColorStruct.backgroundColor
        view.addSubview(titleTextView)
        
        titleTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
    }


}

