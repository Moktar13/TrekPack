//
//  NTPage1ViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-29.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

class NewTripPage1ViewController: UIViewController, UITextFieldDelegate{
    
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
       // tagTextField.delegate = self
        
        setupCurrentView()
        
    }
    
    

    
    private func setupCurrentView(){
        view.backgroundColor = ColorStruct.backgroundColor
    
        departureDateTextField.inputView = datePicker
        departureDateTextField.inputAccessoryView = datePickerToolBar
        
        returnDateTextField.inputView = datePicker
        returnDateTextField.inputAccessoryView = datePickerToolBar
        
        
        nameTextField.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        destinationTextField.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
       
        departureDateTextField.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        departureDateTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
       
        returnDateTextField.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        returnDateTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true

       
        
        //VSTACK for trip name (text field + label)
        let vstackOne = UIStackView()
        vstackOne.axis = .vertical
        vstackOne.distribution = .fillEqually
        vstackOne.alignment = .leading
        vstackOne.spacing = 10
        vstackOne.translatesAutoresizingMaskIntoConstraints = false
        vstackOne.addArrangedSubview(tripNameLabel)
        vstackOne.addArrangedSubview(nameTextField)
        
        //VSTACK for trip destination (text field + label)
        let vstackTwo = UIStackView()
        vstackTwo.axis = .vertical
        vstackTwo.distribution = .fillEqually
        vstackTwo.alignment = .leading
        vstackTwo.spacing = 10
        vstackTwo.translatesAutoresizingMaskIntoConstraints = false
        vstackTwo.addArrangedSubview(destinationNameLabel)
        vstackTwo.addArrangedSubview(destinationTextField)
        
        
        //VSTACK for departure date (text field + label)
        let vstackThree = UIStackView()
        vstackThree.axis = .vertical
        vstackThree.distribution = .fillEqually
        vstackThree.alignment = .leading
        vstackThree.spacing = 10
        vstackThree.translatesAutoresizingMaskIntoConstraints = false
        vstackThree.addArrangedSubview(departureDateLabel)
        vstackThree.addArrangedSubview(departureDateTextField)
        
        //VSTACK for return date (text field + label)
        let vstackFour = UIStackView()
        vstackFour.axis = .vertical
        vstackFour.distribution = .fillEqually
        vstackFour.alignment = .leading
        vstackFour.spacing = 10
        vstackFour.translatesAutoresizingMaskIntoConstraints = false
        vstackFour.addArrangedSubview(returnDateLabel)
        vstackFour.addArrangedSubview(returnDateTextField)
        
        //HSTACK for holding the departure and return vertical stack views
        let dateHStack = UIStackView()
        dateHStack.axis = .horizontal
        dateHStack.distribution = .fillEqually
        dateHStack.alignment = .center
        dateHStack.spacing = 30
        dateHStack.translatesAutoresizingMaskIntoConstraints = false
        dateHStack.addArrangedSubview(vstackThree)
        dateHStack.addArrangedSubview(vstackFour)

        
        let vstackFive = UIStackView()
        vstackFive.axis = .vertical
        vstackFive.distribution = .fillEqually
        vstackFive.alignment = .leading
        vstackFive.translatesAutoresizingMaskIntoConstraints = false
        vstackFive.spacing = 10
        vstackFive.addArrangedSubview(itemsLabel)
        vstackFive.addArrangedSubview(itemsButton)

        //MasterVStack which holds all other stack views and will essentially represent the UI
        let masterVStack = UIStackView()
        masterVStack.axis = .vertical
        masterVStack.distribution = .fillEqually
        masterVStack.alignment = .center
        masterVStack.spacing = 50
        masterVStack.translatesAutoresizingMaskIntoConstraints = false
        masterVStack.addArrangedSubview(vstackOne)
        masterVStack.addArrangedSubview(vstackTwo)
        masterVStack.addArrangedSubview(dateHStack)
        masterVStack.addArrangedSubview(vstackFive)
        
        view.addSubview(masterVStack)
        
        
        masterVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        masterVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        masterVStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        
        
            
        
        
    
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
        textField.contentHorizontalAlignment = .left
        textField.contentVerticalAlignment = .center
    
        textField.returnKeyType = .done
         
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: ColorStruct.titleColor, width: 0.5)
        
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        
        
       // textField.addTarget(self, action: #selector(NewTripPage1ViewController.staticKeyboard), for: .touchUpInside)
        
        return textField
    }()
    
    
    let tripNameLabel:UILabel = {
        
        let label = UILabel()
         
        label.attributedText = NSAttributedString(string: "Trip Name", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
         
        label.textColor = ColorStruct.subColor
        label.backgroundColor = .clear
         
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
    

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
  
    
    let destinationNameLabel:UILabel = {
        
        let label = UILabel()
         
        label.attributedText = NSAttributedString(string: "Trip Destination", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
         
        label.textColor = ColorStruct.subColor
        label.backgroundColor = .clear
         
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        return label
    }()
    
    
    
    //Used to dismiss keyboard on "Done" button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        destinationTextField.resignFirstResponder()
        return true
    }
    
   
    
    let departureDateLabel:UILabel = {
        
       let label = UILabel()
       label.attributedText = NSAttributedString(string: "Departure Date", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
         
       label.textColor = ColorStruct.subColor
       label.backgroundColor = .clear
         
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
        
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
    
    let returnDateLabel:UILabel = {
        
       let label = UILabel()
       label.attributedText = NSAttributedString(string: "Return Date", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
         
       label.textColor = ColorStruct.subColor
       label.backgroundColor = .clear
         
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
    
        
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
    
//    let tagTextField:UITextField = {
//        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//
//        textField.backgroundColor = ColorStruct.backgroundColor
//        textField.textColor = ColorStruct.titleColor
//
//        textField.adjustsFontSizeToFitWidth = true
//        textField.font = .systemFont(ofSize: 20)
//        textField.minimumFontSize = 14
//
//        textField.placeholder = "Trip Tags..."
//
//        textField.textAlignment = .left
//        textField.contentVerticalAlignment = .center
//
//        textField.returnKeyType = .done
//
//        textField.clearButtonMode = UITextField.ViewMode.whileEditing
//
//        textField.addLine(position: .LINE_POSITION_BOTTOM, color: ColorStruct.titleColor, width: 0.5)
//
//        textField.translatesAutoresizingMaskIntoConstraints = false
//
//        textField.addTarget(self, action: #selector(NewTripPage1ViewController.makeDeparture), for: .touchDown)
//
//        return textField
//    }()
    
    
//    let tripTags:UITextView = {
//
//       let label = UITextView()
//       label.attributedText = NSAttributedString(string: "Trip Tags", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
//
//       label.textColor = ColorStruct.subColor
//       label.backgroundColor = .clear
//
//       label.translatesAutoresizingMaskIntoConstraints = false
//       label.textAlignment = .left
//
//       label.isEditable = false
//       label.isScrollEnabled = false
//
//        return label
//    }()
    
    
    let itemsLabel:UILabel = {
    
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Items", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
      
        label.textColor = ColorStruct.subColor
        label.backgroundColor = .clear
      
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
     
        return label
    
    }()
    
    let itemsButton: UIButton = {
        let button = UIButton()
        
        let attributedString = NSAttributedString(string: "Add Items...", attributes: [NSAttributedString.Key.foregroundColor: ColorStruct.titleColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = (ColorStruct.subColor).cgColor
        button.layer.borderWidth = 3
        
        button.translatesAutoresizingMaskIntoConstraints = false
    
        button.addTarget(self, action: #selector(NewTripPage1ViewController.goItemsPage), for: .touchUpInside)
        return button
    
        
    }()
    
    @objc func goItemsPage(){
        
    }
    
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
