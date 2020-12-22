//
//  AllTreks.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-05-03.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import UIKit
import MapKit

//Struct which represents a Trek
struct TrekStruct: Codable {
    var name:String
    var destination:String
    var departureDate:String
    var returnDate:String
    var items:[String]
    var crosses:[Bool]
    var tags:[String]
    var imageName: String
    var imgData: String
    var streetNumber: String
    var streetName: String
    var subCity: String
    var city: String
    var municipality: String
    var province: String
    var postal: String
    var country: String
    var countryISO: String
    var region: String
    var ocean: String
    var latitude: Double
    var longitude: Double
    var distance: Double
    var distanceUnit: String
    var timeZone: String
}

