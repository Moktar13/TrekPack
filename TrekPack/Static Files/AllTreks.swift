//
//  AllTreks.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-04-23.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation

//Singleton Class used to hold mutable values which are used throughout the app
class AllTreks{
    
    //Mutable variables
    static var treksArray: [TrekStruct] = []
    static var selectedTrek: Int = -1
    static var makingNewTrek: Bool = false
    
    private init(){
    }
}

