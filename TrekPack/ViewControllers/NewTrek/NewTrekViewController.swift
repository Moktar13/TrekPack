//
//  NewTripViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit
import Photos


///Todo: clean up class (ui elements, variables, functions,etc)
class NewTrekViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate{
    
    
    var tagOne = ""
    var tagTwo = ""
    var tagThree = ""

    //creating an initial trek struct
    var newTrek = TrekStruct(name: "", destination: "", departureDate: "", returnDate: "", items: [], tags: [])
    
    ///Todo: weird bug where this var causes IOR error when trying to access AllTreks.treksArray[]
    var trekToWorkWithPos = AllTreks.treksArray.count-1
    
    var tableView = AutomaticHeightTableView()
    
    var isReturn = false

    let trips = ["","","","", "", ""]
    
    let tags = ["", "🚌", "🚈", "✈️", "🛶", "⛵️", "🛳", "🏰", "🏝","🏔", "⛺️", "🗽", "🏛", "🏟", "🏙", "🌆", "🌉", "🏞", "🎣", "🏂", "🪂", "🏄🏻‍♂️", "🧗‍♀️", "🚴" ]

    let cellReuseID = "cell"
   
    override func viewWillDisappear(_ animated: Bool) {
        if (navigationController?.isBeingDismissed)!{
            print("Nav is being dismissed")
        }
    }
    
     

    
    
    override func viewDidLoad() {
    
        
        //Adding the new empty trek to the array so that it is now in a global scope
        AllTreks.treksArray.append(newTrek)
    
        print(AllTreks.treksArray.count)
    
        super.viewDidLoad()
    
        overrideUserInterfaceStyle = .light
    
        
        setupScene()
        setupTableView()
        setupNavBar()
    }
    
    func setupNavBar(){
        
        navigationController!.navigationBar.barTintColor = ColorStruct.titleColor
        navigationController!.navigationBar.tintColor = ColorStruct.pinkColor
      
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(NewTrekViewController.cancelTrek))
  
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(NewTrekViewController.saveTrek))
      
      
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "New Trek"
        
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorStruct.pinkColor]
       
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tags.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tags[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        switch component {
        case 0:
            tagOne = tags[row]
        case 1:
            tagTwo = tags[row]
        case 2:
            tagThree = tags[row]
        default:
            print("nil")
        }
        
        print("Tag One: " + tagOne + "\nTag Two: " + tagTwo + "\nTag Three: " + tagThree)
        
//        if (tagOne == " " && tagTwo == " " && tagThree == " "){
//            tagsLabel.text = ""
//        }

        tagsLabel.text = tagOne + tagTwo + tagThree
    }
    
    //Used to setup the scene (deleagates, etc)
    func setupScene(){
        
        
    
       ///Todo: Background as solid color or as a picture?
        //view.viewAddBackground(imgName: "tree_bg")
        //view.backgroundColor = ColorStruct.backgroundColor2
        view.viewAddBackground(imgName: "sm")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        
        inputTripName.delegate = self
        inputTripDestination.delegate = self
        inputDeparture.delegate = self
        inputReturn.delegate = self
        
        tagPicker.delegate = self
        tagPicker.dataSource = self
    
        inputTripName.autocorrectionType = .yes
        inputTripDestination.autocorrectionType = .yes
        
        inputDeparture.autocorrectionType = .no
        inputReturn.autocorrectionType = .no
    }
    
    let tagPicker:UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = ColorStruct.purpColor
        return picker
    }()

    
    //UI Elements (labels and text fields)
    let inputTripName:UITextField = {
        
        let textField = UITextField()
        
        textField.backgroundColor = .clear
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        
        ///Todo: Do i need this shit?
        textField.font = .systemFont(ofSize: 20)
        textField.minimumFontSize = 14
        textField.placeholder = "Trek Name"
        ///--------------------------------
        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.75)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
         textField.attributedPlaceholder = NSAttributedString(string: "Trek Name", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
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
        
//        label.alpha = 0.75
        
        return label
    
    }()
    let inputTripDestination:UITextField = {
        
        let textField = UITextField()
        
        textField.backgroundColor = .clear
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        
        ///Todo: Do i need this shit?
        textField.font = .systemFont(ofSize: 20)
        textField.minimumFontSize = 14
        ///----------------------------
        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.75)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        textField.attributedPlaceholder = NSAttributedString(string: "Trek Destination", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
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
        label.alpha = 0.80
        
        return label
    
    }()
    let inputDeparture:UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = .clear
        textField.textColor = ColorStruct.titleColor
        
        textField.adjustsFontSizeToFitWidth = true
        
        ///Todo: Do i need this shit?
        textField.font = .systemFont(ofSize: 20)
        textField.minimumFontSize = 14
        ///---------------------------
        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.75)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.attributedPlaceholder = NSAttributedString(string: "Departure Date", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
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
        
//        label.alpha = 0.75

        return label
    }()
    let inputReturn:UITextField = {
       let textField = UITextField()
       
       textField.backgroundColor = .clear
       textField.textColor = ColorStruct.titleColor
       
       textField.adjustsFontSizeToFitWidth = true
        
        ///Todo: do i need this shit?
       textField.font = .systemFont(ofSize: 20)
       textField.minimumFontSize = 14
        ///---------------------------
       
       textField.textAlignment = .left
       textField.contentVerticalAlignment = .center
       textField.returnKeyType = .done
       textField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.75)
       textField.clearButtonMode = UITextField.ViewMode.whileEditing
       textField.translatesAutoresizingMaskIntoConstraints = false
    
       textField.attributedPlaceholder = NSAttributedString(string: "Return Date", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
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
        
//        label.alpha = 0.75

        return label
    }()
    let itemsIcon:UILabel = {
        let label = UILabel()
        
        label.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)])
        
        //Todo: is this even needed?
        label.textColor = ColorStruct.titleColor
        
        
        label.backgroundColor = .clear
        
        let full = NSMutableAttributedString(string: "")
        
        let icon = NSTextAttachment()
        icon.image = UIImage(named: "briefcase")
        icon.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let string = NSAttributedString(attachment: icon)
        
        full.append(string)
        
        label.attributedText = full
        
//        label.alpha = 0.75

        return label
    }()
    let itemsLabel:UILabel = {
          let label = UILabel()
           label.attributedText = NSAttributedString(string: "Things to bring...", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.darkGray
               , NSAttributedString.Key.backgroundColor: UIColor.clear])
           
           label.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.75)
           
           label.translatesAutoresizingMaskIntoConstraints = false
               
           return label
       }()
    let tagsIcon:UILabel = {
           let label = UILabel()
           
           label.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)])
           
           label.textColor = ColorStruct.titleColor
           
           label.backgroundColor = .clear
           
           let full = NSMutableAttributedString(string: "")
           
           let icon = NSTextAttachment()
           
           icon.image = UIImage(named: "tag")
           icon.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
           
           let string = NSAttributedString(attachment: icon)
           
           full.append(string)
           
           label.attributedText = full
        
//           label.alpha = 0.75
           
           return label
    }()
    let tagsLabel:UITextField = {
           let textField = UITextField()
          
          textField.backgroundColor = .clear
          textField.textColor = ColorStruct.titleColor
          
          textField.adjustsFontSizeToFitWidth = true
           
           ///Todo: do i need this shit?
          textField.font = .systemFont(ofSize: 20)
          textField.minimumFontSize = 14
           ///---------------------------
          
          textField.textAlignment = .left
          textField.contentVerticalAlignment = .center
          textField.returnKeyType = .done
          textField.addLine(position: .LINE_POSITION_BOTTOM, color: .black, width: 0.75)
          textField.clearButtonMode = UITextField.ViewMode.whileEditing
          textField.translatesAutoresizingMaskIntoConstraints = false
       
          textField.attributedPlaceholder = NSAttributedString(string: "Trek Tags", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
           
            //textField.autocorrectionType = UITextAutocorrectionType.no
           
          //textField.addTarget(self, action: #selector(NewTrekViewController.makeReturn), for: .allEditingEvents)
          
          return textField

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
    let tagHStack:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    let datePicker:UIDatePicker = {
        let picker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        
        ///UI CHANGE THIS
        picker.backgroundColor = ColorStruct.purpColor
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(NewTrekViewController.dateChanged), for: .valueChanged)
    
        return picker
        
    }()
    
    let imageButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        let plusTxt = NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35), NSAttributedString.Key.foregroundColor: UIColor.white])
    
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.backgroundColor = .clear
        button.layer.borderColor = ColorStruct.titleColor.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(getImage), for: .touchDown)
        
    
        let full = NSMutableAttributedString(string: "")
        
        let icon = NSTextAttachment()
        
        icon.image = UIImage(named: "image-icon")
        icon.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        let string = NSAttributedString(attachment: icon)
        
        full.append(string)
        
        
        button.setAttributedTitle(full, for: .normal)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
    
        return button
    }()
    
    @objc func getImage(){
        
    }
    
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
        tagsLabel.resignFirstResponder()
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
    
    ///Todo: is this even called?
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
    
    //Method which will check the data and then save it if all the correct values are good
    @objc func saveTrek(){
        print("Inputted Name: \(inputTripName.text!)")
        
        
        //checking the inputted trip name
        if (inputTripName.text!.isEmpty){
            AllTreks.treksArray[AllTreks.treksArray.count-1].name = "Untitled Trek \(trekToWorkWithPos+1)"
        }else{
            AllTreks.treksArray[AllTreks.treksArray.count-1].name = inputTripName.text!
        }
        
        //checking the inputted trip destination
        if ((inputTripDestination.text?.trimmingCharacters(in: .whitespaces).isEmpty) == nil){
            AllTreks.treksArray[AllTreks.treksArray.count-1].destination = ""
        }else{
            AllTreks.treksArray[AllTreks.treksArray.count-1].destination = inputTripDestination.text!
        }
        
        ///Todo: Changing the tags will result in changing the tags for all the treks
        //checking the trek tags
        AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagOne)
        AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagTwo)
        AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagThree)
    
        print("Tag 1: \(tagOne)")
        print("Tag 2: \(tagTwo)")
        print("Tag 3: \(tagThree)")
        
        
        
        //checking the inputted dates (both return and depart)
        if (inputDeparture.text!.isEmpty && inputReturn.text!.isEmpty == false){
            dismiss(animated: true, completion: nil)
        }else if (inputDeparture.text!.isEmpty == false && inputReturn.text!.isEmpty){
            dismiss(animated: true, completion: nil)
        }else if (inputDeparture.text!.isEmpty && inputDeparture.text!.isEmpty){
            dismiss(animated: true, completion: nil)
        }else{
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            
            let depDate = dateFormatter.date(from:inputDeparture.text!)!
            let retDate = dateFormatter.date(from:inputReturn.text!)!
            
            if (retDate < depDate){
                ///Todo: Make some sort of error message apppear
                print("Return date is less than the departure date")
            }else{
                
                ///Todo: Maybe add an extra 2 fields to Trek to save the dates as a Date format
                AllTreks.treksArray[AllTreks.treksArray.count-1].departureDate = inputDeparture.text!
                AllTreks.treksArray[AllTreks.treksArray.count-1].returnDate = inputReturn.text!
                dismiss(animated: true, completion: nil)
            }
        }
        
        
        
        
    }
    
    //Removing the latest trek in the trek (aka the one the user is currently in)
    @objc func cancelTrek(){
        AllTreks.treksArray.remove(at: AllTreks.treksArray.count-1)
        dismiss(animated: true, completion: nil)
        print("Cancelling Trek")
    }
}

 
