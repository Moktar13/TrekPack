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
    
    var itemsTableView = UITableView()
    
    var trekToWorkWith = AllTreks.treksArray.count
    
    deinit{
        print("OS reclaiming ItemsPage memory")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        view.backgroundColor = SingletonStruct.backgroundColor
        
        setupDelegate()
        setupNavigationBar()
        setupScene()
        setupTableView()
        
    }
    
   
    private func setupNavigationBar(){

        navigationItem.title = "Trek Items"
            
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SingletonStruct.newWhite, NSAttributedString.Key.font: SingletonStruct.navTitle]
        }
    
    func setupDelegate(){
        inputItemName.delegate = self
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
    }
    
    func setupScene(){

        inputItemName.autocorrectionType = .yes

        //BACKDROP
        view.addSubview(itemBackdrop)
        itemBackdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        itemBackdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        itemBackdrop.heightAnchor.constraint(equalToConstant: 50).isActive = true
        itemBackdrop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
        
        //ITEM NAME
        view.addSubview(inputItemName)
        inputItemName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/16).isActive = true
        inputItemName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/13).isActive = true
        inputItemName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        inputItemName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
        
        //TABLE VIEW
        view.addSubview(itemsTableView)
        itemsTableView.layer.cornerRadius = 10
        itemsTableView.layer.borderWidth = 0
        itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        itemsTableView.topAnchor.constraint(equalTo: itemBackdrop.bottomAnchor, constant: view.frame.width/18).isActive = true
        itemsTableView.heightAnchor.constraint(equalToConstant:view.frame.height/1.35 - view.frame.height/22).isActive = true
    }
    
    
    
    //UI ELEMENTS
    let inputItemName:UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.newWhite
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0
        textField.font = SingletonStruct.inputFont
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .yes
        textField.adjustsFontSizeToFitWidth = false
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
          
        textField.attributedPlaceholder = NSAttributedString(string: "Something I need to bring...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return textField
    }()
    let itemBackdrop:UIView = {
        
        let view = UIView()
               
        view.layer.cornerRadius = 10
        view.layer.borderColor = SingletonStruct.testBlue.withAlphaComponent(0.8).cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = SingletonStruct.testBlue.withAlphaComponent(0.80)
       
        view.translatesAutoresizingMaskIntoConstraints = false
       
        return view
    }()

    //TEXTFIELD STUFF
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 25
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputItemName.resignFirstResponder()
        addItem()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
       inputItemName.resignFirstResponder()
    }
    
    //ADD ITEM
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

    //GO BACK
    @objc func onBack(){
        dismiss(animated: true, completion: nil)
        print("Dismissing ItemsVC")
    }
}
