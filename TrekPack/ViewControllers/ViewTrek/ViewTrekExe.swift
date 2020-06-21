//
//  ViewTrekExe.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-27.
//  Copyright © 2020 Moktar. All rights reserved.
//


import UIKit


//EXTENSION FOR MAIN UI STUFF
extension ViewTrekViewController{
    
    
    //NAVBAR
    func setupNavBar(){
        let settingsButton = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(ViewTrekViewController.openSettings))
        self.navigationItem.rightBarButtonItem = settingsButton
          }
    
    //SCREEN
    func setupScreen(){
        //BACKGROUND IMAGE
        view.addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        imgView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        
        view.addSubview(whiteSpaceView)
        whiteSpaceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/2 - view.frame.height/3.5).isActive = true
        whiteSpaceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteSpaceView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        whiteSpaceView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height/6).isActive = true
        
        
//        trekSV.heightAnchor.constraint(equalToConstant: trekSV.frame.height).isActive = true
//        trekSV.widthAnchor.constraint(equalToConstant: trekSV.frame.width).isActive = true
        
      
//        btnOptionsStack.addArrangedSubview(trekInfoBtn)
//        btnOptionsStack.addArrangedSubview(trekItemsBtn)
//        btnOptionsStack.addArrangedSubview(trekRouteBtn)
//
//        view.addSubview(btnOptionsStack)
//        btnOptionsStack.topAnchor.constraint(equalTo: whiteSpaceView.topAnchor, constant: 10).isActive = true
//        btnOptionsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        btnOptionsStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -view.frame.width/6).isActive = true
//        btnOptionsStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
        
       
//
        view.addSubview(trekItemsBtn)
//        trekItemsBtn.leadingAnchor.constraint(equalTo: trekInfoBtn.trailingAnchor, constant: 16).isActive = true
        trekItemsBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trekItemsBtn.topAnchor.constraint(equalTo: whiteSpaceView.topAnchor, constant: 16).isActive = true
        trekItemsBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        view.addSubview(trekInfoBtn)
//        trekInfoBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        trekInfoBtn.trailingAnchor.constraint(equalTo: trekItemsBtn.leadingAnchor, constant: -25).isActive = true
        trekInfoBtn.topAnchor.constraint(equalTo: whiteSpaceView.topAnchor, constant: 16).isActive = true
        trekInfoBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(trekRouteBtn)
        //        trekInfoBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        trekRouteBtn.leadingAnchor.constraint(equalTo: trekItemsBtn.trailingAnchor, constant: 25).isActive = true
        trekRouteBtn.topAnchor.constraint(equalTo: whiteSpaceView.topAnchor, constant: 16).isActive = true
        trekRouteBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true

        trekSV = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width-50, height: view.frame.height/2))
        trekSV.isPagingEnabled = true
        trekSV.backgroundColor = .clear
        trekSV.isScrollEnabled = true
        trekSV.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(trekSV)
        trekSV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trekSV.topAnchor.constraint(equalTo: trekItemsBtn.bottomAnchor).isActive = true
        trekSV.heightAnchor.constraint(equalToConstant: trekSV.frame.height).isActive = true
        trekSV.widthAnchor.constraint(equalToConstant: trekSV.frame.width).isActive = true
       
        
//        view.bringSubviewToFront(btnOptionsStack)
//        btnOptionsStack.addSubview(trekItemsBtn)
//        btnOptionsStack.addSubview(trekRouteBtn)
        
//        view.addSubview(backdropOne)
//
//        //TREK INFO
//        view.addSubview(trekInformation)
//        trekInformation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/24).isActive = true
//        trekInformation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/24).isActive = true
//        trekInformation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/16).isActive = true
//
//
//        backdropOne.topAnchor.constraint(equalTo: trekInformation.topAnchor, constant: -10).isActive = true
//        backdropOne.bottomAnchor.constraint(equalTo: trekInformation.bottomAnchor, constant: 10).isActive = true
//        backdropOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/32).isActive = true
//        backdropOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/32).isActive = true
//
//
//        view.addSubview(backdropTwo)
//        view.addSubview(trekCountdown)
//        trekCountdown.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/24).isActive = true
//        trekCountdown.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: view.frame.width/24).isActive = true
//        trekCountdown.topAnchor.constraint(equalTo: backdropOne.bottomAnchor, constant: view.frame.width/16).isActive = true
//
//        backdropTwo.topAnchor.constraint(equalTo: trekCountdown.topAnchor, constant: -10).isActive = true
//        backdropTwo.bottomAnchor.constraint(equalTo: trekCountdown.bottomAnchor, constant: 10).isActive = true
//        backdropTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/32).isActive = true
//        backdropTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/32).isActive = true
//
//        getTimeLeft()
//
//        view.addSubview(backdropThree)
//        backdropThree.topAnchor.constraint(equalTo: backdropTwo.bottomAnchor, constant: view.frame.width/16 - 10).isActive = true
//        backdropThree.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.height/16 +     10).isActive = true
//        backdropThree.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/32).isActive = true
//        backdropThree.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -view.frame.width/32).isActive = true
//
//
//        view.addSubview(trekItem)
//        trekItem.topAnchor.constraint(equalTo: backdropThree.topAnchor, constant: 10).isActive = true
//        trekItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/24).isActive = true
//        trekItem.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/24).isActive = true
//
//
//        view.addSubview(itemsTableView)
//        itemsTableView.topAnchor.constraint(equalTo: trekItem.bottomAnchor, constant: view.frame.width/16 - 10).isActive = true
//        itemsTableView.leadingAnchor.constraint(equalTo: backdropThree.leadingAnchor).isActive = true
//        itemsTableView.trailingAnchor.constraint(equalTo: backdropThree.trailingAnchor).isActive = true
//        itemsTableView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//
        
        
        
        
        
        

        
//        if (heightID == 1){
//
//        }
        
        
//        view.addSubview(trekItem)
//        trekItem.topAnchor.constraint(equalTo: trekInformation.bottomAnchor, constant: view.frame.width/16).isActive = true
//        trekItem.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/24).isActive = true
//        trekItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/24).isActive = true
//
//        view.addSubview(itemsTableView)
//        itemsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/24).isActive = true
//        itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/24).isActive = true
//        itemsTableView.topAnchor.constraint(equalTo: trekItem.bottomAnchor).isActive = true
//
//
//        if (heightID == 1){
//            itemsTableView.heightAnchor.constraint(equalToConstant: view.frame.height/2 + view.frame.height/16).isActive = true
//        }else if (heightID == 2){
//            itemsTableView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
//        }else if (heightID == 3){
//            itemsTableView.heightAnchor.constraint(equalToConstant: view.frame.height/2 - view.frame.width/8).isActive = true
//        }
        
    


       }
    
    
    
    
    
}
