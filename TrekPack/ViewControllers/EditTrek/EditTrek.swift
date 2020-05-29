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
class EditTrekViewController: UIViewController,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    override var prefersStatusBarHidden: Bool {
      return false
    }
    
    
    
    var imgWidth:CGFloat = 0
    
    var currentImage: UIImage = UIImage()
    var datePicker = UIDatePicker()
    
    var tagOne = ""
    var tagTwo = ""
    var tagThree = ""

    //creating an initial trek struct
    var newTrek = TrekStruct(name: "", destination: "", departureDate: "", returnDate: "", items: [], tags: [], image: UIImage(named: "sm")!, imageName: "sm")
    
    
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
        overrideUserInterfaceStyle = .dark
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.backgroundColor = .clear
    
        imgWidth = view.frame.width/2
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditTrekViewController.getImage(tapGestureRecognizer:)))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tapGestureRecognizer)
        
        
        setupScene()
        setupNavBar()
        setupUI()
        createDatePicker()
        
        
        
    }
    
    func setupNavBar(){
        
        navigationController!.navigationBar.barTintColor = SingletonStruct.titleColor
        navigationController!.navigationBar.tintColor = SingletonStruct.pinkColor
        
        if (AllTreks.makingNewTrek == false){
            let backButton:UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(EditTrekViewController.goBack))
            
            let deleteButton:UIBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(EditTrekViewController.deleteTrek))
            
            navigationItem.leftBarButtonItem = backButton
            navigationItem.rightBarButtonItem = deleteButton
            navigationItem.title = AllTreks.treksArray[AllTreks.selectedTrek].name
            

        }else{

            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(EditTrekViewController.saveTrek))
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.title = "Review Trek"
        }
            
            navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SingletonStruct.testGold]
            navigationController!.navigationBar.tintColor = SingletonStruct.testGold
    }
    
   
    
    //Used to setup the scene (delegates, etc)
    func setupScene(){
    

        
        view.backgroundColor = SingletonStruct.testBlack
        

        inputTrekName.delegate = self
        inputTrekDestination.delegate = self
        inputDeparture.delegate = self
        inputReturn.delegate = self
        itemsField.delegate = self
        
        tagPicker.delegate = self
        tagPicker.dataSource = self
        
        tagsField.inputView = tagPicker
    
        inputTrekName.autocorrectionType = .yes
        inputTrekDestination.autocorrectionType = .yes
        
        inputDeparture.autocorrectionType = .no
        inputReturn.autocorrectionType = .no
        
        print("IS MAKIGN NE: \(AllTreks.makingNewTrek)")
        
        //Setting all UI elements in accordance to the selected trip when user is not creating a new trip
        if (AllTreks.makingNewTrek == false){
            inputTrekName.text! = AllTreks.treksArray[AllTreks.selectedTrek].name
            inputTrekDestination.text! = AllTreks.treksArray[AllTreks.selectedTrek].destination
            inputDeparture.text! = AllTreks.treksArray[AllTreks.selectedTrek].departureDate
            inputReturn.text! = AllTreks.treksArray[AllTreks.selectedTrek].returnDate
            
            tagOne = AllTreks.treksArray[AllTreks.selectedTrek].tags[0]
            tagTwo = AllTreks.treksArray[AllTreks.selectedTrek].tags[1]
            tagThree = AllTreks.treksArray[AllTreks.selectedTrek].tags[2]

            //If the user has no tags set the placeholder text for the tags label
            if (AllTreks.treksArray[AllTreks.selectedTrek].tags[0].isEmpty && AllTreks.treksArray[AllTreks.selectedTrek].tags[1].isEmpty && AllTreks.treksArray[AllTreks.selectedTrek].tags[2].isEmpty){
                    tagsField.placeholder = "Trek Tags"
            }else{
                tagsField.text! = "\(AllTreks.treksArray[AllTreks.selectedTrek].tags[0])\(AllTreks.treksArray[AllTreks.selectedTrek].tags[1]) \(AllTreks.treksArray[AllTreks.selectedTrek].tags[2])"
            }
            
            //If the user's image is the default one then change the image button set to the basic one with the
            //image-icon
            let img = AllTreks.treksArray[AllTreks.selectedTrek].image
            
            if (img == UIImage(named: "sm")){
                
                imgView.image = UIImage(named: "img")
                
            }else{
                imgView.image = AllTreks.treksArray[AllTreks.selectedTrek].image
                
            }
        }else{
            inputTrekName.text! = AllTreks.treksArray[AllTreks.treksArray.count-1].name
            inputTrekDestination.text! = AllTreks.treksArray[AllTreks.treksArray.count-1].destination
            inputDeparture.text! = AllTreks.treksArray[AllTreks.treksArray.count-1].departureDate
            inputReturn.text! = AllTreks.treksArray[AllTreks.treksArray.count-1].returnDate
            
            tagOne = AllTreks.treksArray[AllTreks.treksArray.count-1].tags[0]
            tagTwo = AllTreks.treksArray[AllTreks.treksArray.count-1].tags[1]
            tagThree = AllTreks.treksArray[AllTreks.treksArray.count-1].tags[2]

            //If the user has no tags set the placeholder text for the tags label
            if (AllTreks.treksArray[AllTreks.treksArray.count-1].tags[0].isEmpty && AllTreks.treksArray[AllTreks.treksArray.count-1].tags[1].isEmpty && AllTreks.treksArray[AllTreks.treksArray.count-1].tags[2].isEmpty){
                    tagsField.placeholder = "Trek Tags"
            }else{
                tagsField.text! = "\(AllTreks.treksArray[AllTreks.treksArray.count-1].tags[0])\(AllTreks.treksArray[AllTreks.treksArray.count-1].tags[1]) \(AllTreks.treksArray[AllTreks.treksArray.count-1].tags[2])"
            }
            
    
            imgView.image = AllTreks.treksArray[AllTreks.treksArray.count - 1].image
        }
        
        
    }
    
    
    //PICKER UI
    func createDatePicker(){
        
        //Toolbar
        let toolbar = UIToolbar()
        toolbar.tintColor = SingletonStruct.testGold
        toolbar.backgroundColor = .clear
        toolbar.sizeToFit()
        
        //Bar Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        inputDeparture.inputAccessoryView = toolbar
        inputReturn.inputAccessoryView = toolbar
    
        //assign date picker
        inputDeparture.inputView = datePicker
        inputReturn.inputView = datePicker
    }
    let tagPicker:UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .clear
        return picker
    }()
    
    //Trek Name Label + Input Field + Vertical Stack View
    let trekNameLabel:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "Trek Name", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testGold])
        
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
//        textField.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testGray, width: 0.5)
        
        
        
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        
        
        textField.attributedPlaceholder = NSAttributedString(string: "Untitled Trek", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        
        return textField
    }()
    let backdropLabelOne:UIView = {
        
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //Trek Destination Label + Input Field + Vertical Stack View
    let trekDestinationLabel:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.testGold
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "Trek Destination", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFont])
        
         label.attributedText = labelContent
        return label
    
    }()
    let inputTrekDestination:UITextField = {
        
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
        
        
        
         textField.attributedPlaceholder = NSAttributedString(string: "Untitled Destination", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        return textField
    }()
    let backdropLabelTwo:UIView = {
        
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //Trek Departure Label + Input Field + Vertical Stack View
    let departureLabel:UILabel = {
           let label = UILabel()
                  
           label.textColor = SingletonStruct.testGold
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
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
   
    //Trek Return Label + Input Field + Vertical Stack View
    let returnLabel:UILabel = {
        
        let label = UILabel()
                  
        label.textColor = SingletonStruct.testGold
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
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //Trek Item Label + Item Field + Vertical Stack View
    let itemsLabel:UILabel = {
        
        let label = UILabel()
        label.textColor = SingletonStruct.testGold
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "Trek Items", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFont])
        label.attributedText = labelContent
        return label
    }()
    let itemsField:UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.titleColor
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0

        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testWhite, width: 0.5)
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
         textField.attributedPlaceholder = NSAttributedString(string: "My items", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        textField.addTarget(self, action: #selector(itemsFieldTapped), for: .touchDown)
        
        return textField
       }()
    let itemVStack:UIStackView = {
           let stackView = UIStackView()
           stackView.axis = .vertical
           stackView.distribution = .fill
           stackView.alignment = .leading
           stackView.spacing = SingletonStruct.stackViewSeparator
           stackView.translatesAutoresizingMaskIntoConstraints = false
           
           return stackView
       }()
    

    //Trek Tag Label + Tag Field + Vertical Stack View
    let tagsLabel:UILabel = {
        
        let label = UILabel()
        label.textColor = SingletonStruct.testGold
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "Trek Tags", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFont])
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
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.font = SingletonStruct.tagInputFont
           
        textField.attributedPlaceholder = NSAttributedString(string: "Placeholder", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
           
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        //Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = SingletonStruct.testGold
        toolbar.backgroundColor = SingletonStruct.testBlack
        //Bar Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(NewTrekVC.donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        textField.inputAccessoryView = toolbar
           
           
        return textField

       }()
    let backdropLabelFive:UIView = {
        
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
  
    //Image Stuff
    let imageLabel:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.testGold
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
        view.layer.masksToBounds = true;
        view.image = UIImage(named: "img")
        
    
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
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        let cancelTxt = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.black])
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.borderColor = UIColor.clear.cgColor
        button.addTarget(self, action: #selector(clearImage), for: .touchDown)
        
        
        let full = NSMutableAttributedString(string: "")
        
        let icon = NSTextAttachment()
        
        icon.image = UIImage(named: "x-circle")
        icon.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let string = NSAttributedString(attachment: icon)
        
        full.append(string)
        
        button.setAttributedTitle(full, for: .normal)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    @objc func clearImage(){
        
        
        if (AllTreks.makingNewTrek == true){
            AllTreks.treksArray[AllTreks.treksArray.count-1].image = UIImage(named: "sm")!
            
           
            
        }else{
            AllTreks.treksArray[AllTreks.selectedTrek].image = UIImage(named: "sm")!
        }
    
        imgView.image = UIImage(named: "img")
        
        hideClearButton()
        
    }
    @objc func getImage(tapGestureRecognizer: UITapGestureRecognizer){
        
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        
        picker.delegate = self
        present(picker,animated: true)
    }
    
    
    @objc func itemsFieldTapped(){
        let itemVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NTIP")
        let navController = UINavigationController(rootViewController: itemVC)
            
        presentInFullScreen(navController, animated: true)
    }
    
    @objc func deleteTrek(){
        AllTreks.treksArray.remove(at: AllTreks.selectedTrek)
        dismiss(animated: true, completion: nil)
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
        
    
        imgView.image = image
        
        
        
//        showClearButton()
        
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
        inputTrekName.resignFirstResponder()
        inputTrekDestination.resignFirstResponder()
        inputDeparture.resignFirstResponder()
        inputReturn.resignFirstResponder()
        itemsField.resignFirstResponder()
        tagsField.resignFirstResponder()
        return true
    }
    
   
    
    
    
    
    //Method which will check the data and then save it if all the correct values are good
    @objc func saveTrek(){
        
        
       
    
        //checking the inputted trip name
        if (inputTrekName.text!.isEmpty){
            SingletonStruct.untitledTrekCounter += 1
            AllTreks.treksArray[AllTreks.treksArray.count-1].name = "Untitled Trek \(SingletonStruct.untitledTrekCounter)"
        }else{
            AllTreks.treksArray[AllTreks.treksArray.count-1].name = inputTrekName.text!
        }
        
        //checking the inputted trip destination
        if ((inputTrekDestination.text?.trimmingCharacters(in: .whitespaces).isEmpty) == nil){
            AllTreks.treksArray[AllTreks.treksArray.count-1].destination = ""
        }else{
            AllTreks.treksArray[AllTreks.treksArray.count-1].destination = inputTrekDestination.text!
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
             SingletonStruct.doneMakingTrek = true
             dismiss(animated: true, completion: nil)
            
        //If no departure or return
        }else if (inputDeparture.text!.isEmpty && inputDeparture.text!.isEmpty){
             SingletonStruct.doneMakingTrek = true
             dismiss(animated: true, completion: nil)
            
        //Having both departure and return dates
        }else{
            
            
            let formatter = DateFormatter()
           
        
            formatter.dateFormat = "dd/MM/yyyy"

            formatter.locale = Locale(identifier: "en_US_POSIX")
            
            let depDate = formatter.date(from:inputDeparture.text!)!
            let retDate = formatter.date(from:inputReturn.text!)!
            
            if (retDate < depDate){
                ///Todo: Make some sort of error message apppear
                print("Return date is less than the departure date")
            }else{
                
                ///Todo: Maybe add an extra 2 fields to Trek to save the dates as a Date format
                AllTreks.treksArray[AllTreks.treksArray.count-1].departureDate = inputDeparture.text!
                AllTreks.treksArray[AllTreks.treksArray.count-1].returnDate = inputReturn.text!
                SingletonStruct.doneMakingTrek = true
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
        if (inputTrekName.text!.isEmpty){
            AllTreks.treksArray[AllTreks.selectedTrek].name = "Untitled Trek \(trekToWorkWithPos+2)"
        }else{
            AllTreks.treksArray[AllTreks.selectedTrek].name = inputTrekName.text!
        }
            
        //checking the inputted trip destination
        if ((inputTrekDestination.text?.trimmingCharacters(in: .whitespaces).isEmpty) == nil){
            AllTreks.treksArray[AllTreks.selectedTrek].destination = ""
        }else{
            AllTreks.treksArray[AllTreks.selectedTrek].destination = inputTrekDestination.text!
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


