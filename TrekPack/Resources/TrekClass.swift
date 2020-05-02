//
//  TrekStruct.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-01-05.
//  Copyright © 2020 Moktar. All rights reserved.
//

import UIKit


class Trek {
    
    var name: String
    var destination: String
    var departureDate: String
    var returnDate: String
    var items: [String]
    var tags: [String]
    
    //Class constructor
    init(name: String, destination: String, departureDate: String, returnDate: String, items: [String], tags: [String]){
        self.name = name
        self.destination = destination
        self.departureDate = departureDate
        self.returnDate = returnDate
        self.items = items
        self.tags = tags
    }

}
