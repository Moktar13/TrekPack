//
//  ItemPageViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-12.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class ItemPageViewController:UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {
        
    let cellReuseID = "cell"
    
    var itemsTableView = AutomaticHeightTableView()
    
    var trekToWorkWith = AllTreks.treksArray.count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        view.backgroundColor = SingletonStruct.backgroundColor
        
        setupDelegate()
        setupScene()
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("yeet")
    }
    
    private func setupNavigationBar(){
        navigationController!.navigationBar.barTintColor = SingletonStruct.titleColor
        navigationController!.navigationBar.tintColor = SingletonStruct.pinkColor

        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBack))
    
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Trek Items"
            
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SingletonStruct.pinkColor]
        }
    
    func setupDelegate(){
        inputItemName.delegate = self
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
    }
    
    func setupScene(){
        
        view.viewAddBackground(imgName: "sm")
       
        inputItemName.autocorrectionType = .yes
        itemStack.addSubview(inputItemName)
        
        let testColor = SingletonStruct.purpColor
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
        inputItemName.textColor = SingletonStruct.titleColor
        
        print("Trek Name: \(AllTreks.treksArray[AllTreks.treksArray.count-1].name)")
        print("Trek Destination: \(AllTreks.treksArray[AllTreks.treksArray.count-1].destination)")
        print("Trek Dep: \(AllTreks.treksArray[AllTreks.treksArray.count-1].departureDate) and Ret: \(AllTreks.treksArray[AllTreks.treksArray.count-1].returnDate)")
        print("Trek Tags: \(AllTreks.treksArray[AllTreks.treksArray.count-1].tags)")
    }
    
    ///Todo: Adding the item directly to the trek in the allTreks[trekToWorkWith] items array!~
    @objc func addItem(){
        if (inputItemName.text == ""){
            print("Invalid item entered")
        }else{
            print("Adding item: \(inputItemName.text!)")
            
            if (AllTreks.makingNewTrek == true){
                AllTreks.treksArray[trekToWorkWith-1].items.append(inputItemName.text!)
            }else{
                AllTreks.treksArray[AllTreks.selectedTrek].items.append(inputItemName.text!)
            }
                        

            inputItemName.text = ""
            itemsTableView.reloadData()
        }
    }
 
    let inputItemName:UITextField = {
        
        let textField = UITextField()
        
        textField.backgroundColor = SingletonStruct.titleColor
        textField.textColor = SingletonStruct.titleColor
        
        
        
        textField.adjustsFontSizeToFitWidth = true
        textField.font = SingletonStruct.inputItemFont
        textField.minimumFontSize = 14
        
       
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
//        textField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.5)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.attributedPlaceholder = NSAttributedString(string: "Add an item...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputItemFont, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])
        
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

    @objc func onBack(){
        dismiss(animated: true, completion: nil)
        print("Dismissing ItemsVC")
    }
    
    
}
