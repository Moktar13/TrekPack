//
//  NewTripViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

//Todo: clean up class (ui elements, variables, functions,etc)
class NewTrekViewController:UIViewController,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate{
    
    var tableView = UITableView()
    
    var isReturn = false
    
    

    let trips = ["","","","", ""]

    let cellReuseID = "cell"
    
    override func viewDidAppear(_ animated: Bool) {
        if (navigationController?.isBeingPresented)!{
            print("View controller is there")
        }else{
            print("not there")
        }
    }
    

    override func viewDidLoad() {
        
        
            super.viewDidLoad()
        
            overrideUserInterfaceStyle = .light
        
            view.backgroundColor = ColorStruct.backgroundColor
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
            tableView.tableFooterView = UIView()
      
            inputTripName.delegate = self
            inputTripDestination.delegate = self
            inputDeparture.delegate = self
            inputReturn.delegate = self
        
            setupTableView()
        }

    func setupTableView(){
        
        
        inputDeparture.inputView = datePicker
        inputReturn.inputView = datePicker

        tableView.backgroundColor = ColorStruct.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        
        view.addSubview(tableView)
        
    
        //tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: view.frame.height/2 + view.frame.height/4).isActive = true
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if (indexPath.row == 0){
            inputTripName.becomeFirstResponder()
        }else if (indexPath.row == 1){
            inputTripDestination.becomeFirstResponder()
        }else if (indexPath.row == 2){
            inputDeparture.becomeFirstResponder()
        }else if (indexPath.row == 3){
            inputReturn.becomeFirstResponder()
        }else if (indexPath.row == 4){
            
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NTPage1") as! ItemPageViewController
          
//            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NTPage1") as? ItemPageViewController {
//                if let navigator = navigationController{
//                    navigator.pushViewController(viewController, animated: true)
//                }
//            }
            
            let nav = NewTrekNavController()
            
            nav.pushViewController(controller, animated: true)
//            
//        let itemPage = ItemPageViewController()
//        self.navigationController?.pushViewController(itemPage, animated: true)
//          
            
        
            
           
        
            
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        cell.selectionStyle = .none
        cell.backgroundColor = ColorStruct.backgroundColor
        
        if (indexPath.row == 0){
            
            tripNameHStack.addArrangedSubview(nameLabel)
            tripNameHStack.addArrangedSubview(inputTripName)
        
            cell.addSubview(tripNameHStack)
            
            tripNameHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            tripNameHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            tripNameHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            
            nameLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            nameLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputTripName.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputTripName.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
            inputTripName.backgroundColor = ColorStruct.backgroundColor

        }else if (indexPath.row == 1){
            
            tripDestHStack.addArrangedSubview(destinationLabel)
            tripDestHStack.addArrangedSubview(inputTripDestination)
            
            cell.addSubview(tripDestHStack)
            
            tripDestHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            tripDestHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            tripDestHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true

            destinationLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            destinationLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputTripDestination.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputTripDestination.leadingAnchor.constraint(equalTo: destinationLabel.trailingAnchor).isActive = true
            inputTripDestination.backgroundColor = ColorStruct.backgroundColor
            
        }else if (indexPath.row == 2){
            
            departureHStack.addArrangedSubview(departureLabel)
            departureHStack.addArrangedSubview(inputDeparture)
            
            cell.addSubview(departureHStack)
            
            departureHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            departureHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            departureHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true

            departureLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            departureLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputDeparture.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputDeparture.leadingAnchor.constraint(equalTo: departureLabel.trailingAnchor).isActive = true
            inputDeparture.backgroundColor = ColorStruct.backgroundColor
            
        }else if (indexPath.row == 3){
            returnHStack.addArrangedSubview(returnLabel)
            returnHStack.addArrangedSubview(inputReturn)
            
            cell.addSubview(returnHStack)
            
            returnHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            returnHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            returnHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true

            returnLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
            returnLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputReturn.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            inputReturn.leadingAnchor.constraint(equalTo: returnLabel.trailingAnchor).isActive = true
            inputReturn.backgroundColor = ColorStruct.backgroundColor
            
        }else if (indexPath.row == 4){
            itemHStack.addArrangedSubview(itemsIcon)
            itemHStack.addArrangedSubview(itemsLabel)
            
            cell.addSubview(itemHStack)
            
            itemHStack.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            itemHStack.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            itemHStack.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true

            itemsIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
            itemsIcon.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            itemsLabel.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            itemsLabel.leadingAnchor.constraint(equalTo: itemsIcon.trailingAnchor).isActive = true
            
            itemsLabel.backgroundColor = ColorStruct.backgroundColor
            
            cell.accessoryType = .disclosureIndicator
        }
        
        else{
              cell.textLabel?.text = trips[indexPath.row]
        }
        
        cell.textLabel?.text = trips[indexPath.row]
        return cell
    }
    
    //Cell height??
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
    
    //The actual date picker
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
    
    @objc func dateChanged(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MM/yyyy"
        let strDate = dateFormatter.string(from: datePicker.date)
        print("change")
        
        if (isReturn == true){
            inputReturn.text = strDate
        }else{
            inputDeparture.text = strDate
        }
        
        
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
        dateFormatter.dateFormat = "d/MM/yyyy"
        let strDate = dateFormatter.string(from: datePicker.date)
        
        if (isReturn == true){
            inputReturn.text = strDate
        }else{
            inputDeparture.text = strDate
        }
        
        self.view.endEditing(true)
       }
        
}

 
