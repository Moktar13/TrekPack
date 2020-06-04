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
    
    
    var isReturn = false
    
    

    let cellReuseID = "cell"
   
    override func viewWillDisappear(_ animated: Bool) {
        if (navigationController?.isBeingDismissed)!{
            print("Nav is being dismissed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        
        
//        guard let navigationController = self.navigationController else { return }
//        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        
//        print("NAV STACK: \(navigationArray.count)")
//        navigationArray.remove(at: navigationArray.count) // To remove previous UIViewController
//        self.navigationController?.viewControllers = navigationArray
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.4)
    
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
        
        navigationController!.navigationBar.barTintColor = SingletonStruct.testBlue
        
        if (AllTreks.makingNewTrek == false){
            let backButton:UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(EditTrekViewController.goBack))
            
            let deleteButton:UIBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(EditTrekViewController.deleteTrek))
            
            navigationItem.leftBarButtonItem = backButton
            navigationItem.rightBarButtonItem = deleteButton
            navigationItem.title = AllTreks.treksArray[AllTreks.selectedTrek].name
            

        }else{
            
            

            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(EditTrekViewController.saveTrek))
            saveButton.setTitleTextAttributes([NSAttributedString.Key.font: SingletonStruct.navBtnTitle], for: .normal)
            
            
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.title = "Review Trek"
        }
            
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SingletonStruct.newWhite, NSAttributedString.Key.font: SingletonStruct.navTitle]
            navigationController!.navigationBar.tintColor = SingletonStruct.newWhite
    }
    
   
    
    //Used to setup the scene (delegates, etc)
    func setupScene(){
    

        
        view.backgroundColor = SingletonStruct.backgroundColor
        

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
        
        
        ///this shit for editing
        //Setting all UI elements in accordance to the selected trip when user is not creating a new trip
        if (AllTreks.makingNewTrek == false){
            
            if (AllTreks.treksArray[AllTreks.selectedTrek].name.trimmingCharacters(in: .whitespaces).isEmpty){
                inputTrekName.text! = "Name"
            }else{
                inputTrekName.text! = AllTreks.treksArray[AllTreks.selectedTrek].name
            }
            
            if (AllTreks.treksArray[AllTreks.selectedTrek].destination.trimmingCharacters(in: .whitespaces).isEmpty){
                inputTrekDestination.text! = "Destination"
            }else{
                inputTrekDestination.text! = AllTreks.treksArray[AllTreks.selectedTrek].destination
            }

            inputDeparture.text! = AllTreks.treksArray[AllTreks.selectedTrek].departureDate
            inputReturn.text! = AllTreks.treksArray[AllTreks.selectedTrek].returnDate
            
            tagOne = AllTreks.treksArray[AllTreks.selectedTrek].tags[0]
            tagTwo = AllTreks.treksArray[AllTreks.selectedTrek].tags[1]
            tagThree = AllTreks.treksArray[AllTreks.selectedTrek].tags[2]

            //If the user has no tags set the placeholder text for the tags label
            if (AllTreks.treksArray[AllTreks.selectedTrek].tags[0].isEmpty && AllTreks.treksArray[AllTreks.selectedTrek].tags[1].isEmpty && AllTreks.treksArray[AllTreks.selectedTrek].tags[2].isEmpty){
                    tagsField.placeholder = "Tags"
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
        }///------------
        else{
            
            if (AllTreks.treksArray[AllTreks.treksArray.count-1].name.trimmingCharacters(in: .whitespaces).isEmpty){
                inputTrekName.text! = ""
            }else{
                inputTrekName.text! = AllTreks.treksArray[AllTreks.treksArray.count-1].name
            }
            
            if (AllTreks.treksArray[AllTreks.treksArray.count-1].destination.trimmingCharacters(in: .whitespaces).isEmpty){
                inputTrekDestination.text! = ""
            }else{
                inputTrekDestination.text! = AllTreks.treksArray[AllTreks.treksArray.count-1].destination
            }
            
            
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
        toolbar.tintColor = SingletonStruct.newBlack
        toolbar.backgroundColor = UIColor.lightGray
        toolbar.sizeToFit()
        
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
    }
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
        
        
        
         textField.attributedPlaceholder = NSAttributedString(string: "Destination", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        
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
    let itemsField:UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.testWhite
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0

        
        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "up")
        attachment.bounds = CGRect(x: 0, y: -7, width: attachment.image!.size.width, height: attachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "My Items      ", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testWhite])
        myString.append(attachmentString)
        
        
        textField.attributedPlaceholder = myString
            
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        textField.addTarget(self, action: #selector(itemsFieldTapped), for: .touchDown)
        
        return textField
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
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.font = SingletonStruct.tagInputFont
        
           
        textField.attributedPlaceholder = NSAttributedString(string: "Placeholder", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
           
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        //Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = SingletonStruct.newBlack
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
        view.image = UIImage(named: "img")
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
    
    
    
    
    
    
    
    @objc func itemsFieldTapped(){
        let itemVC:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NTIP")
        let navController = UINavigationController(rootViewController: itemVC)
            
        presentInFullScreen(navController, animated: true)
    }
    
    @objc func deleteTrek(){
        AllTreks.treksArray.remove(at: AllTreks.selectedTrek)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //Setting the number of input characters allowed in the textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let maxLength = 25
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
    
   
    func showNameError(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: inputTrekName.center.x - 5, y: inputTrekName.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: inputTrekName.center.x + 5, y: inputTrekName.center.y))
        inputTrekName.layer.add(animation, forKey: "position")
    }
    func showRetError(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: inputReturn.center.x - 5, y: inputReturn.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: inputReturn.center.x + 5, y: inputReturn.center.y))
        inputReturn.layer.add(animation, forKey: "position")
    }
    
    func checkDates(hasName: Bool){
        //IF NO DEP BUT HAS RET
        if (inputDeparture.text!.isEmpty && inputReturn.text!.isEmpty == false){
            
            if (hasName){
                showRetError()
            }else{
                showNameError()
                showRetError()
            }
            
            
        //HAS BOTH RET AND DEP
        }else if (inputDeparture.text?.isEmpty == false && inputReturn.text?.isEmpty == false){
        
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            let depDate = formatter.date(from:inputDeparture.text!)!
            let retDate = formatter.date(from:inputReturn.text!)!
           
            //IF RETURN IS LESS THAN DEPARTURE
            if (retDate < depDate){
                
                if (hasName == false){
                    showNameError()
                    showRetError()
                }else{
                    showRetError()
                }
            
                
            }else{
                AllTreks.treksArray[AllTreks.treksArray.count-1].departureDate = inputDeparture.text!
                AllTreks.treksArray[AllTreks.treksArray.count-1].returnDate = inputReturn.text!
                
                if (hasName == false){
                    showNameError()
                }else{
                    SingletonStruct.doneMakingTrek = true
                }
            }
        //HAS NEITHER DEP OR RET
        }else{
            if (hasName){
                SingletonStruct.doneMakingTrek = true
            }else{
                showNameError()
                SingletonStruct.doneMakingTrek = false
            }
            
        }
    }
    
    
    
    //Method which will check the data and then save it if all the correct values are good
    @objc func saveTrek(){
        
    
        //IF NO TREK NAME
        if ((inputTrekName.text?.trimmingCharacters(in: .whitespaces).isEmpty == true)){
            inputTrekName.text = ""
            checkDates(hasName: false)
            SingletonStruct.doneMakingTrek = false
        }else{
            checkDates(hasName: true)
            AllTreks.treksArray[AllTreks.treksArray.count-1].name = inputTrekName.text!
        }
        
        
        if (SingletonStruct.doneMakingTrek == true){
            
            //TREK DESTINATION
            if ((inputTrekDestination.text?.trimmingCharacters(in: .whitespaces).isEmpty == true)){
                inputTrekDestination.text = ""
                AllTreks.treksArray[AllTreks.treksArray.count-1].destination = ""
            }else{
                AllTreks.treksArray[AllTreks.treksArray.count-1].destination = inputTrekDestination.text!
            }
            
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
            
            
            
            
            //DEP BUT NO RET
            if (inputDeparture.text!.isEmpty == false && inputReturn.text!.isEmpty){
                AllTreks.treksArray[AllTreks.treksArray.count-1].departureDate = inputDeparture.text!
                SingletonStruct.doneMakingTrek = true
    


            //NO DEP OR RET
            }else if (inputDeparture.text!.isEmpty && inputDeparture.text!.isEmpty){
                SingletonStruct.doneMakingTrek = true
            }
        }
        
        
        if (SingletonStruct.doneMakingTrek == true){
            
            let randomWallpaper = Int.random(in: 1...16)
            
            //TREK IMAGE
            if (AllTreks.treksArray[AllTreks.treksArray.count-1].imageName == "img"){
                AllTreks.treksArray[AllTreks.treksArray.count-1].image = UIImage(named: "wallpaper_\(randomWallpaper)")!
                AllTreks.treksArray[AllTreks.treksArray.count-1].imageName = "w_\(randomWallpaper)"
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    //Removing the latest trek in the trek (aka the one the user is currently in)
    @objc func cancelTrek(){
        AllTreks.treksArray.remove(at: AllTreks.treksArray.count-1)
        dismiss(animated: true, completion: nil)
        print("Cancelling Trek")
    }
    
    ///TODO: REVAMP THIS FUNCTION TO MAKE SURE IT DOES CORRECT INPUT CHECKS (MAYBE JUST CALL SAVE TREK SO IT DOES IT?)
    @objc func goBack(){
        
        //checking the inputted trip name
        if (inputTrekName.text?.trimmingCharacters(in: .whitespaces).isEmpty == true){
            AllTreks.treksArray[AllTreks.selectedTrek].name = "Name"
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


