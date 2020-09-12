//
//  Country.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-07-22.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit

//MARK: Country
struct Country: Codable {
    var name:String
    var capital:String
    var population:Int
    var timezones:[String]
    var currencies: [Currencies]
    var languages:[Languages]
}

//MARK: Currencies
struct Currencies: Codable {
    let code:String
    let name:String
    let symbol:String
}

//MARK: Languages
struct Languages: Codable {
    let iso639_1:String
    let iso639_2:String
    let name:String
    let nativeName:String
}

