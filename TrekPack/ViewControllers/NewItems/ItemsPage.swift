//
//  ItemPageViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-12.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

// ~ Class which represents the Items Page for when the user edits or finalizes their trek ~
class ItemPageViewController:UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {
        
    //Class variables
    let cellReuseID = "cell"
    var itemsTableView = UITableView()
    var trekToWorkWith = SingletonStruct.allTreks.count
    
    
    //MARK: deinit
    deinit{
        print("OS reclaiming ItemsPage memory")
    }
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        setupDelegate()
        setupNavigationBar()
        setupScene()
        setupTableView()
    }
    
   
    //MARK: setupNavigationBar
    private func setupNavigationBar(){

        navigationItem.title = "Trek Items"
            
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SingletonStruct.newWhite, NSAttributedString.Key.font: SingletonStruct.navTitle]
        }
    
    
    //MARK: setupDelegate
    func setupDelegate(){
        inputItemName.delegate = self
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
    }
    
    
    //MARK: setupScene
    func setupScene(){
        
        view.backgroundColor = SingletonStruct.backgroundColor
        
        //NSLayoutAnchor for itemBackrop
        view.addSubview(itemBackdrop)
        itemBackdrop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        itemBackdrop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        itemBackdrop.heightAnchor.constraint(equalToConstant: 50).isActive = true
        itemBackdrop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
        
        //NSLayoutAnchor for inputItemName
        view.addSubview(inputItemName)
        inputItemName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/16).isActive = true
        inputItemName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/13).isActive = true
        inputItemName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        inputItemName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
        
        //NSLayoutAnchor for itemsTableView
        view.addSubview(itemsTableView)
        itemsTableView.layer.cornerRadius = 10
        itemsTableView.layer.borderWidth = 0
        itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        itemsTableView.topAnchor.constraint(equalTo: itemBackdrop.bottomAnchor, constant: view.frame.width/18).isActive = true
        itemsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        //NSLayoutAnchor for itemsImg
//        view.addSubview(itemsImg)
//        itemsImg.topAnchor.constraint(equalTo: itemsTableView.bottomAnchor, constant: 20).isActive = true
//        itemsImg.leadingAnchor.constraint(equalTo: itemsTableView.leadingAnchor).isActive = true
//        itemsImg.trailingAnchor.constraint(equalTo: itemsTableView.trailingAnchor).isActive = true
//        itemsImg.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    
    
    

    //MARK: shouldChangeCharactersIn
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Setting the max character length of the textfield to 25
        let maxLength = 25
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    //MARK: textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputItemName.resignFirstResponder()
        addItem()
        return true
    }
    
    
    //MARK: textFieldDidEndEditing
    func textFieldDidEndEditing(_ textField: UITextField) {
       inputItemName.resignFirstResponder()
    }
    
    //MARK: addItem
    private func addItem(){
    
        //Ensuring that the user hasn't entered a blank item
        if (inputItemName.text == ""){
            //Some error
        }else{
            
            //If the user is making a new trek thene add the item/bool to the items and crosses array of the most recently added trek to all treks array
            if (SingletonStruct.makingNewTrek == true){
                SingletonStruct.tempTrek.items.append(inputItemName.text!)
                SingletonStruct.tempTrek.crosses.append(false)
            }else{
                SingletonStruct.tempTrek.items.append(inputItemName.text!)
                SingletonStruct.tempTrek.crosses.append(false)
            }
            
            //resetting the input item name field and reloading the tableview
            inputItemName.text = ""
            itemsTableView.reloadData()
        }
    }

    //MARK: onBack
    @objc func onBack(){
        dismiss(animated: true, completion:nil)
    }
    
    
    //MARK: UI Component Declarations
    let inputItemName:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.testBlack
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
        textField.attributedPlaceholder = NSAttributedString(string: "I need to bring...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        return textField 
    }()
    let itemBackdrop:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let itemsImg:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.image = UIImage(named: "items")
        return view
    }()
}
