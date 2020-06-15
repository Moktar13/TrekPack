//
//  AllTreks.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-03.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit

struct TrekStruct: Codable {
    var name:String
    var destination:String
    var departureDate:String
    var returnDate:String
    var items:[String]
    var tags:[String]
    var imageName: String
    var imgData: String
}
