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
    
    //SCREEN
    func setupScreen(){
        
        //img view
        view.addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        imgView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        //white space
        view.addSubview(whiteSpaceView)
        whiteSpaceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/2 - view.frame.height/5).isActive = true
        whiteSpaceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteSpaceView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        whiteSpaceView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height/6).isActive = true
        
        
        //items button
        view.addSubview(trekItemsBtn)
        trekItemsBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trekItemsBtn.topAnchor.constraint(equalTo: whiteSpaceView.topAnchor, constant: 16).isActive = true
        trekItemsBtn.heightAnchor.constraint(equalToConstant: trekItemsBtn.titleLabel!.frame.height + 5).isActive = true
        
        //info button
        view.addSubview(trekInfoBtn)
        trekInfoBtn.trailingAnchor.constraint(equalTo: trekItemsBtn.leadingAnchor, constant: -25).isActive = true
        trekInfoBtn.topAnchor.constraint(equalTo: whiteSpaceView.topAnchor, constant: 16).isActive = true
        trekInfoBtn.heightAnchor.constraint(equalToConstant: trekInfoBtn.titleLabel!.frame.height + 5).isActive = true
        
        //route button
        view.addSubview(trekRouteBtn)
        trekRouteBtn.leadingAnchor.constraint(equalTo: trekItemsBtn.trailingAnchor, constant: 25).isActive = true
        trekRouteBtn.topAnchor.constraint(equalTo: whiteSpaceView.topAnchor, constant: 16).isActive = true
        trekRouteBtn.heightAnchor.constraint(equalToConstant: trekRouteBtn.titleLabel!.frame.height + 5).isActive = true

        //scroll view
        trekSV = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2 + view.frame.height/12))
        trekSV.isPagingEnabled = true
        trekSV.backgroundColor = .clear
        trekSV.isScrollEnabled = false
        trekSV.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(trekSV)
        trekSV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        trekSV.topAnchor.constraint(equalTo: trekItemsBtn.bottomAnchor).isActive = true
        trekSV.heightAnchor.constraint(equalToConstant: trekSV.frame.height).isActive = true
        trekSV.widthAnchor.constraint(equalToConstant: trekSV.frame.width).isActive = true
       
       }
    
    
    
    
    
}
