//
//  ViewTrekViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-06.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit


class ViewTrekViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        
    
        view.viewAddBackground(imgName: "sm")
        
        
        setupNavBar()
        setupScreen()
    }
    
    
    
    
    func setupScreen(){
        
        view.addSubview(imgView)
        imgView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imgView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //TREK INFO
        view.addSubview(test)
        test.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
        test.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
        test.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
        
        
//        if (trekDestLabel.text?.isEmpty == false && trekDepLabel.text?.isEmpty == false && trekRetLabel.){
//            view.addSubview(trekNameLabel)
//            trekNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/18).isActive = true
//            trekNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/18).isActive = true
//            trekNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
//        }
        

     
        
    }
    
    
    let imgView:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 0
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true;
        view.image = AllTreks.treksArray[AllTreks.selectedTrek].image


        return view
    }()
    
    let test:UILabel = {
        
        var label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //If there is no destination and no departure date (including return date
        if (AllTreks.treksArray[AllTreks.selectedTrek].destination.isEmpty && (AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty)){
             
             
             

             //Showing the trek name
             label.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader, NSAttributedString.Key.foregroundColor: SingletonStruct.titleColor])

         
         //If there is a destination but not departure date
         }else if (AllTreks.treksArray[AllTreks.selectedTrek].destination.isEmpty == false && (AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty)){
             
             //Adding Trek name
             label.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +

             //Adding Trek destination
             NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
        
             
         //If there is both dep and dest present
         }else if (AllTreks.treksArray[AllTreks.selectedTrek].destination.isEmpty == false && AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty == false) {
             
             
             //If there is no return
             if (AllTreks.treksArray[AllTreks.selectedTrek].returnDate.isEmpty){
                 
                 //Adding Trek name
                 label.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +
                     
                 //Adding Trek destination
                 NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].destination)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader]) +

                 //Adding the departure/return dates
                 NSAttributedString(string: "\n\(AllTreks.treksArray[AllTreks.selectedTrek].departureDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
             }
                 
             //Else if there is a return
             else{
                 //Adding Trek name
                 label.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +
                     
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
                 label.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +

                 //Adding the departure date
                 NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].departureDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
             }
                 
             //Else if there is a return
             else{
                 
                 
                 //Adding Trek name
                label.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)\n", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader]) +

                 //Adding the departure/return dates
                    NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].departureDate) - \(AllTreks.treksArray[AllTreks.selectedTrek].returnDate)", attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
             }
         }
        
        return label
    }()
    
    
    let trekNameLabel:UILabel = {
    
    let label = UILabel()
        
    label.textColor = SingletonStruct.titleColor
    label.backgroundColor = .clear
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .left
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
        
    let labelContent = NSAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].name, attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneHeader])
        
    label.attributedText = labelContent
    return label
    }()
    let trekDestLabel:UILabel = {

        let label = UILabel()
        
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        let labelContent = NSAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].destination, attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
        
        label.attributedText = labelContent
        return label
    }()
    let trekDepLabel:UILabel = {
       let label = UILabel()
       
       label.textColor = SingletonStruct.titleColor
       label.backgroundColor = .clear
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
       label.lineBreakMode = .byWordWrapping
       label.numberOfLines = 0
       
       let labelContent = NSAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].departureDate, attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
       
       label.attributedText = labelContent
       return label
    }()
    let trekRetLabel:UILabel = {
       let label = UILabel()
       
       label.textColor = SingletonStruct.titleColor
       label.backgroundColor = .clear
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
       label.lineBreakMode = .byWordWrapping
       label.numberOfLines = 0
       
       let labelContent = NSAttributedString(string: AllTreks.treksArray[AllTreks.selectedTrek].returnDate, attributes: [NSAttributedString.Key.font: SingletonStruct.pageOneSubHeader])
       
       label.attributedText = labelContent
       return label
    }()
    
    
   
    
    //Label holding the destination of the trek
    let trekDatesLabel:UILabel = {
        
        let label = UILabel()
        
        //If there is only a departure date
        if (AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty == false && AllTreks.treksArray[AllTreks.selectedTrek].returnDate.isEmpty){
            
            label.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].departureDate)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 23)])
         
        //If there is NO departure and return date
        }else if (AllTreks.treksArray[AllTreks.selectedTrek].departureDate.isEmpty && AllTreks.treksArray[AllTreks.selectedTrek].returnDate.isEmpty){
            label.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 23)])
            
        //If there is a departure date and a return date
        }else{
            label.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].departureDate) - \(AllTreks.treksArray[AllTreks.selectedTrek].returnDate)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 23)])
        }
 
       label.textColor = SingletonStruct.titleColor
       label.backgroundColor = .clear
    
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
        
       label.numberOfLines = 0
       label.lineBreakMode = .byWordWrapping
        
       return label
    }()
    
    
    @objc func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func edit(){
        
    }
    
}
