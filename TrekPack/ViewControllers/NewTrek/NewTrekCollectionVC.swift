//
//  NewTrekCollectionVC.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-24.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit

class NewTrekCollectionVC: UIViewController, UIScrollViewDelegate,UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource ,UITableViewDataSource, UITableViewDelegate{
    
    
    let cellReuseID = "cell"
    
    var itemsTableView = AutomaticHeightTableView()
    
    var trekToWorkWith = AllTreks.treksArray.count
    
    var pages:[UIView] = []
    
    var currPage:Int = 0
    
    var newTrekSV = UIScrollView()
    
    var datePicker = UIDatePicker()
    
    var tagOne = ""
    var tagTwo = ""
    var tagThree = ""
    
    let tags = ["", "🚌", "🚈", "✈️", "🛶", "⛵️", "🛳", "🏰", "🏝","🌲", "🌴","🏔", "⛺️", "🗽", "🏛", "🏟", "🏙", "🌆", "🌉", "🏞", "🎣", "🤿", "🏂", "🪂", "🏄🏻‍♂️", "🧗‍♀️", "🚴", "🌞", "🌻", "🌚", "🌙", "🌈", "🌊", "🌍", "🗺", "❄️", "⛄️" ]

    var newTrek = TrekStruct(name: "", destination: "", departureDate: "", returnDate: "", items: [], tags: [], image: UIImage(named: "sm")!, imageName: "sm")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AllTreks.treksArray.append(newTrek)
       
        self.newTrekSV.contentInsetAdjustmentBehavior = .never
        view.viewAddBackground(imgName: "sm")
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.backgroundColor = SingletonStruct.purpColor
        
        
        delegateSetup()
        createDatePicker()
        setupLayout()
        
    }
    
    //Delegates
    private func delegateSetup(){
        newTrekSV.delegate = self
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
        tagsField.inputView = tagPicker
        
        
    }
    
    //Date Picker Stuff
    func createDatePicker(){
        
        //Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //Bar Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(NewTrekCollectionVC.donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        //assign toolbar
        inputDeparture.inputAccessoryView = toolbar
        inputReturn.inputAccessoryView = toolbar
    
        //assign date picker
        inputDeparture.inputView = datePicker
        inputReturn.inputView = datePicker
    }
    @objc func donePressed(){
        let formatter = DateFormatter()
        
        
        formatter.dateFormat = "dd/MM/yyyy"

        formatter.locale = Locale(identifier: "en_US_POSIX")

        
        if (inputDeparture.isFirstResponder){
            inputDeparture.text = formatter.string(from: datePicker.date)
            print("Selecting departure")
        }
        
        if (inputReturn.isFirstResponder){
            inputReturn.text = formatter.string(from: datePicker.date)
            print("Selecting return")
        }
        
    
        
        self.view.endEditing(true)
        
       
        
    }
    
    
    private func setupLayout(){
   
        newTrekSV = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        newTrekSV.isPagingEnabled = true
        newTrekSV.backgroundColor = .blue
        
        
        ///TODO: Figure out how to change the currPage and page control based on the swipe gesture
        newTrekSV.isScrollEnabled = false
        
        newTrekSV.translatesAutoresizingMaskIntoConstraints = false
    
        newTrekSV.contentInset = .zero
        newTrekSV.showsVerticalScrollIndicator = false
        newTrekSV.showsHorizontalScrollIndicator = false
        newTrekSV.clipsToBounds = true
        
    
        var frame = CGRect(x: -newTrekSV.frame.width, y: 0, width: 0, height: 0)

        for i in 0...4{

            frame.origin.x += newTrekSV.frame.size.width
            frame.size = newTrekSV.frame.size
            
            view.addSubview(newTrekSV)
            newTrekSV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            newTrekSV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            newTrekSV.heightAnchor.constraint(equalToConstant: newTrekSV.frame.height).isActive = true
            newTrekSV.widthAnchor.constraint(equalToConstant: newTrekSV.frame.width).isActive = true
            
            view.addSubview(previousButton)
            previousButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width/4).isActive = true
            previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
            previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
             
            view.addSubview(nextButton)
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width/4).isActive = true
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
            
            
            view.addSubview(pageControl)
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/4).isActive = true
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/4).isActive = true
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/16).isActive = true
            
            
            
            //FIRST PAGE STUFF
            if (i == 0){
                
                let view: UIView = UIView(frame: frame)
                
                
                view.clipsToBounds = true
                view.backgroundColor = .clear
                view.layer.borderColor = UIColor.clear.cgColor
                view.viewAddBackground(imgName: "sm")
                view.layer.borderWidth = 1
                
                //Constraints
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
                 
              
                newTrekSV.addSubview(view)
                
            //SECOND PAGE STUFF
            }else if (i == 1){
                let view: UIView = UIView(frame: frame)
                
                view.clipsToBounds = true
                view.backgroundColor = .clear
                view.layer.borderColor = UIColor.clear.cgColor
                view.viewAddBackground(imgName: "sm")
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
                 
                
                newTrekSV.addSubview(view)
            }else if (i == 2){
                let view: UIView = UIView(frame: frame)
                
                view.clipsToBounds = true
                view.backgroundColor = .clear
                view.layer.borderColor = UIColor.clear.cgColor
                view.viewAddBackground(imgName: "sm")
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
                 
                
                newTrekSV.addSubview(view)
            }else if (i == 3){
                let view: UIView = UIView(frame: frame)
                
                view.clipsToBounds = true
                view.backgroundColor = .clear
                view.layer.borderColor = UIColor.clear.cgColor
                view.viewAddBackground(imgName: "sm")
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
                backdropLabelFive.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/22).isActive = true
                backdropLabelFive.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
                backdropLabelFive.heightAnchor.constraint(equalToConstant: 50).isActive = true
                backdropLabelFive.topAnchor.constraint(equalTo: pageFourSubHeader.bottomAnchor, constant: view.frame.height/16).isActive = true
                
                view.addSubview(inputItem)
                inputItem.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                inputItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
                inputItem.heightAnchor.constraint(equalToConstant: 50).isActive = true
                inputItem.topAnchor.constraint(equalTo: backdropLabelFive.topAnchor).isActive = true
                
                itemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
                itemsTableView.tableFooterView = UIView()
                itemsTableView.translatesAutoresizingMaskIntoConstraints = false
                itemsTableView.separatorColor = .lightGray
                itemsTableView.separatorInset = .zero
                itemsTableView.layoutMargins = .zero
                itemsTableView.preservesSuperviewLayoutMargins = false
                itemsTableView.layer.borderColor = UIColor.clear.cgColor
                itemsTableView.layer.cornerRadius = 10
                itemsTableView.contentInsetAdjustmentBehavior = .never
                itemsTableView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
                
                view.addSubview(itemsTableView)
                
                itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
                itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
                itemsTableView.topAnchor.constraint(equalTo: inputItem.bottomAnchor, constant: view.frame.width/12).isActive = true
                itemsTableView.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.height/7.5).isActive = true
                
                newTrekSV.addSubview(view)
                
            }else if (i == 4){
                let view: UIView = UIView(frame: frame)
                
                view.clipsToBounds = true
                view.backgroundColor = .clear
                view.layer.borderColor = UIColor.clear.cgColor
                view.viewAddBackground(imgName: "sm")
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
//                tagLabel.trailingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                tagLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/22).isActive = true
                tagLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
                tagLabel.topAnchor.constraint(equalTo: pageFiveSubHeader.bottomAnchor, constant: view.frame.width/32).isActive = true
                
                view.addSubview(backdropLabelSix)
                backdropLabelSix.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
                backdropLabelSix.leadingAnchor.constraint(equalTo: tagLabel.trailingAnchor, constant: view.frame.width/32).isActive = true
                backdropLabelSix.heightAnchor.constraint(equalToConstant: 50).isActive = true
                backdropLabelSix.topAnchor.constraint(equalTo: pageFiveSubHeader.bottomAnchor, constant: view.frame.width/32).isActive = true

                view.addSubview(tagsField)
//                tagsField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/22).isActive = true
                tagsField.widthAnchor.constraint(equalToConstant: view.frame.width/2 - view.frame.width/32 - view.frame.width/11).isActive = true
                tagsField.leadingAnchor.constraint(equalTo: tagLabel.trailingAnchor, constant: view.frame.width/22).isActive = true
                tagsField.heightAnchor.constraint(equalToConstant: 50).isActive = true
                tagsField.topAnchor.constraint(equalTo: pageFiveSubHeader.bottomAnchor, constant: view.frame.width/32).isActive = true
//                

                newTrekSV.addSubview(view)
                
            }
       }
        
        newTrekSV.contentSize = CGSize(width: newTrekSV.frame.size.width * 5, height: newTrekSV.frame.size.height)
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
            
        tagsField.text = tagOne + " " +  tagTwo + " " + tagThree
    }
    

    ///TODO: Next button inifite click increases currPage
    @objc func nextPage(){
        currPage += 1
        pageControl.currentPage = currPage
        newTrekSV.scrollTo(horizontalPage: currPage, verticalPage: 0, animated: true)
        
    }
    
    @objc func prevPage(){
        print("Going to page: \(currPage)")
        
        if (currPage == 0){
            AllTreks.treksArray.remove(at: AllTreks.treksArray.count-1)
            dismiss(animated: true, completion: nil)
        }else{
            currPage -= 1
            pageControl.currentPage = currPage
            newTrekSV.scrollTo(horizontalPage: currPage, verticalPage: 0, animated: true)
            
        }
    }
    
    
    
    
    //Bottom controls
    let previousButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Prev", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray]), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(NewTrekCollectionVC.prevPage), for: .touchDown)
        return button
    }()
    let nextButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Next", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFont, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor]), for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(NewTrekCollectionVC.nextPage), for: .touchDown)
        return button
    }()
    let pageControl: UIPageControl = {
       let pc = UIPageControl()
        
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .gray
        pc.translatesAutoresizingMaskIntoConstraints = false
        
        
        return pc
        
    }()
    
    //PAGE 1 CONTENT-----------------------
    let pageOneMainHeader:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "Let's Get Started!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
        
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
        
        let labelContent = NSAttributedString(string: "Here is where your Trek begins, start by entering your Treks name below!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
        
        label.attributedText = labelContent
        return label
    }()
    let trekNameLabel:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "My Treks name is...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel])
        
         label.attributedText = labelContent
        return label
    }()
    let inputTrekName:UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.titleColor
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
        
        
        
         textField.attributedPlaceholder = NSAttributedString(string: "Untitled Trek", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .yes
        
        
        
        
      
        
        return textField
    }()
    let backdropLabel:UIView = {
        
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
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

        let labelContent = NSAttributedString(string: "Next Up: Destination!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
        
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
        
        let labelContent = NSAttributedString(string: "The Trek is all about the destination! Please enter your Treks destination below.", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
        
        label.attributedText = labelContent
        return label
    }()
    let trekDestination:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "My Treks destination is...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel])
        
         label.attributedText = labelContent
        return label
    }()
    let inputTrekDestination:UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.titleColor
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
        
         textField.attributedPlaceholder = NSAttributedString(string: "Untitled Destination", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .yes
        
        
        
        
      
        
        return textField
    }()
    let backdropLabelTwo:UIView = {
        
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
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

        let labelContent = NSAttributedString(string: "Trek Departure and Return!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
        
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
        
        let labelContent = NSAttributedString(string: "The departure and return dates of your Trek define its structure! Enter them below.", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
        
        label.attributedText = labelContent
        return label
    }()
    let departureLabel:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "Departure", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel])
        
         label.attributedText = labelContent
        return label
    }()
    let inputDeparture:UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.titleColor
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

        let labelContent = NSAttributedString(string: "Return", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel])
        
         label.attributedText = labelContent
        return label
    }()
    let inputReturn:UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.titleColor
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
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    let backdropLabelFour:UIView = {
           
           let view = UIView()
           
           view.layer.cornerRadius = 10
           view.layer.borderColor = UIColor.black.cgColor
           view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
           
           view.translatesAutoresizingMaskIntoConstraints = false
           
           return view
       }()
    //PAGE 3 CONTENT-----------------------
    
    //PAGE 4 CONTENT-----------------------
    let pageFourMainHeader:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0

        let labelContent = NSAttributedString(string: "What to bring?", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
        
        label.attributedText = labelContent
        return label
    }()
    let pageFourSubHeader:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        let labelContent = NSAttributedString(string: "You will need to bring some things along with you, to keep track of what you need use the table below.", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
        
        label.attributedText = labelContent
        return label
    }()
    let backdropLabelFive:UIView = {
        
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    let inputItem:UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.titleColor
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
          
        textField.attributedPlaceholder = NSAttributedString(string: "Some item...", attributes: [NSAttributedString.Key.font: SingletonStruct.inputFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
          
        
        
          
        return textField
    }()
    //For deleting from the table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            AllTreks.treksArray[AllTreks.treksArray.count-1].items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        
        }
    }
    //Number of sections in the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //Number of items in the table view -- number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray[AllTreks.treksArray.count-1].items.count
    }
    //Going through each cell and populating them with the data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        cell.textLabel?.attributedText = NSAttributedString(string: AllTreks.treksArray[AllTreks.treksArray.count-1].items[indexPath.row], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])

        cell.backgroundColor = .clear
        
        cell.textLabel?.font = SingletonStruct.inputItemFont
     
        cell.selectionStyle = .none
        return cell
    }
    //Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        }
    //PAGE 4 CONTENT-----------------------
    
    
    //PAGE 5 CONTENT-----------------------
    let tagPicker:UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = SingletonStruct.purpColor
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

        let labelContent = NSAttributedString(string: "Personalize your Trek!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
        
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
        
        let labelContent = NSAttributedString(string: "Adding some tags and an image for your Trek will help personalize it!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
        
        label.attributedText = labelContent
        return label
    }()
    let tagLabel:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "Tags for my trek", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel])
        
         label.attributedText = labelContent
        return label
    }()
    let backdropLabelSix:UIView = {
        
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    let tagsField:UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = SingletonStruct.titleColor
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0
        
        
        textField.adjustsFontSizeToFitWidth = true
        
        
        textField.textAlignment = .left
        textField.contentVerticalAlignment = .center
        textField.returnKeyType = .done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.font = SingletonStruct.tagFont
        
//        textField.attributedPlaceholder = NSAttributedString(string: , attributes: [NSAttributedString.Key.font: SingletonStruct.tagFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = UITextAutocorrectionType.no
        
        
        return textField

    }()
    let imageLabel:UILabel = {
    
        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "Image", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel])
        
         label.attributedText = labelContent
        return label
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
        inputTrekName.resignFirstResponder()
        inputTrekDestination.resignFirstResponder()
        
        if (inputItem.isFirstResponder){
            if (inputItem.text == ""){
                print("Invalid item entered")
            }else{
                print("Adding item: \(inputItem.text!)")
                
                AllTreks.treksArray[AllTreks.treksArray.count-1].items.append(inputItem.text!)
                inputItem.text = ""
                itemsTableView.reloadData()
                inputItem.resignFirstResponder()
            }
        }
        return true
    }
    
    
            
        
        
    
    
}


extension UIScrollView {

    func scrollTo(horizontalPage: Int? = 0, verticalPage: Int? = 0, animated: Bool? = true) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        frame.origin.y = frame.size.width * CGFloat(verticalPage ?? 0)
        self.scrollRectToVisible(frame, animated: animated ?? true)
    }

}


