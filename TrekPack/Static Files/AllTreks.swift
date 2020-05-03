//
//  AllTreks.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-04-23.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation

//Singleton
class AllTreks{
    
    static var treksArray: [TrekStruct] = []
    
    ///Todo: might not need this
    static var makingNewTrek: Bool = false
    
    private init(){
    }
}
