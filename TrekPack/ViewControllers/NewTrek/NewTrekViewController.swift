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
class NewTrekViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var currentImage: UIImage = UIImage()
    
    var tagOne = ""
    var tagTwo = ""
    var tagThree = ""

    //creating an initial trek struct
    var newTrek = TrekStruct(name: "", destination: "", departureDate: "", returnDate: "", items: [], tags: [], image: UIImage(named: "sm")!, imageName: "sm")
    
    ///Todo: weird bug where this var causes IOR error when trying to access AllTreks.treksArray[]
    var trekToWorkWithPos = AllTreks.treksArray.count-1
    
    var tableView = AutomaticHeightTableView()
    
    var isReturn = false
    
    let tags = ["", "🚌", "🚈", "✈️", "🛶", "⛵️", "🛳", "🏰", "🏝","🌲", "🌴","🏔", "⛺️", "🗽", "🏛", "🏟", "🏙", "🌆", "🌉", "🏞", "🎣", "🤿", "🏂", "🪂", "🏄🏻‍♂️", "🧗‍♀️", "🚴", "🌞", "🌻", "🌚", "🌙", "🌈", "🌊", "🌍", "🗺", "❄️", "⛄️" ]

    let cellReuseID = "cell"
   
    override func viewWillDisappear(_ animated: Bool) {
        if (navigationController?.isBeingDismissed)!{
            print("Nav is being dismissed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        //Adding the new empty trek to the array so that it is now in a global scope
        
        if (AllTreks.makingNewTrek == true){
            AllTreks.treksArray.append(newTrek)
        }
        
        setupScene()
        setupTableView()
        setupNavBar()
        
        
    }
    
    func setupNavBar(){
        
        navigationController!.navigationBar.barTintColor = ColorStruct.titleColor
        navigationController!.navigationBar.tintColor = ColorStruct.pinkColor
        
        if (AllTreks.makingNewTrek == false){
            let backButton:UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(NewTrekViewController.goBack))
            
            navigationItem.leftBarButtonItem = backButton
            navigationItem.title = AllTreks.treksArray[AllTreks.selectedTrek].name
            

        }else{
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(NewTrekViewController.cancelTrek))
            
            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(NewTrekViewController.saveTrek))
            
            
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.title = "New Trek"
        }
        
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
            
        tagsLabel.text = tagOne + tagTwo + tagThree
    }
    
    //Used to setup the scene (deleagates, etc)
    func setupScene(){
    
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
        
        //Setting all UI elements in accordance to the selected trip when user is not creating a new trip
        if (AllTreks.makingNewTrek == false){
            inputTripName.text! = AllTreks.treksArray[AllTreks.selectedTrek].name
            inputTripDestination.text! = AllTreks.treksArray[AllTreks.selectedTrek].destination
            inputDeparture.text! = AllTreks.treksArray[AllTreks.selectedTrek].departureDate
            inputReturn.text! = AllTreks.treksArray[AllTreks.selectedTrek].returnDate
            
            tagOne = AllTreks.treksArray[AllTreks.selectedTrek].tags[0]
            tagTwo = AllTreks.treksArray[AllTreks.selectedTrek].tags[1]
            tagThree = AllTreks.treksArray[AllTreks.selectedTrek].tags[2]
           
            ///Todo: bug where going back 2x erases the tags from the trek
            //If the user has no tags set the placeholder text for the tags label
            if (AllTreks.treksArray[AllTreks.selectedTrek].tags[0].isEmpty && AllTreks.treksArray[AllTreks.selectedTrek].tags[1].isEmpty && AllTreks.treksArray[AllTreks.selectedTrek].tags[2].isEmpty){
                    tagsLabel.placeholder = "Trek Tags"
            }else{
                tagsLabel.text! = "\(AllTreks.treksArray[AllTreks.selectedTrek].tags[0])\(AllTreks.treksArray[AllTreks.selectedTrek].tags[1]) \(AllTreks.treksArray[AllTreks.selectedTrek].tags[2])"
            }
            
            //If the user's image is the default one then change the image button set to the basic one with the
            //image-icon
            if (AllTreks.treksArray[AllTreks.selectedTrek].image == UIImage(named: "sm")){
                let full = NSMutableAttributedString(string: "")
                let icon = NSTextAttachment()
                icon.image = UIImage(named: "image-icon")
                icon.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
                let string = NSAttributedString(attachment: icon)
                full.append(string)
                imageButton.setAttributedTitle(full, for: .normal)
            }else{
                imageButton.contentMode = .scaleAspectFill
                imageButton.layer.masksToBounds = true;
                imageButton.setImage(AllTreks.treksArray[AllTreks.selectedTrek].image, for: .normal)
                imageButton.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
            }
        }
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
        button.layer.borderWidth = 1
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
    
    
    let clearImageButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        let cancelTxt = NSAttributedString(string: "X", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.black])
        
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(clearImage), for: .touchDown)
        
        
        button.setAttributedTitle(cancelTxt, for: .normal)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    @objc func clearImage(){
        if (AllTreks.makingNewTrek == true){
            AllTreks.treksArray[AllTreks.treksArray.count-1].image = UIImage(named: "sm")!
            
           
            
        }else{
            AllTreks.treksArray[AllTreks.selectedTrek].image = UIImage(named: "sm")!
        }
        
        
        let full = NSMutableAttributedString(string: "")
                          
        let icon = NSTextAttachment()
       
        icon.image = UIImage(named: "image-icon")
        icon.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
      
        let string = NSAttributedString(attachment: icon)
        full.append(string)
        imageButton.setAttributedTitle(full, for: .normal)
        
        imageButton.setImage(nil, for: .normal)
        
        hideClearButton()
        
    }
    
    @objc func getImage(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        
        picker.delegate = self
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let image = info[.editedImage] as? UIImage else {
            print("Shit")
            return
        }

        ///Todo: Do I need the UUID string? (dont think so)
        if (AllTreks.makingNewTrek == true){
            AllTreks.treksArray[AllTreks.treksArray.count-1].image = image
            AllTreks.treksArray[AllTreks.treksArray.count-1].imageName = UUID().uuidString
        }else{
            AllTreks.treksArray[AllTreks.selectedTrek].image = image
            AllTreks.treksArray[AllTreks.selectedTrek].imageName = UUID().uuidString
        }
        
    
        imageButton.contentMode = .scaleAspectFill
        imageButton.layer.masksToBounds = true;
        imageButton.setImage(image, for: .normal)
        imageButton.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
        
        showClearButton()
        
        dismiss(animated: true, completion: nil)
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
        dateFormatter.dateFormat = "MMM dd, YYYY"
        
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
        dateFormatter.dateFormat = "MMM dd, YYYY"
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
    
        //checking the inputted trip name
        if (inputTripName.text!.isEmpty){
            AllTreks.treksArray[AllTreks.treksArray.count-1].name = "Untitled Trek \(trekToWorkWithPos+2)"
        }else{
            AllTreks.treksArray[AllTreks.treksArray.count-1].name = inputTripName.text!
        }
        
        //checking the inputted trip destination
        if ((inputTripDestination.text?.trimmingCharacters(in: .whitespaces).isEmpty) == nil){
            AllTreks.treksArray[AllTreks.treksArray.count-1].destination = ""
        }else{
            AllTreks.treksArray[AllTreks.treksArray.count-1].destination = inputTripDestination.text!
        }
        
        //checking the trek tags
        AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagOne)
        AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagTwo)
        AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagThree)
    
        //If no departure but has return
        if (inputDeparture.text!.isEmpty && inputReturn.text!.isEmpty == false){
            print("Can't have return date without a depart date!")
            
        //If departure but no return
        }else if (inputDeparture.text!.isEmpty == false && inputReturn.text!.isEmpty){
            AllTreks.treksArray[AllTreks.treksArray.count-1].departureDate = inputDeparture.text!
            dismiss(animated: true, completion: nil)
            
        //If no departure or return
        }else if (inputDeparture.text!.isEmpty && inputDeparture.text!.isEmpty){
            dismiss(animated: true, completion: nil)
            
        //Having both departure and return dates
        }else{
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            dateFormatter.dateFormat = "MMM dd, YYYY"
            
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
    
    
    @objc func goBack(){
        
        //checking the inputted trip name
        if (inputTripName.text!.isEmpty){
            AllTreks.treksArray[AllTreks.selectedTrek].name = "Untitled Trek \(trekToWorkWithPos+2)"
        }else{
            AllTreks.treksArray[AllTreks.selectedTrek].name = inputTripName.text!
        }
            
        //checking the inputted trip destination
        if ((inputTripDestination.text?.trimmingCharacters(in: .whitespaces).isEmpty) == nil){
            AllTreks.treksArray[AllTreks.selectedTrek].destination = ""
        }else{
            AllTreks.treksArray[AllTreks.selectedTrek].destination = inputTripDestination.text!
        }
        
        //checking the trek tags
        AllTreks.treksArray[AllTreks.selectedTrek].tags[0] = tagOne
        AllTreks.treksArray[AllTreks.selectedTrek].tags[1] = tagTwo
        AllTreks.treksArray[AllTreks.selectedTrek].tags[2] = tagThree
    
        //If no departure but has return
        if (inputDeparture.text!.isEmpty && inputReturn.text!.isEmpty == false){
            print("Can't have return date without a depart date!")
            
        //If departure but no return
        }else if (inputDeparture.text!.isEmpty == false && inputReturn.text!.isEmpty){
            AllTreks.treksArray[AllTreks.selectedTrek].departureDate = inputDeparture.text!
            AllTreks.treksArray[AllTreks.selectedTrek].returnDate = ""
            dismiss(animated: true, completion: nil)
            
        //If no departure or return
        }else if (inputDeparture.text!.isEmpty && inputDeparture.text!.isEmpty){
            AllTreks.treksArray[AllTreks.selectedTrek].departureDate = ""
            AllTreks.treksArray[AllTreks.selectedTrek].returnDate = ""
            dismiss(animated: true, completion: nil)
            
        //Having both departure and return dates
        }else{
            
            //Used to put the dates in a form so that it can be compared easier
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "MMM dd, YYYY"
            let depDate = dateFormatter.date(from:inputDeparture.text!)!
            let retDate = dateFormatter.date(from:inputReturn.text!)!
            
            if (retDate < depDate){
                ///Todo: Make some sort of error message apppear
                print("Return date is less than the departure date")
            }else{
                
                ///Todo: Maybe add an extra 2 fields to Trek to save the dates as a Date format
                AllTreks.treksArray[AllTreks.selectedTrek].departureDate = inputDeparture.text!
                AllTreks.treksArray[AllTreks.selectedTrek].returnDate = inputReturn.text!
                dismiss(animated: true, completion: nil)
            }
        }
        
       
    }
}

 
