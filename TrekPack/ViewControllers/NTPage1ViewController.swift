//
//  NTPage1ViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-29.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

class NTPage1ViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Used to hide to hide keyboard on tap
        self.setupHideKeyboardOnTap()
        inputTripName.delegate = self
        inputTripDestination.delegate = self
        
        setupCurrentView()
        //setupUINavBar()
    }
    
   
    
    
    private func setupCurrentView(){
        view.backgroundColor = ColorStruct.backgroundColor
    
//        view.addSubview(inputTripName)
//        view.addSubview(tripNameLabel)
//
//        view.addSubview(inputTripDestination)
//        view.addSubview(destinationNameLabel)
//
//        inputTripName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        inputTripName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150).isActive = true
//        inputTripName.topAnchor.constraint(equalTo: view.topAnchor, constant: 135).isActive = true
//
//        tripNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
//        tripNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150).isActive = true
//        tripNameLabel.centerYAnchor.constraint(equalTo: inputTripName.centerYAnchor, constant: -30).isActive = true
//
//        inputTripDestination.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        inputTripDestination.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150).isActive = true
//        inputTripDestination.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
//
//        destinationNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
//        destinationNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150).isActive = true
//        destinationNameLabel.centerYAnchor.constraint(equalTo: inputTripDestination.centerYAnchor, constant: -30).isActive = true
        
    }
   
    let inputTripName:UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
    
        textField.backgroundColor = ColorStruct.backgroundColor
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 18)
        textField.minimumFontSize = 14
        
        textField.placeholder = "Europe 2020"
    
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
    
        textField.returnKeyType = .done
        
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: ColorStruct.titleColor, width: 0.5)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    
    let tripNameLabel:UITextView = {
        
        let label = UITextView()
         
        label.attributedText = NSAttributedString(string: "Trip Name", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
         
        label.textColor = .systemPink
        label.backgroundColor = .clear
         
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        label.isEditable = false
        label.isScrollEnabled = false
         
        return label
    }()
    
    
    let inputTripDestination:UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        
        textField.backgroundColor = ColorStruct.backgroundColor
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 18)
        textField.minimumFontSize = 14
        
        textField.placeholder = "Germany & France"
           
       textField.textAlignment = .left
       textField.contentVerticalAlignment = .center
   
       textField.returnKeyType = .done
       
       textField.addLine(position: .LINE_POSITION_BOTTOM, color: ColorStruct.titleColor, width: 0.5)
       
       textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let destinationNameLabel:UITextView = {
        
        let label = UITextView()
         
        label.attributedText = NSAttributedString(string: "Trip Destination", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
         
        label.textColor = .systemPink
        label.backgroundColor = .clear
         
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        label.isEditable = false
        label.isScrollEnabled = false
         
        return label
    }()
    
    //Used to dismiss keyboard on "Done" button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTripName.resignFirstResponder()
        inputTripDestination.resignFirstResponder()
        return true
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

//Code for adding a line underneath the textfield input (idk what it does!!)
enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

extension UIView {
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}

//Use to dimiss the keyboard on tap
extension UIViewController {
    //Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    // Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
