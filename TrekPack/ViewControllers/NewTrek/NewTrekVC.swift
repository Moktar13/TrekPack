//
//  NewTrekVC.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-24.
//  Copyright © 2020 Moktar. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class NewTrekVC: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource ,UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //Table View
    let cellReuseID = "cell"
    var itemsTableView = UITableView()
    
    //Scroll View
    var pages:[UIView] = []
    var currPage:Int = 0
    var newTrekSV = UIScrollView()
    
    //Date Picker
    var datePicker = UIDatePicker()
    
    //Tags
    var tagOne = ""
    var tagTwo = ""
    var tagThree = ""

    //NewTrek
    var newTrek = TrekStruct(name: "", destination: "Destination", departureDate: "", returnDate: "", items: [], crosses: [], tags: ["","",""], imageName: "img", imgData: "", streetNumber: "", streetName: "", subCity: "", city: "", municipality: "", province: "", postal: "", country: "", countryISO: "", region: "", ocean: "", latitude: 0.0, longitude: 0.0, distance: 0.0, distanceUnit: "", timeZone: "")
    
    //MARK: deinit
    deinit {
        print("OS reclaiming NewTrek memory")
    }
    
    //MARK: preferStatusBarHidden
    override var prefersStatusBarHidden: Bool {
      return true
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
     
        //Required because when the user finishes the finalize trek check, this view will reappear but doneMakingTrek will equal true so it will dismiss rightaway
        if (SingletonStruct.doneMakingTrek == true){
            SingletonStruct.doneMakingTrek = false
            
            dismiss(animated: true, completion: nil)
        }else{
            
            if (SingletonStruct.tempTrek.destination != ""){
                inputTrekDestination.setAttributedTitle(NSAttributedString(string: SingletonStruct.tempTrek.destination, attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray]), for: .normal)
            }
        }
    }
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = SingletonStruct.backgroundColor
        
        SingletonStruct.makingNewTrek = true
        SingletonStruct.tempImg = UIImage(named: "img")!
        self.newTrekSV.contentInsetAdjustmentBehavior = .never
        
        //Resetting tempTrek
        SingletonStruct.tempTrek = TrekStruct(name: "", destination: "Destination", departureDate: "", returnDate: "", items: [], crosses: [], tags: ["","",""], imageName: "img", imgData: "", streetNumber: "", streetName: "", subCity: "", city: "", municipality: "", province: "", postal: "", country: "", countryISO: "", region: "", ocean: "", latitude: 0.0, longitude: 0.0, distance: 0.0, distanceUnit: "", timeZone: "")
        
        //Setting date picker
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.8)
        
        //Setting date picker attributes based on the OS version
        if #available(iOS 14, *) {
                datePicker.preferredDatePickerStyle = .wheels
                datePicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
                datePicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
                datePicker.preferredDatePickerStyle = .wheels
            }
        
        //Adding tap gesture to the screen
        let screenTapGesture = UITapGestureRecognizer(target: self, action: #selector(NewTrekVC.screenTapped))
        view.addGestureRecognizer(screenTapGesture)
        
        //Adding tap gesture to the imgView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewTrekVC.getImage(tapGestureRecognizer:)))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tapGestureRecognizer)
        
        //Method calls
        addBottomControls()
        delegateSetup()
        createDatePicker()
        setupLayout()
    }
    
    
    //MARK: screenTapped
    @objc func screenTapped(){
        //Method called when the screen is tapped - this will allow the scroll view to be renable when the user dismissed the keyboard by tapping the screen
        view.endEditing(true)
        if (newTrekSV.isScrollEnabled == false){
            newTrekSV.isScrollEnabled = true
        }
    }
    
    
    //MARK: scrollViewWillBeginDragging
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if (inputTrekName.isFirstResponder || inputDeparture.isFirstResponder || inputReturn.isFirstResponder || tagsField.isFirstResponder || inputItem.isFirstResponder){
            newTrekSV.isScrollEnabled = false
        }
    }
    
    //MARK: scrollViewWillEndDragging
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //Allowing scrolling if the selected scroll view isn't the itemsTableView
        if (scrollView != itemsTableView){
            currPage = Int(targetContentOffset.pointee.x / 375.0)

            pageControl.currentPage = currPage
            
            if (currPage == 0){
                showCancelButton(isFirstPage: true)
            }else if (currPage == 4){
                showFinishButton(isLastPage: true)
            }else{
                if (previousButton.isHidden){
                    showCancelButton(isFirstPage: false)
                }
                if (nextButton.isHidden){
                    showFinishButton(isLastPage: false)
                }
            }
        }
    }
    
    
    //MARK: showCancelButton
    func showCancelButton(isFirstPage: Bool){
        if (isFirstPage == true){
            previousButton.isHidden = true
            previousButton.isUserInteractionEnabled = false
            cancelButton.isHidden = false
            cancelButton.isUserInteractionEnabled = true
        }else{
            previousButton.isHidden = false
            previousButton.isUserInteractionEnabled = true
            cancelButton.isHidden = true
            cancelButton.isUserInteractionEnabled = false
        }
    }
    
    
    //MARK: showFinishButton
    func showFinishButton(isLastPage: Bool){
        if (isLastPage == true){
            nextButton.isHidden = true
            nextButton.isUserInteractionEnabled = false
            finishButton.isHidden = false
            finishButton.isUserInteractionEnabled = true
        }else{
            nextButton.isHidden = false
            nextButton.isUserInteractionEnabled = true
            finishButton.isHidden = true
            finishButton.isUserInteractionEnabled = false
        }
    }
  
    //MARK: delegateSetup
    private func delegateSetup(){
        newTrekSV.delegate =  self
        inputTrekName.delegate = self
        inputDeparture.delegate = self
        inputReturn.delegate = self
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        inputItem.delegate = self
        tagsField.delegate = self
        tagPicker.dataSource = self
        tagPicker.delegate = self
    }
    
    //MARK: createDatePicker
    func createDatePicker(){
        
        //Toolbar
        let toolbar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: 100.0, height: 44.0))
        toolbar.tintColor = SingletonStruct.testBlue
        toolbar.backgroundColor = UIColor.lightGray
        
        //Bar Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(NewTrekVC.donePressed))
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
    
    
    //MARK: donePressed
    @objc func donePressed(){
        
        //Creating new formatter and setting its date format and locale
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        //Determining which field was selected so the picker knows what value to put where
        if (inputDeparture.isFirstResponder){
            inputDeparture.text = formatter.string(from: datePicker.date)
            inputDeparture.resignFirstResponder()
            print("Selecting departure")
        }
        else if (inputReturn.isFirstResponder){
            inputReturn.text = formatter.string(from: datePicker.date)
            inputReturn.resignFirstResponder()
            print("Selecting return")
        }
        else if (tagsField.isFirstResponder){
            tagsField.resignFirstResponder()
        }
        else if (inputItem.isFirstResponder){
            inputItem.resignFirstResponder()
        }
    
        self.view.endEditing(true)
        newTrekSV.isScrollEnabled = true
    }

    //MARK: setupLayout
    private func setupLayout(){
            
        var frame = CGRect(x: -newTrekSV.frame.width, y: 0, width: 0, height: 0)
         
        //Iterating over the 5 pages in the scroll view and creating each pages UI
        for i in 0...4{

            frame.origin.x += newTrekSV.frame.size.width
            frame.size = newTrekSV.frame.size
             
            if (i == 0){
                 
                //View for page 1
                let view: UIView = UIView(frame: frame)
                view.clipsToBounds = true
                view.backgroundColor = .clear
                view.layer.borderColor = UIColor.clear.cgColor
                view.layer.borderWidth = 1

                //NSLayoutConstraint for pageOneMainHeader
                view.addSubview(pageOneMainHeader)
                pageOneMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageOneMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageOneMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true

                //NSLayoutConstraint for pageOneSubHeader
                view.addSubview(pageOneSubHeader)
                pageOneSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageOneSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageOneSubHeader.topAnchor.constraint(equalTo: pageOneMainHeader.bottomAnchor).isActive = true

                //NSLayoutConstraint for trekNameLabel
                view.addSubview(trekNameLabel)
                trekNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                trekNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                trekNameLabel.topAnchor.constraint(equalTo: pageOneSubHeader.bottomAnchor, constant: view.frame.height/16).isActive = true

                //NSLayoutConstraint for (backdropLabel)
                view.addSubview(backdropLabel)
                backdropLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/22).isActive = true
                backdropLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
                backdropLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
                backdropLabel.topAnchor.constraint(equalTo: trekNameLabel.bottomAnchor).isActive = true

                //NSLayoutConstraint for inputTrekName
                view.addSubview(inputTrekName)
                inputTrekName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                inputTrekName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                inputTrekName.heightAnchor.constraint(equalToConstant: 50).isActive = true
                inputTrekName.topAnchor.constraint(equalTo: trekNameLabel.bottomAnchor).isActive = true

                //NSLayoutConstraint for imgViewName
                view.addSubview(imgViewName)
                imgViewName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/16).isActive = true
                imgViewName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/16).isActive = true
                imgViewName.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.height/8).isActive = true
                imgViewName.topAnchor.constraint(equalTo: inputTrekName.bottomAnchor, constant: view.frame.height/28).isActive = true

                newTrekSV.addSubview(view)
                 
             }else if (i == 1){
                
                //View for page 2
                let view: UIView = UIView(frame: frame)
                view.clipsToBounds = true
                view.backgroundColor = .clear
                view.layer.borderColor = UIColor.clear.cgColor
                view.layer.borderWidth = 1

                //NSLayoutConstraint for pageTwoMainHeader
                view.addSubview(pageTwoMainHeader)
                pageTwoMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageTwoMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageTwoMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true

                //NSLayoutConstraint for pageTwoSubHeader
                view.addSubview(pageTwoSubHeader)
                pageTwoSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageTwoSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageTwoSubHeader.topAnchor.constraint(equalTo: pageTwoMainHeader.bottomAnchor).isActive = true

                //NSLayoutConstraint for trekDestination
                view.addSubview(trekDestination)
                trekDestination.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                trekDestination.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                trekDestination.topAnchor.constraint(equalTo: pageTwoSubHeader.bottomAnchor, constant: view.frame.height/16).isActive = true

                //NSLayoutConstraint for backdropLabelTwo
                view.addSubview(backdropLabelTwo)
                backdropLabelTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/22).isActive = true
                backdropLabelTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
                backdropLabelTwo.heightAnchor.constraint(equalToConstant: 50).isActive = true
                backdropLabelTwo.topAnchor.constraint(equalTo: trekDestination.bottomAnchor).isActive = true

                //NSLayoutConstraint for inputTrekDestination
                view.addSubview(inputTrekDestination)
                inputTrekDestination.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                inputTrekDestination.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                inputTrekDestination.heightAnchor.constraint(equalToConstant: 50).isActive = true
                inputTrekDestination.topAnchor.constraint(equalTo: trekDestination.bottomAnchor).isActive = true


                
                
                //NSLayoutConstraint for imgViewDest
                view.addSubview(imgViewDest)
                imgViewDest.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/16).isActive = true
                imgViewDest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/16).isActive = true
                imgViewDest.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.height/8).isActive = true
                imgViewDest.topAnchor.constraint(equalTo: inputTrekDestination.bottomAnchor, constant: view.frame.height/28).isActive = true

                newTrekSV.addSubview(view)
                
             }else if (i == 2){
                
                //View for page 3
                let view: UIView = UIView(frame: frame)
                view.clipsToBounds = true
                view.backgroundColor = .clear
                view.layer.borderColor = UIColor.clear.cgColor
                view.layer.borderWidth = 1

                //NSLayoutConstraint for pageThreeMainHeader
                view.addSubview(pageThreeMainHeader)
                pageThreeMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageThreeMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageThreeMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true

                //NSLayoutConstraint for pageThreeSubHeader
                view.addSubview(pageThreeSubHeader)
                pageThreeSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageThreeSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageThreeSubHeader.topAnchor.constraint(equalTo: pageThreeMainHeader.bottomAnchor).isActive = true

                //NSLayoutConstraint for departureLabel
                view.addSubview(departureLabel)
                departureLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/18).isActive = true
                departureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                departureLabel.topAnchor.constraint(equalTo: pageThreeSubHeader.bottomAnchor, constant: view.frame.height/16).isActive = true
                
                //NSLayoutConstraint for backdropLabelThree
                view.addSubview(backdropLabelThree)
                backdropLabelThree.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/18).isActive = true
                backdropLabelThree.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
                backdropLabelThree.heightAnchor.constraint(equalToConstant: 50).isActive = true
                backdropLabelThree.topAnchor.constraint(equalTo: departureLabel.bottomAnchor).isActive = true
                
                //NSLayoutConstraint for inputDeparture
                view.addSubview(inputDeparture)
                inputDeparture.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/18).isActive = true
                inputDeparture.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                inputDeparture.heightAnchor.constraint(equalToConstant: 50).isActive = true
                inputDeparture.topAnchor.constraint(equalTo: departureLabel.bottomAnchor).isActive = true

                //NSLayoutConstraint for returnLabel
                view.addSubview(returnLabel)
                returnLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                returnLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/18).isActive = true
                returnLabel.topAnchor.constraint(equalTo: pageThreeSubHeader.bottomAnchor, constant: view.frame.height/16).isActive = true

                //NSLayoutConstraint for (backdropLabelFour)
                view.addSubview(backdropLabelFour)
                backdropLabelFour.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                backdropLabelFour.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/22).isActive = true
                backdropLabelFour.heightAnchor.constraint(equalToConstant: 50).isActive = true
                backdropLabelFour.topAnchor.constraint(equalTo: returnLabel.bottomAnchor).isActive = true
                
                //NSLayoutConstraint for inputReturn
                view.addSubview(inputReturn)
                inputReturn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                inputReturn.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/18).isActive = true
                inputReturn.heightAnchor.constraint(equalToConstant: 50).isActive = true
                inputReturn.topAnchor.constraint(equalTo: returnLabel.bottomAnchor).isActive = true

                
                //NSLayoutConstraint for imgViewDep
                view.addSubview(imgViewDep)
                imgViewDep.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/16).isActive = true
                imgViewDep.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/16).isActive = true
                imgViewDep.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.height/8).isActive = true
                imgViewDep.topAnchor.constraint(equalTo: inputReturn.bottomAnchor, constant: view.frame.height/28).isActive = true
                imgViewDep.topAnchor.constraint(equalTo: inputReturn.bottomAnchor, constant: view.frame.height/28).isActive = true

                newTrekSV.addSubview(view)
                
             }else if (i == 3){
                
                //View for page 4
                let view: UIView = UIView(frame: frame)
                view.clipsToBounds = true
                view.backgroundColor = .clear
                view.layer.borderColor = UIColor.clear.cgColor
                view.layer.borderWidth = 1

                //NSLayoutConstraint for pageFourMainHeader
                view.addSubview(pageFourMainHeader)
                pageFourMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageFourMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageFourMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true

                //NSLayoutConstraint for pageFourSubHeader
                view.addSubview(pageFourSubHeader)
                pageFourSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageFourSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageFourSubHeader.topAnchor.constraint(equalTo: pageFourMainHeader.bottomAnchor).isActive = true

                //NSLayoutConstraint for backdropLabelFive
                view.addSubview(backdropLabelFive)
                backdropLabelFive.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                backdropLabelFive.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                backdropLabelFive.heightAnchor.constraint(equalToConstant: 50).isActive = true
                backdropLabelFive.topAnchor.constraint(equalTo: pageFourSubHeader.bottomAnchor, constant: view.frame.height/16).isActive = true

                //NSLayoutConstraint for inputItem
                view.addSubview(inputItem)
                inputItem.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/16).isActive = true
                inputItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/14).isActive = true
                inputItem.heightAnchor.constraint(equalToConstant: 50).isActive = true
                inputItem.topAnchor.constraint(equalTo: backdropLabelFive.topAnchor).isActive = true

                //ItemsTableView settings
                itemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
                itemsTableView.tableFooterView = UIView()
                itemsTableView.translatesAutoresizingMaskIntoConstraints = false
                itemsTableView.separatorColor = SingletonStruct.newBlack
                itemsTableView.separatorInset = .zero
                itemsTableView.layoutMargins = .zero
                itemsTableView.preservesSuperviewLayoutMargins = false
                itemsTableView.layer.borderColor = SingletonStruct.testBlue.cgColor
                itemsTableView.layer.borderWidth = 1
                itemsTableView.layer.cornerRadius = 10
                itemsTableView.contentInsetAdjustmentBehavior = .never
                itemsTableView.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)

                //NSLayoutConstraint for itemsTableView
                view.addSubview(itemsTableView)
                itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
                itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
                itemsTableView.topAnchor.constraint(equalTo: inputItem.bottomAnchor, constant: view.frame.width/18).isActive = true
                itemsTableView.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.height/7.5).isActive = true

                view.bringSubviewToFront(itemsTableView)

                newTrekSV.addSubview(view)
                 
             }else if (i == 4){
                
                //View for page 5
                let view: UIView = UIView(frame: frame)
                view.clipsToBounds = true
                view.backgroundColor = .clear
                view.layer.borderColor = UIColor.clear.cgColor
                view.layer.borderWidth = 1
                 
                //NSLayoutConstraint for pageFiveMainHeader
                view.addSubview(pageFiveMainHeader)
                pageFiveMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageFiveMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageFiveMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true

                //NSLayoutConstraint for pageFiveSubHeader
                view.addSubview(pageFiveSubHeader)
                pageFiveSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                pageFiveSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                pageFiveSubHeader.topAnchor.constraint(equalTo: pageFiveMainHeader.bottomAnchor).isActive = true
                
                //NSLayoutConstraint for tagLabel
                view.addSubview(tagLabel)
                tagLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
                tagLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
                tagLabel.topAnchor.constraint(equalTo: pageFiveSubHeader.bottomAnchor, constant: view.frame.width/32).isActive = true
                   
                //NSLayoutConstraint for backdropLabelSix
                view.addSubview(backdropLabelSix)
                backdropLabelSix.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                backdropLabelSix.leadingAnchor.constraint(equalTo: tagLabel.trailingAnchor, constant: view.frame.width/32).isActive = true
                backdropLabelSix.heightAnchor.constraint(equalToConstant: 50).isActive = true
                backdropLabelSix.topAnchor.constraint(equalTo: pageFiveSubHeader.bottomAnchor, constant: view.frame.width/32).isActive = true

                 //NSLayoutConstraint for tagsField
                 view.addSubview(tagsField)
                 tagsField.widthAnchor.constraint(equalToConstant: view.frame.width/2 - view.frame.width/32 - view.frame.width/11).isActive = true
                 tagsField.leadingAnchor.constraint(equalTo: tagLabel.trailingAnchor, constant: view.frame.width/22).isActive = true
                 tagsField.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 tagsField.topAnchor.constraint(equalTo: pageFiveSubHeader.bottomAnchor, constant: view.frame.width/32).isActive = true
                 tagsField.inputView = tagPicker

                //NSLayoutConstraint imageLabel
                view.addSubview(imageLabel)
                imageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                imageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                imageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
                imageLabel.topAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: view.frame.width/32).isActive = true
             
                //NSLayoutConstraint for imgView
                view.addSubview(imgView)
                imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                imgView.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.height/10).isActive = true
                imgView.topAnchor.constraint(equalTo: imageLabel.bottomAnchor).isActive = true
                
                //NSLayoutConstraint for placeHolderImage
                view.addSubview(placeHolderImage)
                placeHolderImage.centerXAnchor.constraint(equalTo: imgView.centerXAnchor).isActive = true
                placeHolderImage.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive = true
                placeHolderImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
                placeHolderImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
                 
                //NSLayoutConstraint for clearImageButton
                view.addSubview(clearImageButton)
                clearImageButton.bottomAnchor.constraint(equalTo: imgView.topAnchor, constant: -view.frame.width/64).isActive = true
                clearImageButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
                clearImageButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
                clearImageButton.trailingAnchor.constraint(equalTo: imgView.trailingAnchor).isActive = true
                clearImageButton.isHidden = true
                clearImageButton.isUserInteractionEnabled = false
                 
                //NSLayoutConstraint for spinner
                view.addSubview(spinner)
                spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                 
                newTrekSV.addSubview(view)
             }
        }
         newTrekSV.contentSize = CGSize(width: newTrekSV.frame.size.width * 5, height: newTrekSV.frame.size.height)
     }
    
    
    //MARK: showMapView
    @objc func showMapView(){
        presentInFullScreen(MapViewController(), animated: true)
    }

    
    //MARK: Scroll View UI
    let previousButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Prev", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray]), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(NewTrekVC.prevPage), for: .touchDown)
        return button
    }()
    
    let nextButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Next", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(NewTrekVC.nextPage), for: .touchDown)
        return button
    }()
    
    let pageControl: UIPageControl = {
       let pc = UIPageControl()
        
        pc.isUserInteractionEnabled = false
        pc.currentPage = 0
        pc.numberOfPages = 5
        pc.currentPageIndicatorTintColor = SingletonStruct.testBlue
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
        
    }()
    
    let cancelButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray]), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(NewTrekVC.cancelTrek), for: .touchDown)
        return button
    }()
    
    let finishButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Finish", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(NewTrekVC.finishTrek), for: .touchDown)
        return button
    }()
    
    //MARK: Page 1 UI
    let pageOneMainHeader:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "Let's Get Started!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.attributedText = labelContent
        return label
    }()
    
    let pageOneSubHeader:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        let labelContent = NSAttributedString(string: "Here is where your Trek begins, start by entering your Trek's name below!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.attributedText = labelContent
        return label
    }()
    
    let trekNameLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "My Trek's name is...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
         label.attributedText = labelContent
        return label
    }()
    
    let inputTrekName:TextField = {
        let textField = TextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.newBlack
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0
        textField.font = SingletonStruct.inputFont
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 14
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .yes
        return textField
    }()
    
    let backdropLabel:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imgViewName:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.image = UIImage(named: "trekking")
        return view
    }()
    
    //MARK: Page 2 UI
    let pageTwoMainHeader:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "Next Up: Destination!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.attributedText = labelContent
        return label
    }()
    
    let pageTwoSubHeader:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        let labelContent = NSAttributedString(string: "The Trek is all about the destination! Please enter your Trek's destination below.", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.attributedText = labelContent
        return label
    }()
    
    let trekDestination:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "My Trek's destination is...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
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
    
    let imgViewDest:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.image = UIImage(named: "destination")
        return view
    }()
    
    //MARK: Page 3 UI
    let pageThreeMainHeader:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        let labelContent = NSAttributedString(string: "Departure & Return!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.attributedText = labelContent
        return label
    }()
    
    let pageThreeSubHeader:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        let labelContent = NSAttributedString(string: "The departure and return dates of your Trek define its structure. Enter them below.", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.attributedText = labelContent
        return label
    }()
    
    let departureLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "Departure", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
         label.attributedText = labelContent
        return label
    }()
    
    let inputDeparture:TextField = {
        let textField = TextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.newBlack
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
    
    let returnLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "Return", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
         label.attributedText = labelContent
        return label
    }()
    
    let inputReturn:TextField = {
        let textField = TextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.newBlack
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
    
    let backdropLabelFour:UIView = {
       let view = UIView()
       view.layer.cornerRadius = 10
       view.layer.borderColor = UIColor.black.cgColor
       view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
   }()
    
    let imgViewDep:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.image = UIImage(named: "travel")
        return view
    }()
    
    //MARK: Page 4 UI
    let pageFourMainHeader:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        let labelContent = NSAttributedString(string: "What to bring?", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.attributedText = labelContent
        return label
    }()
    
    let pageFourSubHeader:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        let labelContent = NSAttributedString(string: "You will need to bring some things along with you. To keep track of what you need use the table below.", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.attributedText = labelContent
        return label
    }()
    
    let backdropLabelFive:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let inputItem:TextField = {
        let textField = TextField()
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
    
    //MARK: tableViewEditingStyle
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SingletonStruct.tempTrek.items.remove(at: indexPath.row)
            SingletonStruct.tempTrek.crosses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    //MARK: numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SingletonStruct.tempTrek.items.count
    }
    
    //MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        cell.textLabel?.attributedText = NSAttributedString(string: SingletonStruct.tempTrek.items[indexPath.row], attributes: [NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
        cell.backgroundColor = .clear
        cell.textLabel?.font = SingletonStruct.inputFont
        cell.selectionStyle = .none
        return cell
    }
    
    //MARK: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        }
    
    //MARK: Page 5 UI
    let tagPicker:UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.8)
        return picker
    }()
    
    let pageFiveMainHeader:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        let labelContent = NSAttributedString(string: "Personalize your Trek!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.attributedText = labelContent
        return label
    }()
    
    let pageFiveSubHeader:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        let labelContent = NSAttributedString(string: "Adding some tags and an image for your Trek will help personalize it!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.attributedText = labelContent
        return label
        
    }()
    
    let tagLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "Tags for my Trek", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
        label.attributedText = labelContent
        return label
    }()
    
    let backdropLabelSix:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tagsField:TextField = {
        let textField = TextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.newWhite
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0
        textField.clearButtonMode = .never
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.font = SingletonStruct.tagFont
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.attributedPlaceholder = NSAttributedString(string: "Tags", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
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
    
    let imageLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let labelContent = NSAttributedString(string: "Trek image", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
         label.attributedText = labelContent
        return label
    }()
    
    let imgView:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = SingletonStruct.testBlue.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    let placeHolderImage:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "up-img")
        view.contentMode = .scaleAspectFill
        return view
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
    
    let spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = SingletonStruct.testBlue
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
}
