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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        
        
        setupDelegate()
        setupNavigationBar()
        setupScene()
        setupTableView()
        
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
        
        view.backgroundColor = .clear
        view.viewAddBackground(imgName: "sm")
       
        inputItemName.autocorrectionType = .yes

        
        view.addSubview(itemBackdrop)
        itemBackdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        itemBackdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        itemBackdrop.heightAnchor.constraint(equalToConstant: 50).isActive = true
        itemBackdrop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
        
        view.addSubview(inputItemName)
        inputItemName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/16).isActive = true
        inputItemName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/13).isActive = true
        inputItemName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        inputItemName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
        
        
        view.addSubview(itemsTableView)
        itemsTableView.layer.cornerRadius = 10
        itemsTableView.layer.borderWidth = 0
        itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        itemsTableView.topAnchor.constraint(equalTo: itemBackdrop.bottomAnchor, constant: view.frame.width/18).isActive = true
        itemsTableView.heightAnchor.constraint(equalToConstant:view.frame.height/1.5 - view.frame.height/22).isActive = true
    }
    
    
    
    //UI ELEMENTS
    let inputItemName:UITextField = {
        
        let textField = UITextField()
        
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.titleColor
        textField.adjustsFontSizeToFitWidth = true
        textField.font = SingletonStruct.inputItemFont
        textField.minimumFontSize = 14
        

        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.attributedPlaceholder = NSAttributedString(string: "Some item...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputItemFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .yes
        
        return textField
    }()
    let itemBackdrop:UIView = {
        
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    //TEXTFIELD STUFF
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 30
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
