//
//  Test.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-30.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {
    
     let navB:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NV2") as! UINavigationController

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    private func setupUI(){
        view.addSubview(addTripButton)
        view.addSubview(newTripTitle)
        view.addSubview(newTripDescription)
        
        //Constraints for the ui elements
        newTripTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        newTripTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        newTripTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        
        newTripDescription.leadingAnchor.constraint(equalTo: newTripTitle.leadingAnchor).isActive = true
        newTripDescription.trailingAnchor.constraint(equalTo: newTripDescription.trailingAnchor).isActive = true
        newTripDescription.topAnchor.constraint(equalTo: newTripTitle.topAnchor, constant: 45).isActive = true
        
        addTripButton.widthAnchor.constraint(equalToConstant: 175).isActive = true
        addTripButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        addTripButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addTripButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
    }
    
    
    let addTripButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let attributedString = NSAttributedString(string: "Get Started", attributes: [NSAttributedString.Key.foregroundColor: ColorStruct.titleColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderColor = (ColorStruct.subColor).cgColor
        button.layer.borderWidth = 3
        
        button.translatesAutoresizingMaskIntoConstraints = false
    
        button.addTarget(self, action: #selector(NewTripViewController.onNewTrip), for: .touchUpInside)
        return button
        
    }()
    
    let newTripTitle:UITextView = {
        let textView = UITextView()
        
        textView.attributedText = NSAttributedString(string: "Make a new trip.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: ColorStruct.titleColor])
        
        textView.backgroundColor = .clear
         
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
        
    }()
    
    
    let newTripDescription:UITextView = {
        let textView = UITextView()
        
        textView.attributedText = NSAttributedString(string: "Here is where the journey begins!\nProvide  trip details on the following pages.\nTap the button to start!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: ColorStruct.subColor])
        
        textView.backgroundColor = .clear
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
       
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    @objc func onNewTrip(){
         let firstVC:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NV1") as! UINavigationController



        presentInFullScreen(firstVC, animated: true)
        
        
    }
}
