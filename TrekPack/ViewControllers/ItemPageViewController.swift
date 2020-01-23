//
//  ItemPageViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-12.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class ItemPageViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorStruct.backgroundColor
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.dismiss(animated: true, completion: nil)
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if self.isMovingFromParent{
            print("Going")
        }
    }
    
    
}
