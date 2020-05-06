//
//  AllTreks.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-04-23.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation

///Todo: Rename this so it fits as a general purpose singleton not just as singleton for AllTreks
//Singleton
class AllTreks{
    
    static var treksArray: [TrekStruct] = []
    
    
    ///Todo: might not need this
    static var makingNewTrek: Bool = false
    
    private init(){
    }
}
