//
//  UISingleton.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-29.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit

struct UISingleton {
    
    let mainHeader:UILabel = {
    
        let label = UILabel()
        label.textColor = SingletonStruct.titleColor
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left

        let labelContent = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: SingletonStruct.inputLabel, NSAttributedString.Key.foregroundColor: SingletonStruct.testWhite])
        
         label.attributedText = labelContent
        return label
    }()
    
}
