//
//  Trek+CoreDataProperties.swift
//  
//
//  Created by Toby moktar on 2020-12-10.
//
//

import Foundation
import CoreData


extension Trek {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trek> {
        return NSFetchRequest<Trek>(entityName: "Trek")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?

}
