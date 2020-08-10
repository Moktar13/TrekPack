//
//  FourthViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-23.
//  Copyright © 2019 Moktar. All rights reserved.
//
import UIKit

//ViewController for MORE
class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    let titleTextView:UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "More View", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor, NSAttributedString.Key.backgroundColor: SingletonStruct.backgroundColor])
        
        textView.backgroundColor = .clear
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    

    
    
    func setupUI(){
       
        view.backgroundColor = SingletonStruct.testWhite
        view.addSubview(titleTextView)
        
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: nil)
        self.navigationController?.navigationItem.rightBarButtonItem = settingsButton
        self.title = "Test"
        
        
        
        titleTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }


}
