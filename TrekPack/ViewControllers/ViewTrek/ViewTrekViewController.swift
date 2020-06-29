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
    
    
    var firstTap = true
    
    let cellReuseID = "cell"
    
    var itemsTableView = UITableView()
    
    var heightID = 0
    var hasDepDate:Bool = false
    var timer:Timer!
    
    
    deinit {
        print("OS reclaiming ViewTrek memory")
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pageControl.currentPage = 0
        updateControlTab()
    }
    
    override var prefersStatusBarHidden: Bool {
      return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
        view.backgroundColor = SingletonStruct.newWhite
        
//        print(AllTreks.treksArray[AllTreks.selectedTrek].imageName)
        
       self.trekSV.contentInsetAdjustmentBehavior = .never
     
        
        if (AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty == false){
            hasDepDate = true
        }
         
        ///todo: put this somewhere
        trekSV.translatesAutoresizingMaskIntoConstraints = false
        trekSV.contentInset = .zero
        trekSV.showsVerticalScrollIndicator = false
        trekSV.showsHorizontalScrollIndicator = false
        trekSV.clipsToBounds = true
    
//        setupUIComponents()
//        setupNavBar()
//        setupTableView()
        setupScreen()
        setupNavigationBar()
        delegateSetup()
        setupScrollLayout()
    }
    
    
    
    private func setupNavigationBar(){
      

        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = .clear
        navBar.tintColor = .white
        navBar.setBackgroundImage(UIImage(named:"transparent"), for: .default)
        navBar.shadowImage = UIImage()
        
        view.addSubview(navBar)
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let navItem = UINavigationItem(title: "")
        
        
        let backItem = UIBarButtonItem(image: UIImage(named: "back-view"), style: .plain, target: self, action: #selector(ViewTrekViewController.closeTrek))
        
        let settingsItem = UIBarButtonItem(image: UIImage(named: "view-settings"), style: .plain, target: self, action: #selector(ViewTrekViewController.openSettings))
    
    
        navItem.leftBarButtonItem = backItem
        navItem.rightBarButtonItem = settingsItem
        navBar.setItems([navItem], animated: false)
    }
    
    private func delegateSetup(){
        trekSV.delegate =  self
    }
    
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
                destinationIcon.heightAnchor.constraint(equalTo: trekDestLabel.heightAnchor, constant: -5).isActive = true
                destinationIcon.widthAnchor.constraint(equalTo: trekDestLabel.heightAnchor, constant: -5).isActive = true
                
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
    
    func setupTableView(){
        itemsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseID)
        itemsTableView.tableFooterView = UIView()
        itemsTableView.translatesAutoresizingMaskIntoConstraints = false
        itemsTableView.separatorColor = SingletonStruct.testBlack
        itemsTableView.separatorInset = .zero
        itemsTableView.layoutMargins = .zero
        itemsTableView.preservesSuperviewLayoutMargins = false
        itemsTableView.layer.borderColor = SingletonStruct.testBlack.cgColor
        itemsTableView.layer.cornerRadius = 10
        itemsTableView.layer.borderWidth = 0
        itemsTableView.contentInsetAdjustmentBehavior = .never
        itemsTableView.backgroundColor = SingletonStruct.testGray.withAlphaComponent(0.80)
    }
        
    //NAV BAR FUNCTIONS
    @objc func closeTrek(){
        dismiss(animated: true, completion: nil)
    }
    @objc func openSettings(){
        ///TODO: BOTTOM POP UP WITH (EDIT TREK, SHARE TREK, DELETE TREK)
        
        //testing
        AllTreks.treksArray.remove(at: AllTreks.selectedTrek)
        dismiss(animated: true, completion: nil)
    }
    
    

    //PAGE CONTROL + NAV BUTTONS
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
    
    //INFORMATION UI
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
   
    
    //VIEW BACKGROUND
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
     
    
    ///MIGHT NOT NEED THIS STUFF BELOW-------------------
    //TREK INFORMATION LABEL
    let trekInformation:UILabel = {
        var label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = SingletonStruct.testWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let backdropOne:UIView = {
        let view = UIView()
        view.backgroundColor = SingletonStruct.testBlue.withAlphaComponent(0.7)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //TREK COUNTDOWN LABEL
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
    let backdropTwo:UIView = {
        var view = UIView()
        view.backgroundColor = SingletonStruct.testBlue.withAlphaComponent(0.7)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    
    
    //TREK ITEM LABEL
    let trekItem:UILabel = {
        var label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "My Items", attributes: [NSAttributedString.Key.foregroundColor: SingletonStruct.testWhite, NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
        
        return label
    }()

    //TABLE VIEW
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTreks.treksArray[AllTreks.selectedTrek].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
               
        cell.textLabel?.attributedText = NSAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].items[indexPath.row], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])

        cell.backgroundColor = .clear
       
        cell.textLabel?.font = SingletonStruct.inputItemFont
    
        cell.selectionStyle = .none
        
        
        return cell
               
    }
    
    let backdropThree:UIView = {
        var view = UIView()
        view.backgroundColor = SingletonStruct.testBlue.withAlphaComponent(0.7)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
   
    
     ///TODO: Add feature where if the trek has a retun date, after the departure dates show "Days Until Return" label
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
        
    
        if (dayCountdown! == 0){
            trekCountdown.attributedText = NSAttributedString(string: "Departure in next 24 hours!", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])

        }else if (dayCountdown! < 0){
            ///Todo: Some message
        }else{
            
            if (dayCountdown == 1){
                trekCountdown.attributedText = NSAttributedString(string: "Departure in: \(dayCountdown!) day", attributes: [ NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
            }else{
                trekCountdown.attributedText = NSAttributedString(string: "Departure in: \(dayCountdown!) days", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
            }
            
            
        }
        ///TODO: If hourDiff == 0 then send notification that the depdate is today
//        print("CURR DATE: \(currDate)")
//        print("DEP DATE: \(depComp)")
    }
    
    
    
    
    
    
    
    
}



