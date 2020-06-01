//
//  AllTreks.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-04-23.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation

//CLASS SINGLETON VALUES ARE MUTABLE -- STRUCT SINGLETON VALUES ARE NOT
//Singleton
class AllTreks{
    
    static var treksArray: [TrekStruct] = []
    static var selectedTrek: Int = -1
    static var newTrek:Bool = false
    
    
    ///Todo: might not need this
    static var makingNewTrek: Bool = false
    
    private init(){
    }
}
