//
//  ItemPageViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-12.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ItemPageViewController:UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {
    
    var itemsArr = [String]()
    
    let cellReuseID = "cell"
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        view.backgroundColor = ColorStruct.backgroundColor
        
        setupDelegate()
        setupScene()
        setupTableView()
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("yeet")
    }
    
    func setupDelegate(){
        inputItemName.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func setupScene(){
        
        view.viewAddBackground(imgName: "fog4")
       
        
        itemStack.addSubview(inputItemName)
        
        let testColor = ColorStruct.greenColor
       
        itemStack.stackAddBackground(color: testColor)
        
    
        
        view.addSubview(itemStack)
        
    
        itemStack.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
        itemStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        itemStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        itemStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    
        inputItemName.centerYAnchor.constraint(equalTo: itemStack.centerYAnchor).isActive = true
        inputItemName.heightAnchor.constraint(equalToConstant: 25).isActive = true
        inputItemName.leadingAnchor.constraint(equalTo: itemStack.leadingAnchor, constant: 15).isActive = true
        inputItemName.trailingAnchor.constraint(equalTo: itemStack.trailingAnchor, constant: -15).isActive = true
        inputItemName.backgroundColor = .clear
        inputItemName.textColor = ColorStruct.titleColor
        
        
        
    }
    
    @objc func addItem(){
        if (inputItemName.text == ""){
            print("Invalid item entered")
        }else{
            print("Adding item: \(inputItemName.text!)")
            itemsArr.append(inputItemName.text!)
            inputItemName.text = ""
            tableView.reloadData()
        }

    }
 
    
    let inputItemName:UITextField = {
        
        let textField = UITextField()
        
        textField.backgroundColor = ColorStruct.titleColor
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 20)
        textField.minimumFontSize = 14
        
       
        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
       // textField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.5)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.attributedPlaceholder = NSAttributedString(string: "Add an item...", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: ColorStruct.titleColor])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        return textField
    }()
    
    let itemStack:UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    
    
    //Setting the number of input characters allowed in the textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 30
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    //Used to dismiss keyboard on "Done" button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputItemName.resignFirstResponder()
        
        addItem()
        return true
    }
    
    

    func textFieldDidEndEditing(_ textField: UITextField) {
       inputItemName.resignFirstResponder()
    }
    
    
    
    
    
}
