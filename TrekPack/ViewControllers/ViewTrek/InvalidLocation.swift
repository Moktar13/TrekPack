//
//  InvalidLocation.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-09-10.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit


class InvalidLocationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    
    private func setupUI(){
        view.backgroundColor = SingletonStruct.testWhite
        
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25).isActive = true
        
        view.addSubview(subtitleLabel)
        subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width-50).isActive = true
    }
    
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSAttributedString(string: "Uh-oh...", attributes: [NSAttributedString.Key.font: SingletonStruct.tipTitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.backgroundColor = .clear
        
        return label
    }()
    
    let subtitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: "Unable to retrieve distance to Trek destination, please enable location services in your device settings.", attributes: [NSAttributedString.Key.font: SingletonStruct.tipSubtitleFont, NSAttributedString.Key.foregroundColor: SingletonStruct.testBlue])
        label.backgroundColor = .clear
        return label
    }()
    
    
}
