//
//  PageCell.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-24.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    private var p1 = UIViewController()
    
    var page: Page? {
    
        
        didSet {
            guard let unwrappedPage = page else {return}
          
            
            addSubview(unwrappedPage.pageViewController.view)
            
           
            
        }
    }
    
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private let titleTextView: UITextView = {
        let textView = UITextView()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    private var inputTripName: UITextField = {
                 let input = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        
                 return input
             }()
    
    
    private func setupUI(){
        addSubview(titleTextView)
        //addSubview(inputTripName)
        
       
        titleTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleTextView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
//        inputTripName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        inputTripName.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
    }
    
    //Need to have separate functions for each page
    private func setupFirstPage(){
        
    }
    
    private func setupSecondPage(){
        
    }
    
    private func setupThirdPage(){
        
    }
    
    
}
