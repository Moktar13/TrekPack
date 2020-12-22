//
//  ViewTrekViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-06.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit
import CoreLocation


//Class ViewTrekController which contains UI and functinality for viewing the trek
class ViewTrekViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UINavigationBarDelegate, UIScrollViewDelegate, CLLocationManagerDelegate {
    
    //Location variables
    var currentLocation: CLLocation!
    var locManager = CLLocationManager()
    var locationPermission = false
    
    //ScrollView
    var trekSV = UIScrollView()
    
    let navBar = UINavigationBar()
    var firstTap = true
    var pageFrom = 0
    
    //CellReuseID
    let cellReuseID = "cell"
    
    //itemsTableView
    var itemsTableView = UITableView()
    
    var hasDepDate:Bool = false
    var statusBarHeight: CGFloat = 0
    
    deinit {
        print("OS reclaiming ViewTrek memory")
    }
    
    
    //MARK: viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        
        //Saving trek because the user might have crossed off a item from their backpack
//        SingletonStruct.defaults.set(try? PropertyListEncoder().encode(SingletonStruct.allTreks), forKey: "\(SingletonStruct.defaultsKey)")
        
        trekInfoBtn.sendActions(for: .touchDown)
        
        
        
    }
    
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        
        pageControl.currentPage = pageControl.currentPage
        

        //Getting the status bar height
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        
        //Setting navigation bar attributes
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        let settingsItem = UIBarButtonItem(image: UIImage(named: "view-settings"), style: .plain, target: self, action: #selector(ViewTrekViewController.openSettings))
        
        
        self.navigationItem.rightBarButtonItem = settingsItem

        SingletonStruct.statusBarHeight = Double(statusBarHeight)
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
        //If the user edits their trek and deletes/add items, the trek must be reassesed when this viewcontroller load so that it may update the approprite UI
        trekNameLabel.attributedText = NSAttributedString(string: SingletonStruct.allTreks[SingletonStruct.selectedTrek].name, attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
    
        //setting destination
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:"map-pin")
        imageAttachment.bounds = CGRect(x: 0, y: -2.75, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: " \(SingletonStruct.allTreks[SingletonStruct.selectedTrek].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        completeText.append(textAfterIcon)
        trekDestLabel.adjustsFontSizeToFitWidth = true
        trekDestLabel.attributedText = completeText
        
        //setting the tags
        tagOneLabel.attributedText = NSAttributedString(string: "\(SingletonStruct.allTreks[SingletonStruct.selectedTrek].tags[0])", attributes: [NSAttributedString.Key.font: SingletonStruct.bigFont])
        tagTwoLabel.attributedText = NSAttributedString(string: "\(SingletonStruct.allTreks[SingletonStruct.selectedTrek].tags[1])", attributes: [NSAttributedString.Key.font: SingletonStruct.bigFont])
        tagThreeLabel.attributedText = NSAttributedString(string: "\(SingletonStruct.allTreks[SingletonStruct.selectedTrek].tags[2])", attributes: [NSAttributedString.Key.font: SingletonStruct.bigFont])
        
        //setting image
        imgView.image = UIImage(data: Data.init(base64Encoded: SingletonStruct.allTreks[SingletonStruct.selectedTrek].imgData, options: .init(rawValue: 0))!)
        
        //setting departure date and time left
        getDepartureDate()
        getTimeLeft()
    
        //Setting visibility of certain UI based on whether or not the user has any items
        if (SingletonStruct.allTreks[SingletonStruct.selectedTrek].items.count != 0){
            itemsImg.isHidden = true
        }else{
            itemsImg.isHidden = false
        }
        
        
        itemsTableView.reloadData()
        
        //Getting the distance
        getDistance()

        
        //Adding indication line under the trekInfoBtn, required for viewDidLoad
        if (trekInfoBtn.subviews.count == 0){
            trekInfoBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
        }
        
        trekInfoBtn.sendActions(for: .touchDown)
    }
    
    //MARK: viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        pageControl.currentPage = 0
    }
    
    
    //MARK: preferStatusBarHidden
    override var prefersStatusBarHidden: Bool {
      return false
    }
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = SingletonStruct.newWhite
   
        
        if (SingletonStruct.allTreks[SingletonStruct.selectedTrek].departureDate.isEmpty == false){
            hasDepDate = true
        }
        
        //Getting location authorization
        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager.location
            locationPermission = true
        }else{
            locationPermission = false
        }
         
        //Method calls
        setupScrollView()
        setupScreen()
        setupDelegate()
        setupScrollLayout()
        getTimeLeft()
        getDepartureDate()
        setupTableView()
    }
    
    //MARK: setupScrollView
    private func setupScrollView(){
        trekSV = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2 + view.frame.height/12))
        trekSV.translatesAutoresizingMaskIntoConstraints = false
        trekSV.contentInset = .zero
        trekSV.showsVerticalScrollIndicator = false
        trekSV.showsHorizontalScrollIndicator = false
        trekSV.clipsToBounds = true
        trekSV.contentInsetAdjustmentBehavior = .never
        trekSV.isScrollEnabled = false
        trekSV.isPagingEnabled = true
        trekSV.backgroundColor = .clear
    }
    
    
    
    //MARK: setupDelegate
    private func setupDelegate(){
        trekSV.delegate =  self
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        locManager.delegate = self
    }
    
    
    //MARK: updateControlTab
    func updateControlTab(){
        
        
        //Large if statement determing which page the user is coming/going to/from in order set the UI accordingly
        if (pageFrom == 0){
            
            if (firstTap){
                trekInfoBtn.subviews[0].removeFromSuperview()
                firstTap = false
            }else{
                trekInfoBtn.subviews[trekInfoBtn.subviews.count-1].removeFromSuperview()
            }
                    
            if (pageControl.currentPage == 1){
                
                trekItemsBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
                
                trekInfoBtn.setAttributedTitle(NSAttributedString(string: "Trek Information", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)

                trekItemsBtn.setAttributedTitle(NSAttributedString(string: "My Backpack", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)

                
            }
            
        }else if (pageFrom == 1){
            
            trekItemsBtn.subviews[trekItemsBtn.subviews.count-1].removeFromSuperview()
            
            if (pageControl.currentPage == 0){
                
                trekInfoBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
                
                trekItemsBtn.setAttributedTitle(NSAttributedString(string: "My Backpack", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)

                trekInfoBtn.setAttributedTitle(NSAttributedString(string: "Trek Information", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
                
            }
        }
    
        trekSV.scrollTo(horizontalPage: pageControl.currentPage, verticalPage: 0, animated: false)
    }
    
    
    func getPOI(){
        
    }
    
    //MARK: goToInformation
    @objc func goToInformation(){
        if (pageControl.currentPage != 0){
            pageFrom = pageControl.currentPage
            pageControl.currentPage = 0
            updateControlTab()
        }
    }
    
    
    //MARK: goToBackpack
    @objc func goToBackpack(){
        if (pageControl.currentPage != 1){
            pageFrom = pageControl.currentPage
            pageControl.currentPage = 1
            updateControlTab()
        }
    }
    
    
    //MARK: goToRoute
    @objc func goToRoute(){
        if (pageControl.currentPage != 2){
            pageFrom = pageControl.currentPage
            pageControl.currentPage = 2
            updateControlTab()
        }
    }
    
    //MARK: setupScrollLayout
    func setupScrollLayout(){
        var frame = CGRect(x: -trekSV.frame.width, y: 0, width: 0, height: 0)
    
        for i in 0...2{
            
            frame.origin.x += trekSV.frame.size.width
            frame.size = trekSV.frame.size
            
            //MARK: pageOne
            if (i == 0){
                
                //Creating page one view
                let viewOne: UIView = UIView(frame: frame)
                viewOne.clipsToBounds = true
                viewOne.backgroundColor = .clear
                viewOne.layer.borderColor = UIColor.clear.cgColor
                viewOne.layer.borderWidth = 1
                viewOne.backgroundColor = SingletonStruct.testWhite
                trekSV.addSubview(viewOne)
    
                //NameDestStack subviews
                nameDestStack.addArrangedSubview(trekNameLabel)
                nameDestStack.addArrangedSubview(trekDestLabel)
    
                //InfoStack subviews
                infoStack.addArrangedSubview(timeLeftLabel)
                infoStack.addArrangedSubview(depDateLabel)
                infoStack.addArrangedSubview(distanceLabel)
                
                //DetailsStack subviews
                detailStack.addArrangedSubview(trekDetails)
                detailStack.addArrangedSubview(infoStack)
            
                //TagStack subviews
                tagStack.addArrangedSubview(tagOneLabel)
                tagStack.addArrangedSubview(tagTwoLabel)
                tagStack.addArrangedSubview(tagThreeLabel)
                
                //PageOneStack subviews
                pageOneStack.addArrangedSubview(nameDestStack)
                pageOneStack.addArrangedSubview(detailStack)
                pageOneStack.addArrangedSubview(tagStack)
                
                viewOne.addSubview(pageOneStack)
            
                //Stack constraints
                pageOneStack.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: view.frame.width/12).isActive = true
                pageOneStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/12).isActive = true
                pageOneStack.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor).isActive = true
                pageOneStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
                infoStack.trailingAnchor.constraint(equalTo: pageOneStack.trailingAnchor).isActive = true
                tagStack.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 30).isActive = true
                detailStack.centerXAnchor.constraint(equalTo: pageOneStack.centerXAnchor).isActive = true
                
                //NSLayoutConstraint for detailsBackdrop
                viewOne.addSubview(detailsBackdrop)
                detailsBackdrop.centerYAnchor.constraint(equalTo: detailStack.centerYAnchor).isActive = true
                detailsBackdrop.centerXAnchor.constraint(equalTo: detailStack.centerXAnchor).isActive = true
                detailsBackdrop.heightAnchor.constraint(equalTo: detailStack.heightAnchor, constant: view.frame.height/20).isActive = true
                detailsBackdrop.widthAnchor.constraint(equalTo: detailStack.widthAnchor, constant: 20).isActive = true
                
                //NSLayoutConstraint for tipBackdrop
                viewOne.addSubview(tipBackdrop)
                tipBackdrop.widthAnchor.constraint(equalToConstant: 150).isActive = true
                tipBackdrop.centerYAnchor.constraint(equalTo: tagStack.centerYAnchor).isActive = true
                tipBackdrop.trailingAnchor.constraint(equalTo: viewOne.trailingAnchor, constant: 15).isActive = true
                tipBackdrop.heightAnchor.constraint(equalToConstant: 50).isActive = true

                //NSLayoutConstraint for tipButton
                viewOne.addSubview(tipButton)
                tipButton.centerYAnchor.constraint(equalTo: tipBackdrop.centerYAnchor).isActive = true
                tipButton.leadingAnchor.constraint(equalTo: tipBackdrop.leadingAnchor, constant: 7).isActive = true
                tipButton.trailingAnchor.constraint(equalTo: viewOne.trailingAnchor).isActive = true

                //NSLayoutConstraint for tipIcon
                viewOne.addSubview(tipIcon)
                tipIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
                tipIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
                tipIcon.centerYAnchor.constraint(equalTo: tipButton.centerYAnchor).isActive = true
                tipIcon.trailingAnchor.constraint(equalTo: viewOne.trailingAnchor, constant: -15).isActive = true
                
                //NSLayoutConstraint for distanceButton
                viewOne.addSubview(distanceButton)
                distanceButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
                distanceButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
                distanceButton.trailingAnchor.constraint(equalTo: detailStack.trailingAnchor, constant: -10).isActive = true
                distanceButton.topAnchor.constraint(equalTo: detailStack.topAnchor).isActive = true

                viewOne.sendSubviewToBack(tipIcon)
                viewOne.sendSubviewToBack(tipBackdrop)
                
            }
                
            //MARK: pageTwo
            else if (i == 1){
                
                //Page two main view
                let viewTwo: UIView = UIView(frame: frame)
                viewTwo.clipsToBounds = true
                viewTwo.layer.borderColor = UIColor.clear.cgColor
                viewTwo.layer.borderWidth = 1
                viewTwo.backgroundColor = SingletonStruct.testWhite
                trekSV.addSubview(viewTwo)
        
                //NSLayoutConstraints for backpackTitle
                viewTwo.addSubview(backpackTitle)
                backpackTitle.leadingAnchor.constraint(equalTo: whiteSpaceView.leadingAnchor, constant: view.frame.width/14).isActive = true
                backpackTitle.trailingAnchor.constraint(equalTo: whiteSpaceView.trailingAnchor, constant: -view.frame.width/14).isActive = true
                backpackTitle.topAnchor.constraint(equalTo: trekInfoBtn.bottomAnchor, constant: view.frame.width/12).isActive = true
                
                //NSLayoutConstraints for itemsTableView
                viewTwo.addSubview(itemsTableView)
                itemsTableView.leadingAnchor.constraint(equalTo: backpackTitle.leadingAnchor).isActive = true
                itemsTableView.trailingAnchor.constraint(equalTo: backpackTitle.trailingAnchor).isActive = true
                itemsTableView.topAnchor.constraint(equalTo: backpackTitle.bottomAnchor, constant: 10).isActive = true
                itemsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
                
                //If there are no items in the users backpack show this specific UI
                if (SingletonStruct.allTreks[SingletonStruct.selectedTrek].items.count == 0){
                    viewTwo.addSubview(itemsImg)
                    itemsImg.centerXAnchor.constraint(equalTo: itemsTableView.centerXAnchor).isActive = true
                    itemsImg.centerYAnchor.constraint(equalTo: itemsTableView.centerYAnchor).isActive = true
                    itemsImg.heightAnchor.constraint(equalToConstant: 100).isActive = true
                    itemsImg.widthAnchor.constraint(equalToConstant: 100).isActive = true
                }
            }
//            else if (i == 2){
//                //Page three main page
//                let viewThree: UIView = UIView(frame: frame)
//                viewThree.clipsToBounds = true
//                viewThree.layer.borderColor = UIColor.clear.cgColor
//                viewThree.layer.borderWidth = 1
//                viewThree.backgroundColor = SingletonStruct.testWhite
//                trekSV.addSubview(viewThree)
//            }
        }
        trekSV.contentSize = CGSize(width: trekSV.frame.size.width * 2, height: trekSV.frame.size.height)
    }
    
    //MARK: closeTrek
    @objc func closeTrek(){
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: openSettings
    @objc func openSettings(){
       
        //Alert controller which will allow the user to do specific actions to their trek
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editTrek = UIAlertAction(title: "Edit Trek", style: .default, handler: {
            (action) in
            SingletonStruct.makingNewTrek = false
            self.navigationController?.pushViewController(EditTrek(), animated: true)
        })
        
//        let shareTrek = UIAlertAction(title: "Share Trek", style: .default, handler: .none)
        let deleteTrek = UIAlertAction(title: "Delete Trek", style: .default, handler: { (action) in
            SingletonStruct.allTreks.remove(at: SingletonStruct.selectedTrek)
            self.navigationController?.popViewController(animated: true)
        })
        
        let cancelMenu = UIAlertAction(title: "Cancel", style: .cancel, handler: .none)
        
        cancelMenu.setValue(UIColor.red, forKey: "titleTextColor")
        
        
        //Creating the alert menu for the trek
        alert.addAction(editTrek)
//        alert.addAction(shareTrek)
        alert.addAction(deleteTrek)
        alert.addAction(cancelMenu)
        
        self.present(alert, animated: true)

    }
    
    
    
    
    //MARK: getDepartureDate
    func getDepartureDate(){
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        formatter.dateFormat = "dd/MM/yyyy"
        let depDate = formatter.date(from: SingletonStruct.allTreks[SingletonStruct.selectedTrek].departureDate)!
        
        formatter.dateFormat = "dd"
        let day = formatter.string(from: depDate)
        
        formatter.dateFormat = "MMM"
        let month = formatter.string(from: depDate)
        
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:"calender-1")
        imageAttachment.bounds = CGRect(x: 0, y: -2.75, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: " \(month) \(day)", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])
        
        completeText.append(textAfterIcon)
        depDateLabel.textAlignment = .center
        depDateLabel.attributedText = completeText
    }
    
    

    //MARK: getTimeLeft
    func getTimeLeft(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let depDate = formatter.date(from: SingletonStruct.allTreks[SingletonStruct.selectedTrek].departureDate)!
        
        //Getting todays date
        let currentDateTime = Date()

        let diffFormatter = DateComponentsFormatter()
        diffFormatter.allowedUnits = [.day]

        var dayDiff = (diffFormatter.string(from: currentDateTime, to: depDate)!)
        dayDiff = dayDiff.trimmingCharacters(in: .letters).trimmingCharacters(in: .whitespaces)
        dayDiff = dayDiff.replacingOccurrences(of: ",", with: "")
    
        let dayCountdown = Int(dayDiff)
        var textAfterIcon = NSAttributedString(string: " -1 days", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])
        
        //Setting text based on the number of days left until departure
        if (dayCountdown == 1){
            textAfterIcon = NSAttributedString(string: " \(dayCountdown!) day", attributes: [ NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])
        }else{
            
            if (dayCountdown! < 0){
                textAfterIcon = NSAttributedString(string: " Departed", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])
            }else{
                textAfterIcon = NSAttributedString(string: " \(dayCountdown!) days", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])
            }
        }
        
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:"clock")
        imageAttachment.bounds = CGRect(x: 0, y: -2.75, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        
        completeText.append(textAfterIcon)
        timeLeftLabel.textAlignment = .center
        timeLeftLabel.attributedText = completeText
    }
    
    
    //MARK: getDistance
    func getDistance(){
        var distanceUnit = "m"
        var distance = 0.0
        
        //If the user has allowed location data to be read
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            
            
            if (self.locManager.location == nil){
                
            }else{
                
                //Getting the destination location and the distance between current location and it
                let destinationLocation = CLLocation(latitude: SingletonStruct.allTreks[SingletonStruct.selectedTrek].latitude, longitude: SingletonStruct.allTreks[SingletonStruct.selectedTrek].longitude)

                distance = currentLocation.distance(from: destinationLocation)
            
                //If the distance is larger than 999m then change the distance unit to kilometers
                if (distance > 999){
                    distance = distance/1000
                    distanceUnit = "km"
                    distance = ceil(distance)
                }else{
                    distanceUnit = "m"
                }
                    
                
                //Updating the treks distance
                SingletonStruct.allTreks[SingletonStruct.selectedTrek].distanceUnit = distanceUnit
                SingletonStruct.allTreks[SingletonStruct.selectedTrek].distance = distance
                
                distanceButton.isHidden = true
                distanceButton.isUserInteractionEnabled = false
                
                
                DispatchQueue.background(background: {
                    SingletonStruct.defaults.set(try? PropertyListEncoder().encode(SingletonStruct.allTreks), forKey: "\(SingletonStruct.defaultsKey)")
                }, completion: {
                    print("Finished Saving New Distance")
                })
            }
            
        }else{
            distanceButton.isHidden = false
            distanceButton.isUserInteractionEnabled = true
            locationPermission = false
        }
        
        //Setting the text for the distance label
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:"map-1")
        imageAttachment.bounds = CGRect(x: 0, y: -2.75, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        
        if (SingletonStruct.allTreks[SingletonStruct.selectedTrek].distanceUnit.trimmingCharacters(in: .whitespaces).isEmpty){
            let textAfterIcon = NSAttributedString(string: " \(distance) \(distanceUnit)", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])

            completeText.append(textAfterIcon)
            distanceLabel.textAlignment = .center
            distanceLabel.attributedText = completeText
        }else{
            let textAfterIcon = NSAttributedString(string: " \(SingletonStruct.allTreks[SingletonStruct.selectedTrek].distance) \(SingletonStruct.allTreks[SingletonStruct.selectedTrek].distanceUnit)", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])

            completeText.append(textAfterIcon)
            distanceLabel.textAlignment = .center
            distanceLabel.attributedText = completeText
        }
    }
    
    
    //MARK: UI Declarations
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.isUserInteractionEnabled = false
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = SingletonStruct.testBlue
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
     }()
    
    let trekInfoBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Trek Information", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
        button.contentHorizontalAlignment = .right
        button.isHighlighted = false
        button.addTarget(self, action: #selector(ViewTrekViewController.goToInformation), for: .touchDown)
        return button
    }()
    
    let trekItemsBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.isHighlighted = false
        button.setAttributedTitle(NSAttributedString(string: "My Backpack", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(ViewTrekViewController.goToBackpack), for: .touchDown)
        return button
    }()
    
    let trekRouteBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "POI", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(ViewTrekViewController.goToRoute), for: .touchDown)
        return button
    }()

    let trekNameLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        let labelContent = NSAttributedString(string: SingletonStruct.allTreks[SingletonStruct.selectedTrek].name, attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
        label.attributedText = labelContent
        return label
    }()
     
    let trekDestLabel:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:"map-pin")
        // Set bound to reposition
        imageAttachment.bounds = CGRect(x: 0, y: -2.75, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: " \(SingletonStruct.allTreks[SingletonStruct.selectedTrek].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        completeText.append(textAfterIcon)
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = completeText
        return label
    }()
     
    let destinationIcon:UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "map-pin")
        return imgView
    }()
    
    let imgView:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true;
        view.image = UIImage(data: Data.init(base64Encoded: SingletonStruct.allTreks[SingletonStruct.selectedTrek].imgData, options: .init(rawValue: 0))!)
        view.alpha = 1
        return view
    }()
     
    let whiteSpaceView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 35
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = SingletonStruct.testWhite
        return view
    }()
      
    let trekInformation:UILabel = {
        var label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = SingletonStruct.testWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let trekCountdown:UILabel = {
        var label = UILabel()
        label.textColor = SingletonStruct.testWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let timerValue:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailsBackdrop: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let trekDetails:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = NSAttributedString(string: "Trek Details", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv3])
        return label
    }()
    
    let timeLeftLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray.withAlphaComponent(0.5)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:"clock")
        // Set bound to reposition
        imageAttachment.bounds = CGRect(x: 0, y: -2.75, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: " 365 days", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])
        completeText.append(textAfterIcon)
        label.textAlignment = .center
        label.attributedText = completeText
        return label
    }()
    
    let depDateLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray.withAlphaComponent(0.5)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:"calender-1")
        // Set bound to reposition
        imageAttachment.bounds = CGRect(x: 0, y: -2.75, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: " Mar 13", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])
        completeText.append(textAfterIcon)
        label.textAlignment = .center
        label.attributedText = completeText
        return label
    }()

    let distanceLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray.withAlphaComponent(0.5)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:"map-1")
        // Set bound to reposition
        imageAttachment.bounds = CGRect(x: 0, y: -2.75, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: " 10000 km", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])
        completeText.append(textAfterIcon)
        label.textAlignment = .center
        label.attributedText = completeText
        return label
    }()
    
    let tagOneLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray.withAlphaComponent(0.5)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "\(SingletonStruct.allTreks[SingletonStruct.selectedTrek].tags[0])", attributes: [NSAttributedString.Key.font: SingletonStruct.bigFont])
        return label
    }()
    
    let tagTwoLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray.withAlphaComponent(0.5)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "\(SingletonStruct.allTreks[SingletonStruct.selectedTrek].tags[1])", attributes: [NSAttributedString.Key.font: SingletonStruct.bigFont])
        return label
    }()
    
    let tagThreeLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray.withAlphaComponent(0.5)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textAlignment = .center
        label.attributedText = NSAttributedString(string: "\(SingletonStruct.allTreks[SingletonStruct.selectedTrek].tags[2])", attributes: [NSAttributedString.Key.font: SingletonStruct.bigFont])
        return label
    }()
    
    let tipButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.layer.borderWidth = 0
        button.contentHorizontalAlignment = .left
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(ViewTrekViewController.showTips), for: .touchDown)
        button.setAttributedTitle(NSAttributedString(string: "Trek Tips", attributes: [NSAttributedString.Key.font: SingletonStruct.trekTipsFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testWhite]), for: .normal)
        return button
    }()
    
    let distanceButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 0
        button.setImage(UIImage(named: "no_location"), for: .normal)
        button.addTarget(self, action: #selector(ViewTrekViewController.showLocationError), for: .touchDown)
        button.isUserInteractionEnabled = false
        button.isHidden = true
        return button
    }()
    
    let tipIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.image = UIImage(named: "info")
        return view
    }()
    
    let tipBackdrop: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = UIColor.clear.cgColor
        view.backgroundColor = SingletonStruct.testBlue.withAlphaComponent(0.75)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let tagStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .leading
        sv.distribution = .equalSpacing
        return sv
    }()

    let nameDestStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .leading
        sv.distribution = .equalSpacing
        return sv
    }()
    
    let infoStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .leading
        sv.distribution = .equalSpacing
        return sv
    }()
    
    let detailStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .leading
        sv.distribution = .equalSpacing
        sv.spacing = 10
        return sv
    }()
    
    let pageOneStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .leading
        sv.distribution = .equalSpacing
        return sv
    }()
    
    
    //MARK: Page 2 UI
    let backpackTitle:UILabel = {
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2)
        label.adjustsFontSizeToFitWidth = true
        let labelContent = NSAttributedString(string: "My Backpack", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
        label.attributedText = labelContent
        return label
    }()
    
    let itemsImg:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "backpack")
        return imageView
    }()
    
    //MARK: showTips
    @objc func showTips(){
        self.present(TrekTips(), animated: true, completion: nil)
    }
    
    //MARK: showLocationError
    @objc func showLocationError(){
        self.present(LocationServiceDeniedViewController(), animated: true, completion: nil)
    }
}





