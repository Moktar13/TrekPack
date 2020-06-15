//
//  NewTrekVC.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-24.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit

class NewTrekVC: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource ,UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    let cellReuseID = "cell"
    
    var itemsTableView = UITableView()
        
    var pages:[UIView] = []
    
    var currPage:Int = 0
    
    var newTrekSV = UIScrollView()
    
    var datePicker = UIDatePicker()
    
    var tagOne = ""
    var tagTwo = ""
    var tagThree = ""
    

    var newTrek = TrekStruct(name: "", destination: "", departureDate: "", returnDate: "", items: [], tags: [], image: UIImage(named: "img")!, imageName: "img")
    
    deinit {
        print("OS reclaming NewTrek memory")
    }
    
    
    override var prefersStatusBarHidden: Bool {
      return true
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    
        AllTreks.treksArray.append(newTrek)
       
        self.newTrekSV.contentInsetAdjustmentBehavior = .never

        view.backgroundColor = SingletonStruct.backgroundColor
        
        overrideUserInterfaceStyle = .light
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.8)
        
        

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewTrekVC.getImage(tapGestureRecognizer:)))
        
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tapGestureRecognizer)
        
        addBottomControls()
        delegateSetup()
        createDatePicker()
        setupLayout()
        
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    
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
  
    override func viewDidAppear(_ animated: Bool) {
        if (SingletonStruct.doneMakingTrek == true){
            SingletonStruct.doneMakingTrek = false
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    //Delegates
    private func delegateSetup(){
        newTrekSV.delegate =  self
        inputTrekName.delegate = self
        inputTrekDestination.delegate = self
        inputDeparture.delegate = self
        inputReturn.delegate = self
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        inputItem.delegate = self
        tagsField.delegate = self
        tagPicker.dataSource = self
        tagPicker.delegate = self
    }
    

    //DATE PICKER
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
    @objc func donePressed(){
        let formatter = DateFormatter()
        
        
        formatter.dateFormat = "dd/MM/yyyy"

        formatter.locale = Locale(identifier: "en_US_POSIX")

        
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
        
       
        
    }
    
    
    //LAYOUT SETUP
    private func setupLayout(){
        
        
     
        var frame = CGRect(x: -newTrekSV.frame.width, y: 0, width: 0, height: 0)
         
         
        
        for i in 0...4{

            frame.origin.x += newTrekSV.frame.size.width
            frame.size = newTrekSV.frame.size
             
         
             //FIRST PAGE STUFF
            if (i == 0){
                 
                 let view: UIView = UIView(frame: frame)
                 
                 view.clipsToBounds = true
                 view.backgroundColor = .clear
                 view.layer.borderColor = UIColor.clear.cgColor
                 view.layer.borderWidth = 1
                
                 view.addSubview(pageOneMainHeader)
                 pageOneMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 pageOneMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 pageOneMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
                  
                 view.addSubview(pageOneSubHeader)
                 pageOneSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 pageOneSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 pageOneSubHeader.topAnchor.constraint(equalTo: pageOneMainHeader.bottomAnchor).isActive = true
                  
                 view.addSubview(trekNameLabel)
                 trekNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 trekNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 trekNameLabel.topAnchor.constraint(equalTo: pageOneSubHeader.bottomAnchor, constant: view.frame.height/16).isActive = true
                 
                 view.addSubview(backdropLabel)
                 backdropLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/22).isActive = true
                 backdropLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
                 backdropLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 backdropLabel.topAnchor.constraint(equalTo: trekNameLabel.bottomAnchor).isActive = true

                 view.addSubview(inputTrekName)
                 inputTrekName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 inputTrekName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 inputTrekName.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 inputTrekName.topAnchor.constraint(equalTo: trekNameLabel.bottomAnchor).isActive = true
                 
                 view.addSubview(imgViewName)
                 imgViewName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 imgViewName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 imgViewName.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.height/8).isActive = true
                 imgViewName.topAnchor.constraint(equalTo: inputTrekName.bottomAnchor, constant: view.frame.height/24).isActive = true
               
                 newTrekSV.addSubview(view)
                 
             //SECOND PAGE STUFF
             }else if (i == 1){
                 let view: UIView = UIView(frame: frame)
                 
                 view.clipsToBounds = true
                 view.backgroundColor = .clear
                 view.layer.borderColor = UIColor.clear.cgColor
                 view.layer.borderWidth = 1
                 
                 //Constraints
                 view.addSubview(pageTwoMainHeader)
                 pageTwoMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 pageTwoMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 pageTwoMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
                  
                 view.addSubview(pageTwoSubHeader)
                 pageTwoSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 pageTwoSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 pageTwoSubHeader.topAnchor.constraint(equalTo: pageTwoMainHeader.bottomAnchor).isActive = true
                  
                 
                 view.addSubview(trekDestination)
                 trekDestination.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 trekDestination.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 trekDestination.topAnchor.constraint(equalTo: pageTwoSubHeader.bottomAnchor, constant: view.frame.height/16).isActive = true
                 
                 view.addSubview(backdropLabelTwo)
                 backdropLabelTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/22).isActive = true
                 backdropLabelTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
                 backdropLabelTwo.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 backdropLabelTwo.topAnchor.constraint(equalTo: trekDestination.bottomAnchor).isActive = true

                 view.addSubview(inputTrekDestination)
                 inputTrekDestination.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 inputTrekDestination.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 inputTrekDestination.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 inputTrekDestination.topAnchor.constraint(equalTo: trekDestination.bottomAnchor).isActive = true
                 
                 
                 view.addSubview(imgViewDest)
                 imgViewDest.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 imgViewDest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 imgViewDest.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.height/8).isActive = true
                 imgViewDest.topAnchor.constraint(equalTo: inputTrekDestination.bottomAnchor, constant: view.frame.height/24).isActive = true
                 
                  
                 
                 newTrekSV.addSubview(view)
             }else if (i == 2){
                 let view: UIView = UIView(frame: frame)
                 
                 view.clipsToBounds = true
                 view.backgroundColor = .clear
                 view.layer.borderColor = UIColor.clear.cgColor
                 view.layer.borderWidth = 1
                 
                 //Constraints
                 view.addSubview(pageThreeMainHeader)
                 pageThreeMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 pageThreeMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 pageThreeMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
                  
                 view.addSubview(pageThreeSubHeader)
                 pageThreeSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 pageThreeSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 pageThreeSubHeader.topAnchor.constraint(equalTo: pageThreeMainHeader.bottomAnchor).isActive = true
                  
                 
                 view.addSubview(departureLabel)
                 departureLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/18).isActive = true
                 departureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 departureLabel.topAnchor.constraint(equalTo: pageThreeSubHeader.bottomAnchor, constant: view.frame.height/16).isActive = true
                 
                 view.addSubview(backdropLabelThree)
                 backdropLabelThree.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/18).isActive = true
                 backdropLabelThree.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
                 backdropLabelThree.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 backdropLabelThree.topAnchor.constraint(equalTo: departureLabel.bottomAnchor).isActive = true

                 view.addSubview(inputDeparture)
                 inputDeparture.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/18).isActive = true
                 inputDeparture.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 inputDeparture.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 inputDeparture.topAnchor.constraint(equalTo: departureLabel.bottomAnchor).isActive = true
                  
                 
                 view.addSubview(returnLabel)
                 returnLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 returnLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/18).isActive = true
                 returnLabel.topAnchor.constraint(equalTo: pageThreeSubHeader.bottomAnchor, constant: view.frame.height/16).isActive = true
                 
                 view.addSubview(backdropLabelFour)
                 backdropLabelFour.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 backdropLabelFour.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/22).isActive = true
                 backdropLabelFour.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 backdropLabelFour.topAnchor.constraint(equalTo: returnLabel.bottomAnchor).isActive = true

                 view.addSubview(inputReturn)
                 inputReturn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 inputReturn.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/18).isActive = true
                 inputReturn.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 inputReturn.topAnchor.constraint(equalTo: returnLabel.bottomAnchor).isActive = true
                 
                 view.addSubview(imgViewDep)
                 imgViewDep.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 imgViewDep.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 imgViewDep.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.height/8).isActive = true
                 imgViewDep.topAnchor.constraint(equalTo: inputReturn.bottomAnchor, constant: view.frame.height/24).isActive = true
                  
                 
                 newTrekSV.addSubview(view)
             }else if (i == 3){
                 let view: UIView = UIView(frame: frame)
                 
                 view.clipsToBounds = true
                 view.backgroundColor = .clear
                 view.layer.borderColor = UIColor.clear.cgColor
                 view.layer.borderWidth = 1
                 
                 //Constraints
                 view.addSubview(pageFourMainHeader)
                 pageFourMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 pageFourMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 pageFourMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
                  
                 view.addSubview(pageFourSubHeader)
                 pageFourSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 pageFourSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 pageFourSubHeader.topAnchor.constraint(equalTo: pageFourMainHeader.bottomAnchor).isActive = true
                 
                 view.addSubview(backdropLabelFive)
                 backdropLabelFive.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 backdropLabelFive.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 backdropLabelFive.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 backdropLabelFive.topAnchor.constraint(equalTo: pageFourSubHeader.bottomAnchor, constant: view.frame.height/16).isActive = true
                 
                 view.addSubview(inputItem)
                 
                 inputItem.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/16).isActive = true
                 inputItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/14).isActive = true
                 inputItem.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 inputItem.topAnchor.constraint(equalTo: backdropLabelFive.topAnchor).isActive = true
                 
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
                 
                 view.addSubview(itemsTableView)
                 
                 itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
                 itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
                 itemsTableView.topAnchor.constraint(equalTo: inputItem.bottomAnchor, constant: view.frame.width/18).isActive = true
                 itemsTableView.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.height/7.5).isActive = true
                 
                 newTrekSV.addSubview(view)
                 
             }else if (i == 4){
                 let view: UIView = UIView(frame: frame)
                 
                 view.clipsToBounds = true
                 view.backgroundColor = .clear
                 view.layer.borderColor = UIColor.clear.cgColor
                 view.layer.borderWidth = 1
                 
                 //Constraints
                 view.addSubview(pageFiveMainHeader)
                 pageFiveMainHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 pageFiveMainHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 pageFiveMainHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
                  
                 view.addSubview(pageFiveSubHeader)
                 pageFiveSubHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 pageFiveSubHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 pageFiveSubHeader.topAnchor.constraint(equalTo: pageFiveMainHeader.bottomAnchor).isActive = true
                 
                 view.addSubview(tagLabel)
                 tagLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
                 tagLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 tagLabel.topAnchor.constraint(equalTo: pageFiveSubHeader.bottomAnchor, constant: view.frame.width/32).isActive = true
                 
                 view.addSubview(backdropLabelSix)
                 backdropLabelSix.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 backdropLabelSix.leadingAnchor.constraint(equalTo: tagLabel.trailingAnchor, constant: view.frame.width/32).isActive = true
                 backdropLabelSix.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 backdropLabelSix.topAnchor.constraint(equalTo: pageFiveSubHeader.bottomAnchor, constant: view.frame.width/32).isActive = true

                 
                 view.addSubview(tagsField)
                 tagsField.widthAnchor.constraint(equalToConstant: view.frame.width/2 - view.frame.width/32 - view.frame.width/11).isActive = true
                 tagsField.leadingAnchor.constraint(equalTo: tagLabel.trailingAnchor, constant: view.frame.width/22).isActive = true
                 tagsField.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 tagsField.topAnchor.constraint(equalTo: pageFiveSubHeader.bottomAnchor, constant: view.frame.width/32).isActive = true
                 tagsField.inputView = tagPicker

                 view.addSubview(imageLabel)
                 imageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 imageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 imageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
                 imageLabel.topAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: view.frame.width/32).isActive = true
             
                 
                 view.addSubview(imgView)
                 imgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                 imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                 imgView.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.height/10).isActive = true
                 imgView.topAnchor.constraint(equalTo: imageLabel.bottomAnchor).isActive = true
                 
                 view.addSubview(clearImageButton)
                 clearImageButton.bottomAnchor.constraint(equalTo: imgView.topAnchor, constant: -view.frame.width/64).isActive = true
                 clearImageButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
                 clearImageButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
                 clearImageButton.trailingAnchor.constraint(equalTo: imgView.trailingAnchor).isActive = true
                 clearImageButton.isHidden = true
                 clearImageButton.isUserInteractionEnabled = false
                 
                 
                 
                 newTrekSV.addSubview(view)
             }
        }
         
         newTrekSV.contentSize = CGSize(width: newTrekSV.frame.size.width * 5, height: newTrekSV.frame.size.height)
     }
  

   
    
    

 
    
    
    
    
    
    ///UI DECLARATIONS BELOW~~

    //BOTTOM CONTROLS
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
    
    //PAGE 1 CONTENT-----------------------
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
        
        let labelContent = NSAttributedString(string: "Here is where your Trek begins, start by entering your Treks name below!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        
        label.attributedText = labelContent
        return label
    }()
    let trekNameLabel:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "My Treks name is...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
        
         label.attributedText = labelContent
        return label
    }()
    let inputTrekName:UITextField = {
        
        let textField = UITextField()
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
        view.image = UIImage(named: "name")
        
        return view
    }()
    //PAGE 1 CONTENT-----------------------
    
    //PAGE 2 CONTENT-----------------------
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
        
        let labelContent = NSAttributedString(string: "The Trek is all about the destination! Please enter your Treks destination below.", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        
        label.attributedText = labelContent
        return label
    }()
    let trekDestination:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "My Treks destination is...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
        
         label.attributedText = labelContent
        return label
    }()
    let inputTrekDestination:UITextField = {
        
        let textField = UITextField()
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
         textField.attributedPlaceholder = NSAttributedString(string: "Destination", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .yes
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
        view.image = UIImage(named: "world")


        return view
    }()
    //PAGE 2 CONTENT-----------------------
    
    //PAGE 3 CONTENT-----------------------
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
        
        let labelContent = NSAttributedString(string: "The departure and return dates of your Trek define its structure! Enter them below.", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        
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
    let inputDeparture:UITextField = {
        
        let textField = UITextField()
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
    let inputReturn:UITextField = {
        
        let textField = UITextField()
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
        view.image = UIImage(named: "dep")


        return view
    }()
    //PAGE 3 CONTENT-----------------------
    
    //PAGE 4 CONTENT-----------------------
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
        
        let labelContent = NSAttributedString(string: "You will need to bring some things along with you, to keep track of what you need use the table below.", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        
        label.attributedText = labelContent
        return label
    }()
    let backdropLabelFive:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = SingletonStruct.testBlue.withAlphaComponent(0.80)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let inputItem:UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.newWhite
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
          
        textField.attributedPlaceholder = NSAttributedString(string: "I need to bring...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testWhite])
          
        
        
          
        return textField
    }()
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            AllTreks.treksArray[AllTreks.treksArray.count-1].items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray[AllTreks.treksArray.count-1].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        cell.textLabel?.attributedText = NSAttributedString(string: AllTreks.treksArray[AllTreks.treksArray.count-1].items[indexPath.row], attributes: [NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
        cell.backgroundColor = .clear
        
        cell.textLabel?.font = SingletonStruct.inputFont
     
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        }
    //PAGE 4 CONTENT-----------------------
    
    //PAGE 5 CONTENT-----------------------
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

        let labelContent = NSAttributedString(string: "Tags for my trek", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
        
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
    let tagsField:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.newWhite
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0
        
        
        textField.adjustsFontSizeToFitWidth = true
        
        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
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
        view.image = UIImage(named: "img")
        
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
    //PAGE 5 CONTENT-----------------------
    
    
   
}








