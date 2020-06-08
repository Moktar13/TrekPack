//
//  ViewTrekViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-06.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit


class ViewTrekViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    let cellReuseID = "cell"
    
    var itemsTableView = UITableView()
    
    var heightID = 0
    var hasDepDate:Bool = false
    var timer:Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
        view.backgroundColor = SingletonStruct.newWhite
        
        print(AllTreks.treksArray[AllTreks.selectedTrek].imageName)
        
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(getTimeLeft), userInfo: nil, repeats: true)
        
        
        
        if (AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty == false){
            hasDepDate = true
        }
    
        setupUIComponents()
        setupNavBar()
        setupTableView()
        setupScreen()
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
   
    
    //VIEW BACKGROUND
    let imgView:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true;
        view.image = AllTreks.treksArray[AllTreks.selectedTrek].image
        view.alpha = 0.75
        return view
    }()
     
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
