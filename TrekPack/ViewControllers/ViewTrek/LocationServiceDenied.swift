//
//  InvalidLocation.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-09-10.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit

//Class which represents the viewcontroller informing the user that their location services are disabled for TrekPack
class LocationServiceDeniedViewController: UIViewController {
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: setupUI
    private func setupUI(){
        view.backgroundColor = SingletonStruct.testWhite
        
        view.addSubview(noLocationImg)
        noLocationImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noLocationImg.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        noLocationImg.widthAnchor.constraint(equalToConstant: 75).isActive = true
        noLocationImg.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: noLocationImg.bottomAnchor, constant: 25).isActive = true
        
        view.addSubview(subtitleLabel)
        subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width-50).isActive = true
    }
    

    //MARK: UIDeclarations
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Location Disabled", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.backgroundColor = .clear
        
        return label
    }()
    
    let subtitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: "To get the distance to your destination please enable location services.\nSettings > Privacy > Location Services > TrekPack", attributes: [NSAttributedString.Key.font: SingletonStruct.tipSubtitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    let noLocationImg: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.clear.cgColor
        view.image = UIImage(named: "no_location_icon")
        return view
    }()
}
