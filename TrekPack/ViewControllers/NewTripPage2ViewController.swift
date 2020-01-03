//
//  NewTripPage2ViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-02.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class NewTripPage2ViewController:UIViewController,UITextFieldDelegate {
    //TODO: The datepicker only assigns the date to the departure date text field, when it should be doing it for
        //both departure and return date text fields
        
     
        var isReturn = false

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //Used to hide to hide keyboard on tap
            self.setupHideKeyboardOnTap()
            
            
           
            
            setupCurrentView()
            
        }
    
        override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
             if #available(iOS 13.0, *) {
                  navigationController?.navigationBar.setNeedsLayout()
             }
        }
    
    
        private func setupCurrentView(){
            view.backgroundColor = ColorStruct.backgroundColor
            
            
            view.addSubview(itemTextView)
            view.addSubview(itemTextField)
            
            itemTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            itemTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            itemTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 135).isActive = true
            
            itemTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            itemTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150).isActive = true
            itemTextView.topAnchor.constraint(equalTo: itemTextField.topAnchor, constant: -40).isActive = true
    }
    
    let itemTextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        textView.attributedText = NSAttributedString(string: "Trip Items", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
         
        textView.textColor = ColorStruct.subColor
        textView.backgroundColor = .clear
         
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    
    let itemTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
           
        textField.backgroundColor = ColorStruct.backgroundColor
        textField.textColor = ColorStruct.titleColor
       
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 20)
        textField.minimumFontSize = 14
       
        textField.placeholder = "My item..."
   
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
   
        textField.returnKeyType = .done
        
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: ColorStruct.titleColor, width: 0.5)
       
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
       
        textField.translatesAutoresizingMaskIntoConstraints = false
               
        return textField
    }()
}
