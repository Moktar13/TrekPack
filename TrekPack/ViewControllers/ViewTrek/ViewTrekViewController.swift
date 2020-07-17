//
//  ViewTrekViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-06.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit


class ViewTrekViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UINavigationBarDelegate, UIScrollViewDelegate {
    
    
    var trekSV = UIScrollView()
    
    let navBar = UINavigationBar()
    var firstTap = true
    
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
       
    }
    
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        pageControl.currentPage = 0
        updateControlTab()

        if #available(iOS 13.0, *) {
            statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }

        //Need this because in viewDidLoad the height of the status bar is 0.0, but here the heigh is proper so
        //we can add the proper top constraint
        navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: statusBarHeight).isActive = true
        
        getTimeLeft()
        
    }
    
    override var prefersStatusBarHidden: Bool {
      return true
    }
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        view.backgroundColor = SingletonStruct.newWhite
   
        
        if (AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty == false){
            hasDepDate = true
        }
         
        setupScrollView()
        setupScreen()
        setupNavigationBar()
        setupDelegate()
        setupScrollLayout()
    }
    
    //MARK: setupScrollView
    private func setupScrollView(){
        trekSV.translatesAutoresizingMaskIntoConstraints = false
        trekSV.contentInset = .zero
        trekSV.showsVerticalScrollIndicator = false
        trekSV.showsHorizontalScrollIndicator = false
        trekSV.clipsToBounds = true
        trekSV.contentInsetAdjustmentBehavior = .never
    }
    
    
    //MARK: Setup Navigation Bar
    private func setupNavigationBar(){
    
        navBar.isTranslucent = true
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = .clear
        navBar.shadowImage = UIImage()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.tintColor = .white
        
        view.addSubview(navBar)
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        if (statusBarHeight == 20){
//            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        }
        

        let navItem = UINavigationItem(title: "")
        
        let backItem = UIBarButtonItem(image: UIImage(named: "back-view"), style: .plain, target: self, action: #selector(ViewTrekViewController.closeTrek))

        let settingsItem = UIBarButtonItem(image: UIImage(named: "view-settings"), style: .plain, target: self, action: nil)
        
        navItem.leftBarButtonItem = backItem
        navItem.rightBarButtonItem = settingsItem
        navBar.setItems([navItem], animated: false)
    }
    
    
    //MARK: setupDelegate
    private func setupDelegate(){
        trekSV.delegate =  self
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
    }
    
    
    //MARK: updateControlTab
    func updateControlTab(){
        if (pageControl.currentPage == 0){
            
            if (trekItemsBtn.subviews.count > 1){
                if (firstTap){
                    trekItemsBtn.subviews[trekItemsBtn.subviews.count-1].removeFromSuperview()
                    
                    firstTap = false
                }else{
                    trekItemsBtn.subviews[trekItemsBtn.subviews.count-1].removeFromSuperview()
                }
            }
            
            if (trekRouteBtn.subviews.count > 1){
                if (firstTap){
                    trekRouteBtn.subviews[trekRouteBtn.subviews.count-1].removeFromSuperview()
                    firstTap = false
                }else{
                    trekRouteBtn.subviews[trekRouteBtn.subviews.count-1].removeFromSuperview()
                }
            }
            
        
            trekInfoBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
            
            trekInfoBtn.setAttributedTitle(NSAttributedString(string: "Information", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
            
            

            trekItemsBtn.setAttributedTitle(NSAttributedString(string: "Backpack", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)
            
            trekRouteBtn.setAttributedTitle(NSAttributedString(string: "Route", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)
            
            
        }
        else if (pageControl.currentPage == 1){
            if (trekInfoBtn.subviews.count > 1){
                if (firstTap){

                    trekInfoBtn.subviews[trekInfoBtn.subviews.count-1].removeFromSuperview()
                    firstTap = false
                }else{
                    trekInfoBtn.subviews[trekInfoBtn.subviews.count-1].removeFromSuperview()
                }
            }
                
            if (trekRouteBtn.subviews.count > 1){
                if (firstTap){
                    trekRouteBtn.subviews[trekRouteBtn.subviews.count-1].removeFromSuperview()
                    firstTap = false
                }else{
                    trekRouteBtn.subviews[trekRouteBtn.subviews.count-1].removeFromSuperview()
                }
            }
                
            
            trekItemsBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
                
            
            
            
            trekInfoBtn.setAttributedTitle(NSAttributedString(string: "Information", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)
            
            
            
            trekItemsBtn.setAttributedTitle(NSAttributedString(string: "Backpack", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
            
            trekRouteBtn.setAttributedTitle(NSAttributedString(string: "Route", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)
            
        }
        else if (pageControl.currentPage == 2){
            
            if (trekInfoBtn.subviews.count > 1){
                if (firstTap){
                    trekInfoBtn.subviews[trekInfoBtn.subviews.count-1].removeFromSuperview()
                    firstTap = false
                }else{
                    trekInfoBtn.subviews[trekInfoBtn.subviews.count-1].removeFromSuperview()
                }
            }
                
    
            if (trekItemsBtn.subviews.count > 1){
                if (firstTap){
                    trekItemsBtn.subviews[trekItemsBtn.subviews.count-1].removeFromSuperview()
                    firstTap = false
                }else{
                    trekItemsBtn.subviews[trekItemsBtn.subviews.count-1].removeFromSuperview()
                }
            }
                
            
            trekRouteBtn.addLine(position: .LINE_POSITION_BOTTOM, color: SingletonStruct.testBlue, width: 2.5)
            
            trekInfoBtn.setAttributedTitle(NSAttributedString(string: "Information", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)
            
            trekItemsBtn.setAttributedTitle(NSAttributedString(string: "Backpack", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)
            
            
            
            trekRouteBtn.setAttributedTitle(NSAttributedString(string: "Route", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue]), for: .normal)
        }
        
        
        trekSV.scrollTo(horizontalPage: pageControl.currentPage, verticalPage: 0, animated: false)
    }
    
    ///TODO: Can simplify this by making it only 1 function with a global variable that is checked
    @objc func goToInformation(){
        if (pageControl.currentPage != 0){
            pageControl.currentPage = 0
            updateControlTab()
        }
    }
    
    @objc func goToBackpack(){
        if (pageControl.currentPage != 1){
            pageControl.currentPage = 1
            updateControlTab()
        }
    }
    
    @objc func goToRoute(){
        if (pageControl.currentPage != 2){
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
            
            if (i == 0){
                //first page

                let viewOne: UIView = UIView(frame: frame)
                
                viewOne.clipsToBounds = true
                viewOne.backgroundColor = .clear
                viewOne.layer.borderColor = UIColor.clear.cgColor
                viewOne.layer.borderWidth = 1
                viewOne.backgroundColor = SingletonStruct.testWhite
                
                trekSV.addSubview(viewOne)
                
                viewOne.addSubview(trekNameLabel)
                trekNameLabel.leadingAnchor.constraint(equalTo: whiteSpaceView.leadingAnchor, constant: view.frame.width/14).isActive = true
                trekNameLabel.trailingAnchor.constraint(equalTo: whiteSpaceView.trailingAnchor, constant: -view.frame.width/16).isActive = true
                trekNameLabel.topAnchor.constraint(equalTo: trekInfoBtn.bottomAnchor, constant: view.frame.width/14).isActive = true
                
                viewOne.addSubview(destinationIcon)
                destinationIcon.leadingAnchor.constraint(equalTo: trekNameLabel.leadingAnchor).isActive = true

                
                viewOne.addSubview(trekDestLabel)
                trekDestLabel.leadingAnchor.constraint(equalTo: destinationIcon.trailingAnchor).isActive = true
                trekDestLabel.trailingAnchor.constraint(equalTo: whiteSpaceView.trailingAnchor, constant: -view.frame.width/16).isActive = true
                trekDestLabel.topAnchor.constraint(equalTo: trekNameLabel.bottomAnchor, constant: 5).isActive = true
                
                destinationIcon.centerYAnchor.constraint(equalTo: trekDestLabel.centerYAnchor).isActive = true
                destinationIcon.widthAnchor.constraint(equalTo: trekDestLabel.heightAnchor, constant: -5).isActive = true
                
                
                viewOne.addSubview(detailsBackdrop)
                detailsBackdrop.topAnchor.constraint(equalTo: trekDestLabel.bottomAnchor, constant: 25).isActive = true
                detailsBackdrop.leadingAnchor.constraint(equalTo: trekNameLabel.leadingAnchor).isActive = true
                detailsBackdrop.trailingAnchor.constraint(equalTo: trekNameLabel.trailingAnchor).isActive = true
                detailsBackdrop.heightAnchor.constraint(equalToConstant: viewOne.frame.height/3.6).isActive = true
                
                
                stackView.addArrangedSubview(timeLeftLabel)
                stackView.addArrangedSubview(depDateLabel)
                stackView.addArrangedSubview(distanceLabel)
                
                
                
                viewOne.addSubview(trekDetails)
                trekDetails.topAnchor.constraint(equalTo: detailsBackdrop.topAnchor, constant: 25).isActive = true
                trekDetails.leadingAnchor.constraint(equalTo: detailsBackdrop.leadingAnchor, constant: 15).isActive = true
                trekDetails.trailingAnchor.constraint(equalTo: detailsBackdrop.trailingAnchor, constant: -15).isActive = true
                
                
                viewOne.addSubview(stackView)
                stackView.leadingAnchor.constraint(equalTo: trekDetails.leadingAnchor).isActive = true
                stackView.trailingAnchor.constraint(equalTo: trekDetails.trailingAnchor).isActive = true
                stackView.topAnchor.constraint(equalTo: trekDetails.bottomAnchor, constant: 10).isActive = true

            }
            else if (i == 1){
                //second page
                
                let viewTwo: UIView = UIView(frame: frame)
                
                viewTwo.clipsToBounds = true
                
                viewTwo.layer.borderColor = UIColor.clear.cgColor
                viewTwo.layer.borderWidth = 1
                viewTwo.backgroundColor = SingletonStruct.testWhite
                
                trekSV.addSubview(viewTwo)
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
    
    
    //MARK: setupUIComponents
    func setupUIComponents(){
    
        
        //If there is no destination and no departure date (including return date)
        if (AllTreks.treksArray[AllTreks.selectedTrek].destination.isEmpty && (AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty)){
            
            
            heightID = 1
        
            //Showing the trek name
            trekInformation.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
            
         
         //If there is a destination but not dates
         }else if (AllTreks.treksArray[AllTreks.selectedTrek].destination.isEmpty == false && (AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty)){
            
            heightID = 2
            
            //Adding Trek name
            trekInformation.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +

            //Adding Trek destination
            NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
        
    
         //If there is both dep and dest present
         }else if (AllTreks.treksArray[AllTreks.selectedTrek].destination.isEmpty == false && AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty == false) {
             
            heightID = 3
             
            //If there is no return
            if (AllTreks.treksArray[AllTreks.selectedTrek].returnDate.isEmpty){
                 
                //Adding Trek name
                trekInformation.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +
                     
                //Adding Trek destination
                NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader]) +

                //Adding the departure/return dates
                NSAttributedString(string: "\n\(AllTreks.treksArray[AllTreks.selectedTrek].departureDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
             }
                 
             //Else if there is a return
             else{
                
                
                
                //Adding Trek name
                trekInformation.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +
                     
                //Adding Trek destination
                NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader]) +

                //Adding the departure/return dates
                NSAttributedString(string: "\n\(AllTreks.treksArray[AllTreks.selectedTrek].departureDate) - \(AllTreks.treksArray[AllTreks.selectedTrek].returnDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
             }
             
             
         //If there is dep but no dest
         }else if (AllTreks.treksArray[AllTreks.selectedTrek].destination.isEmpty && AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty == false){
            
            
             
            //If there is no return
            if (AllTreks.treksArray[AllTreks.selectedTrek].returnDate.isEmpty){
                
                //Adding Trek name
                trekInformation.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +

                //Adding the departure date
                NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].departureDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
             }
                 
             //Else if there is a return
             else{
                
                //Adding Trek name
                trekInformation.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +

                //Adding the departure/return dates
                NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].departureDate) - \(AllTreks.treksArray[AllTreks.selectedTrek].returnDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
             }
         }
    }
    
    
    //MARK: closeTrek
    @objc func closeTrek(){
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: openSettings
    @objc func openSettings(){
        ///TODO: BOTTOM POP UP WITH (EDIT TREK, SHARE TREK, DELETE TREK)
        
        //testing
        AllTreks.treksArray.remove(at: AllTreks.selectedTrek)
        dismiss(animated: true, completion: nil)
    }
    
    

    //MARK: getTimeLefts
    func getTimeLeft(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let depDate = formatter.date(from: AllTreks.treksArray[AllTreks.selectedTrek].departureDate)!
        
        //Getting todays date
        let currentDateTime = Date()

        let diffFormatter = DateComponentsFormatter()
        diffFormatter.allowedUnits = [.day]

        var dayDiff = (diffFormatter.string(from: currentDateTime, to: depDate)!)
        
        dayDiff = dayDiff.trimmingCharacters(in: .letters).trimmingCharacters(in: .whitespaces)
        
        dayDiff = dayDiff.replacingOccurrences(of: ",", with: "")
    
        let dayCountdown = Int(dayDiff)
    
      
        // Add your text to mutable string
        var textAfterIcon = NSAttributedString(string: " 0 days", attributes: [NSAttributedString.Key.font: SingletonStruct.trekDetailsFont])
        
        
        if (dayCountdown == 1){
            textAfterIcon = NSAttributedString(string: " \(dayCountdown!) day", attributes: [ NSAttributedString.Key.font: SingletonStruct.trekDetailsFont])
        }else{
            textAfterIcon = NSAttributedString(string: " \(dayCountdown!) days", attributes: [NSAttributedString.Key.font: SingletonStruct.trekDetailsFont])
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
        button.setAttributedTitle(NSAttributedString(string: "Information", attributes: [NSAttributedString.Key.font: SingletonStruct.buttonFontTwo, NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .normal)
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
        let labelContent = NSAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].name, attributes: [NSAttributedString.Key.font: SingletonStruct.infoTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.newBlack])
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
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = NSAttributedString(string: " \(AllTreks.treksArray[AllTreks.selectedTrek].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.infoDestFont, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
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
        view.layer.borderColor = UIColor.black.cgColor
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
        label.attributedText = NSAttributedString(string: "Trek Details", attributes: [NSAttributedString.Key.font: SingletonStruct.subHeaderFontv2])
        return label
    }()
    
  
    
    let timeLeftLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray.withAlphaComponent(0.5)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
       
        
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
        let textAfterIcon = NSAttributedString(string: " 365 days", attributes: [NSAttributedString.Key.font: SingletonStruct.trekDetailsFont])
        
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
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true

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
        let textAfterIcon = NSAttributedString(string: " Mar 13", attributes: [NSAttributedString.Key.font: SingletonStruct.trekDetailsFont])
        
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
        let textAfterIcon = NSAttributedString(string: " 10000 km", attributes: [NSAttributedString.Key.font: SingletonStruct.trekDetailsFont])
        
        completeText.append(textAfterIcon)
        label.textAlignment = .center
        label.attributedText = completeText
        

        return label
    }()
    
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .leading
        sv.distribution = .equalSpacing
       
        return sv
    }()
}



