//
//  NewTripPage2ViewController.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-02.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit

class NewTripPage2ViewController:UIViewController,UITextFieldDelegate {
    //TODO: The datepicker only assigns the date to the departure date text field, when it should be doing it for
        //both departure and return date text fields
        
     
        var isReturn = false

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //Used to hide to hide keyboard on tap
            self.setupHideKeyboardOnTap()
            
            
           
            
            setupCurrentView()
            
        }
        
        

        
        private func setupCurrentView(){
            view.backgroundColor = ColorStruct.backgroundColor
    }
}
