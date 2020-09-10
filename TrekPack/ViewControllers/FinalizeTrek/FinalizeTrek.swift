//
//  NewTripViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit
import Photos
import CoreLocation


//MARK: Class
class FinalizeTrekViewController: UIViewController,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //location variables
    var currentLocation: CLLocation!
    var locManager = CLLocationManager()
    
    //date picker
    var datePicker = UIDatePicker()
    
    //tags
    var tagOne = ""
    var tagTwo = ""
    var tagThree = ""

    //cell id
    let cellReuseID = "cell"
    
    //MARK: prefersStatusBarHidden
    override var prefersStatusBarHidden: Bool {
      return false
    }
    
    
    //Deinit check
    deinit {
        print("OS reclaiming EditTrek memory")
    }
    
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        //If the trek destination is not equal to string Destination, then set the UI components of the inputTrekDesitnation accordingly
        if (AllTreks.treksArray[AllTreks.treksArray.count-1].destination != "Destination"){
            inputTrekDestination.setAttributedTitle(NSAttributedString(string: AllTreks.treksArray[AllTreks.treksArray.count-1].destination, attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlack]), for: .normal)
        }
    }
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    
        //Setting date picker mode and background color
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.4)
    
        //Creating tap gesture for the trek image
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FinalizeTrekViewController.getImage(tapGestureRecognizer:)))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tapGestureRecognizer)
        
        
        //if has permission to location services determine the users location
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways)
        {
            currentLocation = locManager.location
        }
        
        //Method calls
        setupScene()
        setupNavBar()
        setupUI()
        createDatePicker()
    }
    
    //MARK: setupNavBar
    func setupNavBar(){
        
        //Setting background of navigation bar to testBlue
        navigationController!.navigationBar.barTintColor = SingletonStruct.testBlue
        
        //Setting the title text attributed of the navigation bar
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SingletonStruct.newWhite, NSAttributedString.Key.font: SingletonStruct.navTitle]
            navigationController!.navigationBar.tintColor = SingletonStruct.newWhite
        
        //If the user is making a new trek, set navigation bar accordingly
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(FinalizeTrekViewController.saveTrek))
        saveButton.setTitleTextAttributes([NSAttributedString.Key.font: SingletonStruct.navBtnTitle], for: .normal)
        
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "Review Trek"
        
    }
    
    
    //MARK: showMapView
    @objc func showMapView(){
        presentInFullScreen(MapViewController(), animated: true)
       }
    
    
    //MARK: getDistance
    func getDistance(){
        var distanceUnit = "m"
        var distance = 0.0
         
        
        //If user allows location permission
         if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            
            let destinationLocation = CLLocation(latitude: AllTreks.treksArray[AllTreks.treksArray.count-1].latitude, longitude: AllTreks.treksArray[AllTreks.treksArray.count-1].longitude)

             
//             print("Longitude: \(currentLocation.coordinate.longitude)\nLatitude: \(currentLocation.coordinate.latitude)")
             
             
             distance = currentLocation.distance(from: destinationLocation)
                 
             print("Distance: \(distance)")
        
             if (distance > 999){
                 distance = distance/1000
                 distanceUnit = "km"
                 distance = ceil(distance)
             }
         //If the user didn't allow for location permission
         }else{
             distance = 0.0
         }
        
        //Setting the distance and distance unit measurements
        AllTreks.treksArray[AllTreks.treksArray.count-1].distance = distance
        AllTreks.treksArray[AllTreks.treksArray.count-1].distanceUnit = distanceUnit
    }
    

    //MARK: setupScene
    func setupScene(){
        view.backgroundColor = SingletonStruct.backgroundColor
    
        //delegates
        inputTrekName.delegate = self
        inputDeparture.delegate = self
        inputReturn.delegate = self
        tagPicker.delegate = self
        
        //data source
        tagPicker.dataSource = self
        
        //input view
        tagsField.inputView = tagPicker
    
        ///turning these to .yes will cause a constraint issue warnings
        inputTrekName.autocorrectionType = .no
        inputDeparture.autocorrectionType = .no
        inputReturn.autocorrectionType = .no
        tagsField.autocorrectionType = .no
        
        print("setupScene")
        
        
        print("Name: \(AllTreks.treksArray[AllTreks.treksArray.count-1].name)")
        print("Dest: \(AllTreks.treksArray[AllTreks.treksArray.count-1].destination)")
        print("Dep: \(AllTreks.treksArray[AllTreks.treksArray.count-1].departureDate)")
        print("Ret: \(AllTreks.treksArray[AllTreks.treksArray.count-1].returnDate)")
        print("Tags: \(AllTreks.treksArray[AllTreks.treksArray.count-1].tags)")
        
        //If the trek name is empty then set it to empty
        if (AllTreks.treksArray[AllTreks.treksArray.count-1].name.trimmingCharacters(in: .whitespaces).isEmpty){
            inputTrekName.text! = ""
        }else{
            inputTrekName.text! = AllTreks.treksArray[AllTreks.treksArray.count-1].name
        }
        
        //If the Trek destination is empty then set the destination the ""
        if (AllTreks.treksArray[AllTreks.treksArray.count-1].destination.trimmingCharacters(in: .whitespaces).isEmpty){
            inputTrekDestination.titleLabel?.text! = ""
        }else{
            inputTrekDestination.titleLabel?.text = AllTreks.treksArray[AllTreks.treksArray.count-1].destination
        }
        
        //Setting the input departure text
        inputDeparture.text = AllTreks.treksArray[AllTreks.treksArray.count-1].departureDate
        inputReturn.text! = AllTreks.treksArray[AllTreks.treksArray.count-1].returnDate
        
        //Setting the tags for the users trek
        tagOne = AllTreks.treksArray[AllTreks.treksArray.count-1].tags[0]
        tagTwo = AllTreks.treksArray[AllTreks.treksArray.count-1].tags[1]
        tagThree = AllTreks.treksArray[AllTreks.treksArray.count-1].tags[2]

        //If the user has no tags set the placeholder text for the tags label
        if (AllTreks.treksArray[AllTreks.treksArray.count-1].tags[0].isEmpty && AllTreks.treksArray[AllTreks.treksArray.count-1].tags[1].isEmpty && AllTreks.treksArray[AllTreks.treksArray.count-1].tags[2].isEmpty){
                tagsField.placeholder = "Trek Tags"
        }else{
            tagsField.text! = "\(AllTreks.treksArray[AllTreks.treksArray.count-1].tags[0])\(AllTreks.treksArray[AllTreks.treksArray.count-1].tags[1])\(AllTreks.treksArray[AllTreks.treksArray.count-1].tags[2])"
        }
        
        //If the users selected image is  not named "img" then set it to their image
        if (AllTreks.treksArray[AllTreks.treksArray.count-1].imageName != "img"){
            placeHolderImage.isHidden = true
            imgView.image = SingletonStruct.tempImg
        }else{
            placeHolderImage.isHidden = false
        }
    }
    
    
    //MARK: createDatePicker
    func createDatePicker(){
        
        //Toolbar
        let toolbar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: 100.0, height: 44.0))
        toolbar.tintColor = SingletonStruct.testBlue
        toolbar.backgroundColor = UIColor.lightGray
        
        
        //Bar Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: true)
        
        doneBtn.setTitleTextAttributes([NSAttributedString.Key.font: SingletonStruct.buttonFont], for: .normal)
        
        //assign toolbar
        inputDeparture.inputAccessoryView = toolbar
        inputReturn.inputAccessoryView = toolbar
        
        //assign date picker
        inputDeparture.inputView = datePicker
        inputReturn.inputView = datePicker
        
        //setting the min date to current date
        datePicker.minimumDate = Date()
    }
    
    
    //MARK: UI declarations
    let tagPicker:UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.8)
        return picker
    }()
    
    //Trek Name Label + Input Field + Vertical Stack View
    let trekNameLabel:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "Trek Name", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        
         label.attributedText = labelContent
        return label
    }()
    
    let inputTrekName:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.testBlack
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0
        textField.font = SingletonStruct.inputFont
        textField.adjustsFontSizeToFitWidth = false
        textField.minimumFontSize = 14
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        return textField
    }()
    
    let backdropLabelOne:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Trek Destination Label + Input Field + Vertical Stack View
    let trekDestinationLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.testBlue
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "Trek Destination", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFont])
        label.attributedText = labelContent
        return label
    }()
    
    let inputTrekDestination:UIButton = {
        let textField = UIButton()
        textField.backgroundColor = .clear
        textField.titleLabel!.textColor = SingletonStruct.newBlack
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0
        textField.titleLabel!.font = SingletonStruct.inputFont
        textField.titleLabel!.adjustsFontSizeToFitWidth = true
        textField.titleLabel!.minimumScaleFactor = 0.5
        textField.titleLabel!.textAlignment = .left
        textField.contentHorizontalAlignment = .left
        textField.setAttributedTitle(NSAttributedString(string: "Destination", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray]), for: .normal)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(NewTrekVC.showMapView), for: .touchDown)
        return textField
    }()
    
    let backdropLabelTwo:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Trek Departure Label + Input Field + Vertical Stack View
    let departureLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.testBlue
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "Trek Departure", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFont])
        label.attributedText = labelContent
        return label
       }()
    
    let inputDeparture:UITextField = {
         let textField = UITextField()
         textField.backgroundColor = .clear
         textField.textColor = SingletonStruct.testBlack
         textField.layer.borderColor = UIColor.clear.cgColor
         textField.layer.cornerRadius = 0
         textField.layer.borderWidth = 0
         textField.font = SingletonStruct.inputFont
         textField.adjustsFontSizeToFitWidth = false
         textField.textAlignment = .left
         textField.contentVerticalAlignment = .center
         textField.returnKeyType = .done
         textField.clearButtonMode = UITextField.ViewMode.whileEditing
         textField.attributedPlaceholder = NSAttributedString(string: "dd/mm/yyyy", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
         textField.translatesAutoresizingMaskIntoConstraints = false
         textField.autocorrectionType = UITextAutocorrectionType.no
         return textField
    }()
    
    let backdropLabelThree:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    //Trek Return Label + Input Field + Vertical Stack View
    let returnLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.testBlue
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "Trek Return", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFont])
        label.attributedText = labelContent
        return label
       }()
    
    let inputReturn:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.testBlack
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0
        textField.font = SingletonStruct.inputFont
        textField.adjustsFontSizeToFitWidth = false
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.attributedPlaceholder = NSAttributedString(string: "dd/mm/yyyy", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        return textField
    }()
    
    let backdropLabelFour:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Trek Item Label + Item Field + Vertical Stack View
    let itemsLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.testBlue
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "Trek Items", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFont])
        label.attributedText = labelContent
        return label
    }()
    
    let itemsButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 0
        button.layer.borderWidth = 0
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "right")
        attachment.bounds = CGRect(x: 0, y: -7, width: attachment.image!.size.width, height: attachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "My Items       ", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testWhite])
        myString.append(attachmentString)
        button.setAttributedTitle(myString, for: .normal)
        button.addTarget(self, action: #selector(itemsFieldTapped), for: .touchDown)
        return button
    }()
    let backdropLabelSix:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = SingletonStruct.testBlue.withAlphaComponent(0.80)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Trek Tag Label + Tag Field + Vertical Stack View
    let tagsLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.testBlue
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "Tags", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFont])
        label.attributedText = labelContent
        return label
    }()
    
    let tagsField:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.testWhite
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.clearButtonMode = .never
        textField.font = SingletonStruct.tagInputFont
        textField.attributedPlaceholder = NSAttributedString(string: "Trek Tags", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
           
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        //Toolbar
        let toolbar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: 100.0, height: 44.0))
        toolbar.tintColor = SingletonStruct.testBlue
        toolbar.backgroundColor = UIColor.lightGray
        
        //Bar Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(NewTrekVC.donePressed))
        toolbar.setItems([doneBtn], animated: true)
        doneBtn.setTitleTextAttributes([NSAttributedString.Key.font: SingletonStruct.buttonFont], for: .normal)
        textField.inputAccessoryView = toolbar
        return textField

       }()
    
    let backdropLabelFive:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Image Stuff
    let imageLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.testBlue
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "Trek Image", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFont])
         label.attributedText = labelContent
        return label
    }()
    
    let imgView:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.borderColor = SingletonStruct.testBlue.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let imgVStack:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = SingletonStruct.stackViewSeparator
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let clearImageButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width:  40, height: 20))
        let image = UIImage(named: "x")
        let clearTxt = NSAttributedString(string: "clear", attributes: [NSAttributedString.Key.font: SingletonStruct.clearImg, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        button.layer.cornerRadius = button.frame.height/2
        button.clipsToBounds = true
        button.layer.borderColor = SingletonStruct.testBlue.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(NewTrekVC.clearImage), for: .touchDown)
        button.setAttributedTitle(clearTxt, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let placeHolderImage:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "up-img")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = SingletonStruct.testBlue
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    

    //MARK: itemsFieldTapped
    @objc func itemsFieldTapped(){
        
        if (inputTrekName.isFirstResponder){
            inputTrekName.resignFirstResponder()
            inputTrekName.endEditing(true)
        }
        else if (inputTrekDestination.isFirstResponder){
            inputTrekDestination.resignFirstResponder()
            inputTrekDestination.endEditing(true)
        }
        else if (inputDeparture.isFirstResponder){
            inputDeparture.resignFirstResponder()
            inputDeparture.endEditing(true)
        }
        else if (inputReturn.isFirstResponder){
            inputReturn.resignFirstResponder()
            inputReturn.endEditing(true)
        }
        else if (tagsField.isFirstResponder){
            tagsField.resignFirstResponder()
            tagsField.endEditing(true)
        }
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(ItemPageViewController(), animated: true)
    }
    
    
    //MARK: deleteTrek
    @objc func deleteTrek(){
        AllTreks.treksArray.remove(at: AllTreks.selectedTrek)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: textFieldCharLimit
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 30
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    //MARK: textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (inputTrekName.isFirstResponder){
            inputTrekName.resignFirstResponder()
        }
        else if (inputTrekDestination.isFirstResponder){
            inputTrekDestination.resignFirstResponder()
        }
        else if (inputDeparture.isFirstResponder){
            inputDeparture.resignFirstResponder()
        }
        else if (inputReturn.isFirstResponder){
            inputReturn.resignFirstResponder()
        }
        else if (tagsField.isFirstResponder){
            tagsField.resignFirstResponder()
        }
        
        return true
    }
    
   
    //MARK: showNameError
    func showNameError(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: inputTrekName.center.x - 5, y: inputTrekName.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: inputTrekName.center.x + 5, y: inputTrekName.center.y))
        inputTrekName.layer.add(animation, forKey: "position")
    }
    
    //MARK: showDestError
    func showDestError(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: inputTrekDestination.center.x - 5, y: inputTrekDestination.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: inputTrekDestination.center.x + 5, y: inputTrekDestination.center.y))
        inputTrekDestination.layer.add(animation, forKey: "position")
    }
    
    //MARK: showRetError
    func showRetError(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: inputReturn.center.x - 5, y: inputReturn.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: inputReturn.center.x + 5, y: inputReturn.center.y))
        inputReturn.layer.add(animation, forKey: "position")
    }
    
    //MARK: showDepError
    func showDepError(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: inputDeparture.center.x - 5, y: inputDeparture.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: inputDeparture.center.x + 5, y: inputDeparture.center.y))
        inputDeparture.layer.add(animation, forKey: "position")
    }
    
    //MARK: showTagError
    func showTagError(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: tagsField.center.x - 5, y: tagsField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: tagsField.center.x + 5, y: tagsField.center.y))
        tagsField.layer.add(animation, forKey: "position")
    }
    
    
    
    
    
    //MARK: checkData
    func checkData(){

        var nameCheck = true
        var destCheck = true
        var depCheck = true
        var retCheck = true
        var tagCheck = true
        
        //name error
        if (inputTrekName.text?.trimmingCharacters(in: .whitespaces).trimmingCharacters(in: .punctuationCharacters).isEmpty == true){
            inputTrekName.text = ""
            showNameError()
            nameCheck = false
            
            SingletonStruct.doneMakingTrek = false
        }
        
        //destination error
        if (inputTrekDestination.titleLabel?.text! == "Destination"){
            showDestError()
            destCheck = false
            SingletonStruct.doneMakingTrek = false
        }
        
        
    
        //departure error
        if (inputDeparture.text?.isEmpty == true && inputReturn.text?.isEmpty == false){
            showDepError()
            depCheck = false
            
            SingletonStruct.doneMakingTrek = false
        }else if (inputDeparture.text?.isEmpty == true){
            showDepError()
            depCheck = false
        }
        
        
        //tag error
        if (tagsField.text?.trimmingCharacters(in: .whitespaces).count != 3){
            showTagError()
            tagCheck = false
            SingletonStruct.doneMakingTrek = false
        }
        
        //if has dep and ret
        if (inputDeparture.text?.isEmpty == false && inputReturn.text?.isEmpty == false){
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            let depDate = formatter.date(from:inputDeparture.text!)!
            let retDate = formatter.date(from:inputReturn.text!)!

            //IF RETURN IS LESS THAN DEPARTURE
            if (retDate < depDate){
                showRetError()
                retCheck = false
                SingletonStruct.doneMakingTrek = false
            }
        }
        
        if (nameCheck == true && destCheck == true && depCheck == true && retCheck == true && tagCheck == true){
            SingletonStruct.doneMakingTrek = true
        }else{
            SingletonStruct.doneMakingTrek = false
        }
    }
    
    
    
    //MARK: saveTrek
    @objc func saveTrek(){
        
        //Checking the data before determing if the Trek is saveable or not
        checkData()
        
        //If the trek is done then
        if (SingletonStruct.doneMakingTrek == true){
            
            AllTreks.treksArray[AllTreks.treksArray.count-1].name = inputTrekName.text!
    
            
            //TREK TAGS 
            switch AllTreks.treksArray[AllTreks.treksArray.count-1].tags.count {
            case 0:
                AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagOne)
                AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagTwo)
                AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagThree)
            case 1:
                AllTreks.treksArray[AllTreks.treksArray.count-1].tags[0] = tagOne
                AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagTwo)
                AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagThree)
                
            case 2:
                AllTreks.treksArray[AllTreks.treksArray.count-1].tags[0] = tagOne
                AllTreks.treksArray[AllTreks.treksArray.count-1].tags[1] = tagTwo
                AllTreks.treksArray[AllTreks.treksArray.count-1].tags.append(tagThree)
                
            case 3:
                AllTreks.treksArray[AllTreks.treksArray.count-1].tags[0] = tagOne
                AllTreks.treksArray[AllTreks.treksArray.count-1].tags[1] = tagTwo
                AllTreks.treksArray[AllTreks.treksArray.count-1].tags[2] = tagThree
            default:
                print("Ah duh")
            }
            
            
            //Saving the trek deparuter and return dates
            AllTreks.treksArray[AllTreks.treksArray.count-1].departureDate = inputDeparture.text!
            AllTreks.treksArray[AllTreks.treksArray.count-1].returnDate = inputReturn.text ?? ""
            
            
            let randomWallpaper = Int.random(in: 1..<16)
                        
            //If the user selected no image, then randomly assign one
            if (AllTreks.treksArray[AllTreks.treksArray.count-1].imageName == "img"){
                SingletonStruct.tempImg = UIImage(named: "wallpaper_\(randomWallpaper)")!
                AllTreks.treksArray[AllTreks.treksArray.count-1].imageName = "wallpaper_\(randomWallpaper)"
            }
                        
            //??
            SingletonStruct.isViewingPage = false
            
                        
            //Setting the imgData of the trek to the base64 encoded string of the selected trek image
            AllTreks.treksArray[AllTreks.treksArray.count-1].imgData = SingletonStruct.tempImg.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
 

            //Accessing user defaults and saving trek locally
//            let defaults = UserDefaults.standard
//            defaults.set(try? PropertyListEncoder().encode(AllTreks.treksArray), forKey: "saved")
            
            SingletonStruct.defaults.set(try? PropertyListEncoder().encode(AllTreks.treksArray), forKey: "\(SingletonStruct.defaultsKey)")
            
            
      
            ///TODO: RE-ENABLE THIS ONLY FOR TESTING ON EMU
             getDistance()
            
            
            //Dismissing view controller
            dismiss(animated: true, completion: nil)

        }
    }
    
    
    
    //MARK: goBack
    @objc func goBack(){
        
        //checking the inputted trip name
        if (inputTrekName.text?.trimmingCharacters(in: .whitespaces).isEmpty == true){
            AllTreks.treksArray[AllTreks.selectedTrek].name = "Name"
        }else{
            AllTreks.treksArray[AllTreks.selectedTrek].name = inputTrekName.text!
        }
            
        //checking the inputted trip destination
        if (inputTrekDestination.titleLabel?.text!.trimmingCharacters(in: .whitespaces) == "Destination"){
            AllTreks.treksArray[AllTreks.selectedTrek].destination = ""
        }else{
//            AllTreks.treksArray[AllTreks.selectedTrek].destination = inputTrekDestination.
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
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            let depDate = formatter.date(from:inputDeparture.text!)!
            let retDate = formatter.date(from:inputReturn.text!)!
            
            if (retDate < depDate){
                
                print("Return date is less than the departure date")
            }else{
                
                //Saving the departure and the return dates and then dismissing the view controller
                AllTreks.treksArray[AllTreks.selectedTrek].departureDate = inputDeparture.text!
                AllTreks.treksArray[AllTreks.selectedTrek].returnDate = inputReturn.text!
                dismiss(animated: true, completion: nil)
            }
        }
    }
}


