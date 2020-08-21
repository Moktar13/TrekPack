//
//  ViewTrekViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-06.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit
import CoreLocation

class ViewTrekViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UINavigationBarDelegate, UIScrollViewDelegate {
    
    var currentLocation: CLLocation!
    var locManager = CLLocationManager()
    
    var trekSV = UIScrollView()
    
    let navBar = UINavigationBar()
    var firstTap = true
    var pageFrom = 0
    
    let cellReuseID = "cell"
    
    var itemsTableView = UITableView()
    
    var heightID = 0
    var hasDepDate:Bool = false
    var timer:Timer!
    
    var statusBarHeight: CGFloat = 0
    
    deinit {
        print("OS reclaiming ViewTrek memory")
    }
    
    //MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
//        print("Items: \(AllTreks.treksArray[AllTreks.selectedTrek].items)\nCrosses: \(AllTreks.treksArray[AllTreks.selectedTrek].crosses)")
        
        print("viewDidAppear")
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       
    
    }
    
    //MARK: viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        
        print("viewWillDisappear")
        
        let defaults = UserDefaults.standard
        
        defaults.set(try? PropertyListEncoder().encode(AllTreks.treksArray), forKey: "saved")
    }
    
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        print("viewWillAppear")
        
        pageControl.currentPage = pageControl.currentPage


        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let settingsItem = UIBarButtonItem(image: UIImage(named: "view-settings"), style: .plain, target: self, action: #selector(ViewTrekViewController.openSettings))
        
        
        self.navigationItem.rightBarButtonItem = settingsItem
//        navigationController?.navigationItem.rightBarButtonItem = settingsItem

        SingletonStruct.statusBarHeight = Double(statusBarHeight)
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
        //If the user edits their trek and deletes/add items, the trek must be reassesed when this viewcontroller load so that it may update the approprite UI
        trekNameLabel.attributedText = NSAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].name, attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
        
        
        //setting destination
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named:"map-pin")
        imageAttachment.bounds = CGRect(x: 0, y: -2.75, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: " \(AllTreks.treksArray[AllTreks.selectedTrek].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        completeText.append(textAfterIcon)
        trekDestLabel.adjustsFontSizeToFitWidth = true
        trekDestLabel.attributedText = completeText
        
        //setting the tags
        tagOneLabel.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].tags[0])", attributes: [NSAttributedString.Key.font: SingletonStruct.bigFont])
        tagTwoLabel.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].tags[1])", attributes: [NSAttributedString.Key.font: SingletonStruct.bigFont])
        tagThreeLabel.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].tags[2])", attributes: [NSAttributedString.Key.font: SingletonStruct.bigFont])
        
        //setting image
        imgView.image = UIImage(data: Data.init(base64Encoded: AllTreks.treksArray[AllTreks.selectedTrek].imgData, options: .init(rawValue: 0))!)
        
        //setting departure date and time left
        getDepartureDate()
        getTimeLeft()
        
        print("Items: \(AllTreks.treksArray[AllTreks.selectedTrek].items.count)")
        
        if (AllTreks.treksArray[AllTreks.selectedTrek].items.count != 0){
            itemsImg.isHidden = true
        }else{
            itemsImg.isHidden = false
        }
        
        itemsTableView.reloadData()
        
        //TODO: Renable this
//        getDistance()

        
        //Adding indication line under the trekInfoBtn, required for viewDidLoad
        if (trekInfoBtn.subviews.count == 0){
            trekInfoBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
        }
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
   
        
        if (AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty == false){
            hasDepDate = true
        }
        
        
        //locManager.requestWhenInUseAuthorization()
        
        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager.location
        }
         
        setupScrollView()
        setupScreen()
        setupDelegate()
        setupScrollLayout()
        getTimeLeft()
        getDepartureDate()
        ///TODO: RE-ENABLE THIS  -- ONLY OFF FOR TESTING ON EMU
//        getDistance()
        
        
        
        
        
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
    }
    
    
    //MARK: updateControlTab
    func updateControlTab(){
        
        if (pageFrom == 0){
            
            if (firstTap){
                trekInfoBtn.subviews[0].removeFromSuperview()
                firstTap = false
            }else{
                trekInfoBtn.subviews[trekInfoBtn.subviews.count-1].removeFromSuperview()
            }
                    
            
            if (pageControl.currentPage == 1){
                
                trekItemsBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
                
                trekInfoBtn.setAttributedTitle(NSAttributedString(string: "Information", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)

                trekItemsBtn.setAttributedTitle(NSAttributedString(string: "Backpack", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)

                
            }else if (pageControl.currentPage == 2){
                
                trekRouteBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
                
                trekInfoBtn.setAttributedTitle(NSAttributedString(string: "Information", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)

                trekRouteBtn.setAttributedTitle(NSAttributedString(string: "Route", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
            }
            
        }else if (pageFrom == 1){
            
            trekItemsBtn.subviews[trekItemsBtn.subviews.count-1].removeFromSuperview()
            
            if (pageControl.currentPage == 0){
                
                trekInfoBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
                
                trekItemsBtn.setAttributedTitle(NSAttributedString(string: "Backpack", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)

                trekInfoBtn.setAttributedTitle(NSAttributedString(string: "Information", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
                
            }else if (pageControl.currentPage == 2){
                
                trekRouteBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
                
                trekItemsBtn.setAttributedTitle(NSAttributedString(string: "Backpack", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)

                trekRouteBtn.setAttributedTitle(NSAttributedString(string: "Route", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
                
            }
            
        }else if (pageFrom == 2){
            
            trekRouteBtn.subviews[trekRouteBtn.subviews.count-1].removeFromSuperview()
            
            if (pageControl.currentPage == 0){
                
                trekInfoBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
                
                trekRouteBtn.setAttributedTitle(NSAttributedString(string: "Route", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)

                trekInfoBtn.setAttributedTitle(NSAttributedString(string: "Information", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
                
            }else if (pageControl.currentPage == 1){
                
                trekItemsBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
                
                trekRouteBtn.setAttributedTitle(NSAttributedString(string: "Route", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)

                trekItemsBtn.setAttributedTitle(NSAttributedString(string: "Backpack", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
                
            }
            
        }
    
        trekSV.scrollTo(horizontalPage: pageControl.currentPage, verticalPage: 0, animated: false)
    }
    
    ///TODO: Can simplify this by making it only 1 function with a global variable that is checked
    @objc func goToInformation(){
        if (pageControl.currentPage != 0){
            pageFrom = pageControl.currentPage
            pageControl.currentPage = 0
            updateControlTab()
        }
    }
    
    @objc func goToBackpack(){
        if (pageControl.currentPage != 1){
            pageFrom = pageControl.currentPage
            pageControl.currentPage = 1
            updateControlTab()
        }
    }
    
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
                let viewOne: UIView = UIView(frame: frame)
                
                viewOne.clipsToBounds = true
                viewOne.backgroundColor = .clear
                viewOne.layer.borderColor = UIColor.clear.cgColor
                viewOne.layer.borderWidth = 1
                viewOne.backgroundColor = SingletonStruct.testWhite
                
                trekSV.addSubview(viewOne)
                
                nameDestStack.addArrangedSubview(trekNameLabel)
                nameDestStack.addArrangedSubview(trekDestLabel)
    
                infoStack.addArrangedSubview(timeLeftLabel)
                infoStack.addArrangedSubview(depDateLabel)
                infoStack.addArrangedSubview(distanceLabel)
                
                detailStack.addArrangedSubview(trekDetails)
                detailStack.addArrangedSubview(infoStack)
                
                tagStack.addArrangedSubview(tagOneLabel)
                tagStack.addArrangedSubview(tagTwoLabel)
                tagStack.addArrangedSubview(tagThreeLabel)
                
                
                pageOneStack.addArrangedSubview(nameDestStack)
                pageOneStack.addArrangedSubview(detailStack)
                pageOneStack.addArrangedSubview(tagStack)
                
                viewOne.addSubview(pageOneStack)
                
                pageOneStack.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: view.frame.width/12).isActive = true
                
                pageOneStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.width/12).isActive = true
                
                pageOneStack.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor).isActive = true
                
                pageOneStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
                
                
                
                infoStack.trailingAnchor.constraint(equalTo: pageOneStack.trailingAnchor).isActive = true
                
                tagStack.trailingAnchor.constraint(equalTo: trekItemsBtn.trailingAnchor).isActive = true
                
                detailStack.centerXAnchor.constraint(equalTo: pageOneStack.centerXAnchor).isActive = true
                
                viewOne.addSubview(detailsBackdrop)
                detailsBackdrop.centerYAnchor.constraint(equalTo: detailStack.centerYAnchor).isActive = true
                detailsBackdrop.centerXAnchor.constraint(equalTo: detailStack.centerXAnchor).isActive = true
                detailsBackdrop.heightAnchor.constraint(equalTo: detailStack.heightAnchor, constant: view.frame.height/20).isActive = true
                detailsBackdrop.widthAnchor.constraint(equalTo: detailStack.widthAnchor, constant: 20).isActive = true
                
                
                
                viewOne.addSubview(tipBackdrop)
                tipBackdrop.widthAnchor.constraint(equalToConstant: 150).isActive = true
                tipBackdrop.centerYAnchor.constraint(equalTo: tagStack.centerYAnchor).isActive = true
                tipBackdrop.trailingAnchor.constraint(equalTo: viewOne.trailingAnchor, constant: 15).isActive = true
                tipBackdrop.heightAnchor.constraint(equalToConstant: 50).isActive = true

                viewOne.addSubview(tipButton)
                tipButton.centerYAnchor.constraint(equalTo: tipBackdrop.centerYAnchor).isActive = true
                tipButton.leadingAnchor.constraint(equalTo: tipBackdrop.leadingAnchor, constant: 7).isActive = true
                tipButton.trailingAnchor.constraint(equalTo: viewOne.trailingAnchor).isActive = true

                viewOne.addSubview(tipIcon)
                tipIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
                tipIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
                tipIcon.centerYAnchor.constraint(equalTo: tipButton.centerYAnchor).isActive = true
                tipIcon.trailingAnchor.constraint(equalTo: viewOne.trailingAnchor, constant: -15).isActive = true

                viewOne.sendSubviewToBack(tipIcon)
                viewOne.sendSubviewToBack(tipBackdrop)
                
            }
                
            //MARK: pageTwo
            else if (i == 1){
                
                
                let viewTwo: UIView = UIView(frame: frame)
                
                viewTwo.clipsToBounds = true
                
                viewTwo.layer.borderColor = UIColor.clear.cgColor
                viewTwo.layer.borderWidth = 1
                viewTwo.backgroundColor = SingletonStruct.testWhite
                
                trekSV.addSubview(viewTwo)
    
                
                
                
                
                
                viewTwo.addSubview(backpackTitle)
                backpackTitle.leadingAnchor.constraint(equalTo: whiteSpaceView.leadingAnchor, constant: view.frame.width/14).isActive = true
                backpackTitle.trailingAnchor.constraint(equalTo: whiteSpaceView.trailingAnchor, constant: -view.frame.width/14).isActive = true
                backpackTitle.topAnchor.constraint(equalTo: trekInfoBtn.bottomAnchor, constant: view.frame.width/12).isActive = true
                
                
                viewTwo.addSubview(itemsTableView)
                itemsTableView.leadingAnchor.constraint(equalTo: backpackTitle.leadingAnchor).isActive = true
                itemsTableView.trailingAnchor.constraint(equalTo: viewTwo.trailingAnchor, constant: -view.frame.width/14).isActive = true
                itemsTableView.topAnchor.constraint(equalTo: backpackTitle.bottomAnchor, constant: 10).isActive = true
                itemsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
                
                
                if (AllTreks.treksArray[AllTreks.selectedTrek].items.count == 0){
                    viewTwo.addSubview(itemsImg)
                    itemsImg.centerXAnchor.constraint(equalTo: itemsTableView.centerXAnchor).isActive = true
                    itemsImg.centerYAnchor.constraint(equalTo: itemsTableView.centerYAnchor).isActive = true
                    itemsImg.heightAnchor.constraint(equalToConstant: 100).isActive = true
                    itemsImg.widthAnchor.constraint(equalToConstant: 100).isActive = true
                }
                
                
                
            }
            else if (i == 2){
                //third page
                
                let viewThree: UIView = UIView(frame: frame)
                
                viewThree.clipsToBounds = true
                
                viewThree.layer.borderColor = UIColor.clear.cgColor
                viewThree.layer.borderWidth = 1
                viewThree.backgroundColor = SingletonStruct.testWhite
                
                trekSV.addSubview(viewThree)
            }
            
        }
        
        trekSV.contentSize = CGSize(width: trekSV.frame.size.width * 3, height: trekSV.frame.size.height)
    }
    
    //MARK: closeTrek
    @objc func closeTrek(){
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: openSettings
    @objc func openSettings(){
        ///TODO: BOTTOM POP UP WITH (EDIT TREK, SHARE TREK, DELETE TREK)
       
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editTrek = UIAlertAction(title: "Edit Trek", style: .default, handler: {
            (action) in
            
            AllTreks.makingNewTrek = false

            self.navigationController?.pushViewController(EditTrek(), animated: true)
            
        })
        let shareTrek = UIAlertAction(title: "Share Trek", style: .default, handler: .none)
        let deleteTrek = UIAlertAction(title: "Delete Trek", style: .default, handler: { (action) in
            
            AllTreks.treksArray.remove(at: AllTreks.selectedTrek)
            self.navigationController?.popViewController(animated: true)
        })
        let cancelMenu = UIAlertAction(title: "Cancel", style: .cancel, handler: .none)
        
        cancelMenu.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(editTrek)
        alert.addAction(shareTrek)
        alert.addAction(deleteTrek)
        alert.addAction(cancelMenu)
        
        self.present(alert, animated: true)
        
        
    }
    
    
    
    
    //MARK: getDepartureDate
    func getDepartureDate(){
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        formatter.dateFormat = "dd/MM/yyyy"
        let depDate = formatter.date(from: AllTreks.treksArray[AllTreks.selectedTrek].departureDate)!
        
        formatter.dateFormat = "dd"
        let day = formatter.string(from: depDate)
        
        formatter.dateFormat = "MMM"
        let month = formatter.string(from: depDate)
        
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
        
        let depDate = formatter.date(from: AllTreks.treksArray[AllTreks.selectedTrek].departureDate)!
        
//        print("Departure Date: \(formatter.string(from: depDate))")
        
        //Getting todays date
        let currentDateTime = Date()

        let diffFormatter = DateComponentsFormatter()
        diffFormatter.allowedUnits = [.day]

        var dayDiff = (diffFormatter.string(from: currentDateTime, to: depDate)!)
        
        dayDiff = dayDiff.trimmingCharacters(in: .letters).trimmingCharacters(in: .whitespaces)
        
        dayDiff = dayDiff.replacingOccurrences(of: ",", with: "")
    
        let dayCountdown = Int(dayDiff)
    
      
        // Add your text to mutable string
        var textAfterIcon = NSAttributedString(string: " 0 days", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])
        
        
        if (dayCountdown == 1){
            textAfterIcon = NSAttributedString(string: " \(dayCountdown!) day", attributes: [ NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])
        }else{
            textAfterIcon = NSAttributedString(string: " \(dayCountdown!) days", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv4])
        }
        
        
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
        
        
        completeText.append(textAfterIcon)
        timeLeftLabel.textAlignment = .center
        timeLeftLabel.attributedText = completeText
        
    }
    
    
    //MARK: getDistance
    func getDistance(){
        var distanceUnit = "m"
        var distance = 0.0
        
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
            

            
        
            let destinationLocation = CLLocation(latitude: AllTreks.treksArray[AllTreks.selectedTrek].latitude, longitude: AllTreks.treksArray[AllTreks.selectedTrek].longitude)

            
//            print("Longitude: \(currentLocation.coordinate.longitude)\nLatitude: \(currentLocation.coordinate.latitude)")
            
            
            distance = currentLocation.distance(from: destinationLocation)
                
//            print("Distance: \(distance)")
       
            if (distance > 999){
                distance = distance/1000
                distanceUnit = "km"
                distance = ceil(distance)
            }
        }else{
            distance = 0.0
        }
        
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
        let textAfterIcon = NSAttributedString(string: " \(Int(distance)) \(distanceUnit)", attributes: [NSAttributedString.Key.font: SingletonStruct.trekDetailsFont])
        
        completeText.append(textAfterIcon)
        distanceLabel.textAlignment = .center
        distanceLabel.attributedText = completeText
        
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
        button.setAttributedTitle(NSAttributedString(string: "Information", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
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
        button.setAttributedTitle(NSAttributedString(string: "Backpack", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(ViewTrekViewController.goToBackpack), for: .touchDown)
        return button
    }()
    let trekRouteBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Route", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)
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
        let labelContent = NSAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].name, attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
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
        let textAfterIcon = NSAttributedString(string: " \(AllTreks.treksArray[AllTreks.selectedTrek].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
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
        view.image = UIImage(data: Data.init(base64Encoded: AllTreks.treksArray[AllTreks.selectedTrek].imgData, options: .init(rawValue: 0))!)
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
//        view.layer.borderColor = UIColor.black.cgColor
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
//        label.minimumScaleFactor = 0.5
//        label.adjustsFontSizeToFitWidth = true
       
        
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
//        label.minimumScaleFactor = 0.5
//        label.adjustsFontSizeToFitWidth = true

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
        label.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].tags[0])", attributes: [NSAttributedString.Key.font: SingletonStruct.bigFont])
    
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
        label.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].tags[1])", attributes: [NSAttributedString.Key.font: SingletonStruct.bigFont])
        

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
        label.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].tags[2])", attributes: [NSAttributedString.Key.font: SingletonStruct.bigFont])
        

        return label
    }()
    
    
    
    
    let tipButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.backgroundColor = .clear
        button.layer.borderWidth = 0
        button.contentHorizontalAlignment = .left
//        button.contentVerticalAlignment = .center
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(ViewTrekViewController.showTips), for: .touchDown)
        button.setAttributedTitle(NSAttributedString(string: "Trek Tips", attributes: [NSAttributedString.Key.font: SingletonStruct.trekTipsFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testWhite]), for: .normal)
        
        
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
//        print("showTips")
        self.present(TrekTips(), animated: true, completion: nil)
    }
}





