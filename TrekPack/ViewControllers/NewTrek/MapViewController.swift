//
//  MapViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-06-29.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setupMap()
        setupNavigationBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    private func setupMap(){
        let map = MKMapView()
        
        map.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(map)
        
        map.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        map.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        map.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        map.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    
    private func setupNavigationBar(){
    
        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = .clear
        navBar.tintColor = .black
        navBar.setBackgroundImage(UIImage(named:"transparent"), for: .default)
        navBar.shadowImage = UIImage()
        
        view.addSubview(navBar)
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let navItem = UINavigationItem(title: "")
        
        let backItem = UIBarButtonItem(image: UIImage(named: "x"), style: .plain, target: self, action: #selector(MapViewController.cancelMap))
       
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
    }
    
    
    
    @objc func cancelMap(){
        dismiss(animated: true, completion: nil)
    }
}
