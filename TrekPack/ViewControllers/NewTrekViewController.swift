//
//  NewTripViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class NewTrekViewController:UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var tableView = UITableView()
    
    //Todo: Will contain all the users treks
    let trips = ["1","2","3","$"]

    let cellReuseID = "cell"
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
            tableView.tableFooterView = UIView()
        
            tableView.backgroundColor = ColorStruct.backgroundColor
        
       
        
            
            setupTableView()
        }
        
    func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
         
        tableView.contentInset = .init(top: 15, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = .lightGray
        
        view.addSubview(tableView)
        
        //TableView anchor
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        cell.backgroundColor = ColorStruct.backgroundColor
        
        
        if (indexPath.row == 1){
            
            let testHStack = UIStackView()
            testHStack.axis = .horizontal
            testHStack.distribution = .fillProportionally
            testHStack.alignment = .leading
            testHStack.spacing = 0
            testHStack.translatesAutoresizingMaskIntoConstraints = false
            
            testHStack.addArrangedSubview(itemsLabel)
            testHStack.addArrangedSubview(inputTripName)
            
           
           
            cell.addSubview(testHStack)
            
            testHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            testHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            testHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            
            itemsLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            itemsLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputTripName.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputTripName.leadingAnchor.constraint(equalTo: itemsLabel.trailingAnchor).isActive = true
            inputTripName.backgroundColor = ColorStruct.backgroundColor
            

            
        }else{
              cell.textLabel?.text = trips[indexPath.row]
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
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
        //textField.addLine(position: .LINE_POSITION_BOTTOM, color: ColorStruct.titleColor, width: 0.5)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let itemsLabel:UILabel = {
    
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
      
        label.textColor = ColorStruct.titleColor
        label.backgroundColor = .clear
      
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        
     
        return label
    
    }()
    
    
    
    
    
    
    
    
    
    //Setting the number of input characters allowed in the textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 50
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
        
}
