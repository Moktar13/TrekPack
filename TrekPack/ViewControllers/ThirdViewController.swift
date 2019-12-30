//
//  ThirdViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-23.
//  Copyright © 2019 Moktar. All rights reserved.
//

import Foundation
import UIKit

//ViewControlle for MY TRIPS
class ThirdViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
   
    
    private let myArray: NSArray = ["First","Second","Third"]
    private var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        setupUI()
        setupUINavBar()
        
    }
    
    
    let titleView:UITextView = {
        
            let textView = UITextView()
        
            let attributeText = NSMutableAttributedString(string:"My Trips View", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: ColorStruct.titleColor, NSAttributedString.Key.backgroundColor: ColorStruct.backgroundColor])
            
            textView.backgroundColor = .clear
            textView.attributedText = attributeText
            textView.translatesAutoresizingMaskIntoConstraints = false
                
            textView.textAlignment = .center
            textView.isEditable = false
            textView.isScrollEnabled = false
            return textView
    }()
    
//    let tableView:UITableView = {
//        let table = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400), style: UITableView.Style.plain)
//        table.backgroundColor = .black
//        table.translatesAutoresizingMaskIntoConstraints = false
//        return table
//    }()
//
    
    func setupUI(){
        
        
        
        view.addSubview(titleView)
        
               // view.backgroundColor = UIColor(red: 7/255, green: 7/255, blue: 7/255, alpha: 1)
        view.backgroundColor = ColorStruct.backgroundColor
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        
//        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        titleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
      
        
//        titleView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        titleView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
//        titleView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
//        titleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupUINavBar(){
       let filterBtn = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(ThirdViewController.filterButton))
        
        filterBtn.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: ColorStruct.titleColor], for: .normal)
        
       self.navigationItem.leftBarButtonItem = filterBtn
       
       self.navigationController?.navigationBar.barTintColor = ColorStruct.backgroundColor
       
    }

    @objc func filterButton(){
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
       }
       
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel?.text = "\(myArray[indexPath.row])"
        return cell
   }
       
}


