//
//  NewTripViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

//Todo: clean up class (ui elements, variables, functions,etc)
class NewTrekViewController:UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    
    var tableView = UITableView()
    
    var isReturn = false

    let trips = ["","","","", ""]

    let cellReuseID = "cell"
   
    override func viewWillDisappear(_ animated: Bool) {
        if (navigationController?.isBeingDismissed)!{
            print("Nav is being dismissed")
        }
    }
    
    
    override func viewDidLoad() {
    
            super.viewDidLoad()
        
            overrideUserInterfaceStyle = .light
        
            setupScene()
            setupTableView()
        }
    
    //Used to setup the scene (deleagates, etc)
    func setupScene(){
        view.backgroundColor = ColorStruct.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .clear
        inputTripName.delegate = self
        inputTripDestination.delegate = self
        inputDeparture.delegate = self
        inputReturn.delegate = self
    }

    
    //UI Elements (labels and text fields)
    let inputTripName:UITextField = {
        
        let textField = UITextField()
        
        textField.backgroundColor = ColorStruct.backgroundColor
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 20)
        textField.minimumFontSize = 14
        textField.placeholder = "Trip Name"
        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.5)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
         textField.attributedPlaceholder = NSAttributedString(string: "Trip Name", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        return textField
    }()
    let nameLabel:UILabel = {
    
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
      
        label.textColor = ColorStruct.titleColor
        label.backgroundColor = .clear
      
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        let full = NSMutableAttributedString(string: "")
        
        let image1 = NSTextAttachment()
        image1.image = UIImage(named: "edit")
        image1.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let str1 = NSAttributedString(attachment: image1)
        
        full.append(str1)
        
        label.attributedText = full
        
        return label
    
    }()
    let inputTripDestination:UITextField = {
        
        let textField = UITextField()
        
        textField.backgroundColor = ColorStruct.backgroundColor
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 20)
        textField.minimumFontSize = 14
        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.5)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.attributedPlaceholder = NSAttributedString(string: "Trip Destination", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        return textField
    }()
    let destinationLabel:UILabel = {
    
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
      
        label.textColor = ColorStruct.titleColor
        label.backgroundColor = .clear
      
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        let full = NSMutableAttributedString(string: "")
        
        let icon = NSTextAttachment()
        icon.image = UIImage(named: "send")
        icon.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let str1 = NSAttributedString(attachment: icon)
        
        full.append(str1)
        
        label.attributedText = full
        
        return label
    
    }()
    let inputDeparture:UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = ColorStruct.backgroundColor
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 20)
        textField.minimumFontSize = 14
        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.5)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.attributedPlaceholder = NSAttributedString(string: "Departure Date", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        textField.addTarget(self, action: #selector(NewTrekViewController.makeDeparture), for: .allEditingEvents)
        
        return textField
        
    }()
    let departureLabel:UILabel = {
        let label = UILabel()
        
        label.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)])
        
        label.textColor = ColorStruct.titleColor
        label.backgroundColor = .clear
        
        let full = NSMutableAttributedString(string: "")
        
        let icon = NSTextAttachment()
        icon.image = UIImage(named: "calendar")
        icon.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let string = NSAttributedString(attachment: icon)
        
        full.append(string)
        
        label.attributedText = full

        return label
    }()
    let inputReturn:UITextField = {
       let textField = UITextField()
       
       textField.backgroundColor = ColorStruct.backgroundColor
       textField.textColor = ColorStruct.titleColor
       
       textField.adjustsFontSizeToFitWidth = true
       textField.font = .systemFont(ofSize: 20)
       textField.minimumFontSize = 14
       
       textField.textAlignment = .left
       textField.contentVerticalAlignment = .center
       textField.returnKeyType = .done
       textField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.5)
       textField.clearButtonMode = UITextField.ViewMode.whileEditing
       textField.translatesAutoresizingMaskIntoConstraints = false
    
       textField.attributedPlaceholder = NSAttributedString(string: "Return Date", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
       textField.autocorrectionType = UITextAutocorrectionType.no
        
       textField.addTarget(self, action: #selector(NewTrekViewController.makeReturn), for: .allEditingEvents)
       
       return textField
    }()
    let returnLabel:UILabel = {
        let label = UILabel()
        
        label.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)])
        
        label.textColor = ColorStruct.titleColor
        label.backgroundColor = .clear
        
        let full = NSMutableAttributedString(string: "")
        
        let icon = NSTextAttachment()
        icon.image = UIImage(named: "calendar")
        icon.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let string = NSAttributedString(attachment: icon)
        
        full.append(string)
        
        label.attributedText = full

        return label
    }()
    let tripNameHStack:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    let tripDestHStack:UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    let departureHStack:UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    let returnHStack:UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    let itemHStack:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    let itemsLabel:UILabel = {
       let label = UILabel()
        label.attributedText = NSAttributedString(string: "Items", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.lightGray
            , NSAttributedString.Key.backgroundColor: UIColor.clear])
        
        label.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.5)
        
        label.translatesAutoresizingMaskIntoConstraints = false
            
        return label
    }()
    let itemsIcon:UILabel = {
        let label = UILabel()
        
        label.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)])
        
        label.textColor = ColorStruct.titleColor
        label.backgroundColor = .clear
        
        let full = NSMutableAttributedString(string: "")
        
        let icon = NSTextAttachment()
        icon.image = UIImage(named: "briefcase")
        icon.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let string = NSAttributedString(attachment: icon)
        
        full.append(string)
        
        label.attributedText = full

        return label
    }()
    let datePicker:UIDatePicker = {
        let picker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        
        picker.backgroundColor = ColorStruct.backgroundColor
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(NewTrekViewController.dateChanged), for: .valueChanged)
    
        return picker
        
    }()
    

    //Setting the number of input characters allowed in the textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 35
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    //Used to dismiss keyboard on "Done" button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTripName.resignFirstResponder()
        inputTripDestination.resignFirstResponder()
        inputDeparture.resignFirstResponder()
        inputReturn.resignFirstResponder()
        return true
    }
    
    //Two functions which wil set the isReturn variable to ensure that the correct date is placed in the correct
    //uitextfield ----> probably a better more efficeint thant doing this
    @objc func makeReturn(){
        isReturn = true
    }
    @objc func makeDeparture(){
        isReturn = false
    }
    
    //Called on the date picker toolbar option save
    @objc func onSaveDate(){
        
        //Getting the date if the value is never changed
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        let strDate = dateFormatter.string(from: datePicker.date)
        
        if (isReturn == true){
            inputReturn.text = strDate
        }else{
            inputDeparture.text = strDate
        }
        
        self.view.endEditing(true)
       }
    
    //Called when the date is changed
    @objc func dateChanged(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let strDate = dateFormatter.string(from: datePicker.date)
        print("change")
        
        if (isReturn == true){
            inputReturn.text = strDate
        }else{
            inputDeparture.text = strDate
        }
        
        
    }
        
}

 
