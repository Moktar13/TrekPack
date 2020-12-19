//
//  Trek+CoreDataClass.swift
//  
//
//  Created by Toby moktar on 2020-12-19.
//
//

import Foundation
import CoreData

@objc(Trek)
public class Trek: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trek> {
        return NSFetchRequest<Trek>(entityName: "Trek")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var destination: String?
    @NSManaged public var departureDate: String?
    @NSManaged public var returnDate: String?
    @NSManaged public var items: String?
    @NSManaged public var crosses: String?
    @NSManaged public var tags: String?
    @NSManaged public var imageName: String?
    @NSManaged public var imgData: String?
    @NSManaged public var streetNumber: String?
    @NSManaged public var streetName: String?
    @NSManaged public var subCity: String?
    @NSManaged public var city: String?
    @NSManaged public var municipality: String?
    @NSManaged public var province: String?
    @NSManaged public var postal: String?
    @NSManaged public var country: String?
    @NSManaged public var countryISO: String?
    @NSManaged public var region: String?
    @NSManaged public var ocean: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var distance: Double
    @NSManaged public var distanceUnit: String?
    @NSManaged public var timeZone: String?
}
