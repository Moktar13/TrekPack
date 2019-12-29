//
//  TestPage.swift
//  TrekPack
//
//  Created by Toby moktar on 2019-12-29.
//  Copyright © 2019 Moktar. All rights reserved.
//

import UIKit

class TestPage:UIViewController{
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView()
        view.backgroundColor = .red
    }
    
    func getView() -> UIView {
        return view
    }
}
