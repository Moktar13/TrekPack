//
//  NTPage1ViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-29.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

class NewTripPage1ViewController: UIViewController, UITextFieldDelegate {
    
    //TODO: The datepicker only assigns the date to the departure date text field, when it should be doing it for
    //both departure and return date text fields
    
 
    var isReturn = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Used to hide to hide keyboard on tap
        self.setupHideKeyboardOnTap()
        
        
        
        //TODO: change all the input text field name to be consistant with one another
        nameTextField.delegate = self
        destinationTextField.delegate = self
        departureDateTextField.delegate = self
        returnDateTextField.delegate = self
        
        setupCurrentView()
        
    }
    
    

    
    private func setupCurrentView(){
        view.backgroundColor = ColorStruct.backgroundColor
        

        departureDateTextField.inputView = datePicker
        departureDateTextField.inputAccessoryView = datePickerToolBar
        
        returnDateTextField.inputView = datePicker
        returnDateTextField.inputAccessoryView = datePickerToolBar
        
       
        //Adding the UI subviews
        view.addSubview(nameTextField)
        view.addSubview(destinationTextField)
        view.addSubview(tripNameLabel)
        view.addSubview(destinationNameLabel)

        view.addSubview(departureDateLabel)
        view.addSubview(departureDateTextField)
        
        view.addSubview(returnDateLabel)
        view.addSubview(returnDateTextField)
        
        
    
        //UI element constraints
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 135).isActive = true
        
        tripNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        tripNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150).isActive = true
        tripNameLabel.topAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -40).isActive = true
        
        destinationTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        destinationTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        destinationTextField.topAnchor.constraint(equalTo: nameTextField.topAnchor, constant: 100).isActive = true
        
        destinationNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        destinationNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150).isActive = true
        destinationNameLabel.topAnchor.constraint(equalTo: destinationTextField.topAnchor, constant: -40).isActive = true

        departureDateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        departureDateTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -25).isActive = true
        departureDateTextField.topAnchor.constraint(equalTo: destinationTextField.topAnchor, constant: 100).isActive = true
        
        departureDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        departureDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150).isActive = true
        departureDateLabel.topAnchor.constraint(equalTo: departureDateTextField.topAnchor, constant: -40).isActive = true
        
        returnDateTextField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        returnDateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        returnDateTextField.topAnchor.constraint(equalTo: destinationTextField.topAnchor, constant: 100).isActive = true
       
        returnDateLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 15).isActive = true
        returnDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15).isActive = true
        returnDateLabel.topAnchor.constraint(equalTo: returnDateTextField.topAnchor, constant: -40).isActive = true
        
        
        //TODO: Do I want an image at the bottom of the view??
//
//        view.addSubview(bottomView)
//
//
//        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
        //This would represent the image
//    let bottomView:UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "hiker"))
//        //this enables auto layout for the view imageView
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
   
    let nameTextField:UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
        textField.backgroundColor = ColorStruct.backgroundColor
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 20)
        textField.minimumFontSize = 14
        
        textField.placeholder = "Europe 2020"
    
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
    
        textField.returnKeyType = .done
         
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: ColorStruct.titleColor, width: 0.5)
        
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
       // textField.addTarget(self, action: #selector(NewTripPage1ViewController.staticKeyboard), for: .touchUpInside)
        
        return textField
    }()
    
    
    let tripNameLabel:UITextView = {
        
        let label = UITextView()
         
        label.attributedText = NSAttributedString(string: "Trip Name", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
         
        label.textColor = ColorStruct.subColor
        label.backgroundColor = .clear
         
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        label.isEditable = false
        label.isScrollEnabled = false
         
        return label
    }()
    
    
    let destinationTextField:UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        
        textField.backgroundColor = ColorStruct.backgroundColor
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 20)
        textField.minimumFontSize = 14
        
        textField.placeholder = "Germany & France"
           
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
   
        textField.returnKeyType = .done
       
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: ColorStruct.titleColor, width: 0.5)
        
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
       
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()
  
    
    let destinationNameLabel:UITextView = {
        
        let label = UITextView()
         
        label.attributedText = NSAttributedString(string: "Trip Destination", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
         
        label.textColor = ColorStruct.subColor
        label.backgroundColor = .clear
         
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        label.isEditable = false
        label.isScrollEnabled = false
         
        return label
    }()
    
    
    
    //Used to dismiss keyboard on "Done" button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        destinationTextField.resignFirstResponder()
        return true
    }
    
   
    
    let departureDateLabel:UITextView = {
        
       let label = UITextView()
       label.attributedText = NSAttributedString(string: "Departure Date", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
         
       label.textColor = ColorStruct.subColor
       label.backgroundColor = .clear
         
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
        
       label.isEditable = false
       label.isScrollEnabled = false
        
        return label
    }()
    
    let departureDateTextField:UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        textField.backgroundColor = ColorStruct.backgroundColor
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 20)
        textField.minimumFontSize = 14
        
        textField.placeholder = "Departure Date"
    
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
    
        textField.returnKeyType = .done
    
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: ColorStruct.titleColor, width: 0.5)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.addTarget(self, action: #selector(NewTripPage1ViewController.makeDeparture), for: .touchDown)
        
        return textField
    }()
    
    
      @objc func makeDeparture(){
          isReturn = false

      }
    
    let returnDateLabel:UITextView = {
        
       let label = UITextView()
       label.attributedText = NSAttributedString(string: "Return Date", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
         
       label.textColor = ColorStruct.subColor
       label.backgroundColor = .clear
         
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
        
       label.isEditable = false
       label.isScrollEnabled = false
        
        return label
    }()
    
    let returnDateTextField:UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        textField.backgroundColor = ColorStruct.backgroundColor
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 20)
        textField.minimumFontSize = 14
        
        textField.placeholder = "Return Date"
    
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
    
        textField.returnKeyType = .done
    
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: ColorStruct.titleColor, width: 0.5)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.addTarget(self, action: #selector(NewTripPage1ViewController.makeReturn), for: .touchDown)
        
        return textField
    }()
    
    @objc func makeReturn(){
        isReturn = true
    }
    
 
    //The actual date picker
    let datePicker:UIDatePicker = {
        let picker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        
        picker.backgroundColor = ColorStruct.backgroundColor
        picker.datePickerMode = .date
    
        return picker
        
    }()

    //The date picker toolbar
    let datePickerToolBar:UIToolbar = {
        let toolBar = UIToolbar()
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = ColorStruct.titleColor
        toolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(NewTripPage1ViewController.cancelDate))
        
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(NewTripPage1ViewController.onSaveDate))
        
        doneButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }()
    
    //Called on the date picker toolbar option cancel
    @objc func cancelDate(){
        self.view.endEditing(true)
       }
       
    //Called on the date picker toolbar option save
    @objc func onSaveDate(){
        
        //Getting the date if the value is never changed
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MM/yyyy"
        let strDate = dateFormatter.string(from: datePicker.date)
        
        
        if (isReturn == true){
            returnDateTextField.text = strDate
        }else{
            departureDateTextField.text = strDate
        }
        
        self.view.endEditing(true)
       }
    
    
    //Setting the number of input characters allowed in the textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 50
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
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
