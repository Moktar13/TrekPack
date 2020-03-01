//
//  TabBarControlller.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-23.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

//TabBarController for the TabBar
class TabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Todo: Modify icons at bottom to match the color of the text!
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ColorStruct.pinkColor], for: .selected)
    }
    
}
