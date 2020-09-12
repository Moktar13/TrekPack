//
//  PlacemarkAnnotation.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-07-10.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit
import MapKit

//Subclass of MKAnnotation and NSObject
class PlacemarkAnnotation: NSObject, MKAnnotation {
    
    //Class variables
    var title:String?
    var info:String
    var streetNumber:String
    var streetName:String
    var subCity:String
    var city:String
    var municipality:String
    var province:String
    var postal:String
    var country:String
    var region:String
    var ocean:String
    var coordinate: CLLocationCoordinate2D

    //Class init
    init(title:String, info:String,streetNumber: String, streetName: String, subCity: String, city: String, municipality: String, province: String, postal: String, country: String, region: String, ocean: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.info = info
        self.streetNumber = streetNumber
        self.streetName = streetName
        self.subCity = subCity
        self.city = city
        self.municipality = municipality
        self.province = province
        self.postal = postal
        self.country = country
        self.region = region
        self.ocean = ocean
        self.coordinate = coordinate
    }
}
