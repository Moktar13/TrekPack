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
        
        ///BAKGROUND
        
      

        view.viewAddBackground(imgName: "sm")
        
        
        setupNavBar()
        setupScreen()
    }
    
    
    func setupNavBar(){
          
          navigationController!.navigationBar.barTintColor = ColorStruct.titleColor
          navigationController!.navigationBar.tintColor = ColorStruct.pinkColor
        
//        let backButton = UIBarButtonItem(barButtonSystemItem: ., target: self, action: #selector(ViewTrekViewController.goBack))
        
        let backButton:UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(ViewTrekViewController.goBack))
    
          let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil )
        
          navigationItem.leftBarButtonItem = backButton
          navigationItem.rightBarButtonItem = editButton
          navigationItem.title = "\(AllTreks.treksArray[AllTreks.selectedTrek].name)"
          
          navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorStruct.pinkColor]
      }
    
    func setupScreen(){
        //Trek name label
//        view.addSubview(trekNameLabel)
//        trekNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        trekNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        trekNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//
//        //Trek destination label
        view.addSubview(trekDestinationLabel)
//        trekDestinationLabel.topAnchor.constraint(equalTo: trekNameLabel.bottomAnchor, constant: 5).isActive = true
//        trekDestinationLabel.leadingAnchor.constraint(equalTo: trekNameLabel.leadingAnchor).isActive = true
//        trekDestinationLabel.trailingAnchor.constraint(equalTo: trekNameLabel.trailingAnchor).isActive = true
        
        trekDestinationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trekDestinationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//
//        //Trek departure/return label
//        view.addSubview(trekDatesLabel)
//        trekDatesLabel.topAnchor.constraint(equalTo: trekDestinationLabel.bottomAnchor, constant: 5).isActive = true
//        trekDatesLabel.leadingAnchor.constraint(equalTo: trekDestinationLabel.leadingAnchor).isActive = true
//        trekDatesLabel.trailingAnchor.constraint(equalTo: trekDestinationLabel.trailingAnchor).isActive = true
        
        
    }
    
    //Label holding the name of the trek
    let trekNameLabel:UILabel = {
        
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "\(AllTreks.treksArray[AllTreks.selectedTrek].name)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28)])
        
       label.textColor = ColorStruct.titleColor
       label.backgroundColor = .clear
    
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
        
       label.numberOfLines = 0
       label.lineBreakMode = .byWordWrapping
        
        
        
        
       return label
    }()
    
    //Label holding the destination of the trek
    let trekDestinationLabel:UILabel = {
        
        let label = UILabel()
          label.attributedText = NSAttributedString(string: "Destination", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        
          label.textColor = ColorStruct.titleColor
          label.backgroundColor = .clear
        
          label.translatesAutoresizingMaskIntoConstraints = false
          label.textAlignment = .left
          
          let full = NSMutableAttributedString(string: "")
          
          let icon = NSTextAttachment()
          icon.image = UIImage(named: "send")
          icon.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
          
          let str1 = NSAttributedString(attachment: icon)
          
          full.append(str1)
          
          label.attributedText = full
          label.alpha = 0.80
        
       label.numberOfLines = 0
       label.lineBreakMode = .byWordWrapping
        
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
 
       label.textColor = ColorStruct.titleColor
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
