//
//  File.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-12-10.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension TreksTableViewController {
    
    func migrateData(){
        
        print("migrateData() called")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
      
      
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Trek", in: managedContext)!
        let trek = NSManagedObject(entity: entity, insertInto: managedContext)
        
   
        //Getting treks from user defaults
        guard let trekData = SingletonStruct.defaults.object(forKey: "saved") as? Data else {
            print("Couldn't find saved data")
            return
        }
        
        //Attempting to decode the trek data into an array of treks
        guard let treksUserDefaults = try? PropertyListDecoder().decode([TrekStruct].self, from: trekData) else {
            print("Something went wrong")
            return
        }
        
        
    
        if (treksUserDefaults.isEmpty == false){
            
            print("Data found, migrating...")
            
            // transfer data
            for trekUD in treksUserDefaults{
                
                var items: String = ""
                var tags: String = ""
                var crosses: String = ""
            
                // migrating items
                for x in 0..<trekUD.items.count {
                    
                    // if last item don't add comma, otherwise do
                    if (x+1 == trekUD.items.count){
                        items += "\(trekUD.items[x])"
                    }else{
                        items += "\(trekUD.items[x]),"
                    }
                }
                
                // migrating tags
                for y in 0..<trekUD.tags.count {
                    
                    // if last item don't add comma, otherwise do
                    if (y+1 == trekUD.tags.count){
                        tags += "\(trekUD.tags[y])"
                    }else{
                        tags += "\(trekUD.tags[y]),"
                    }
                }
                
                // migrating crosses
                for z in 0..<trekUD.crosses.count {
                    
                    // if last item don't add comma, otherwise do
                    if (z+1 == trekUD.crosses.count){
                        crosses += "\(trekUD.crosses[z])"
                    }else{
                        crosses += "\(trekUD.crosses[z]),"
                    }
                }
                
                
                trek.setValue(UUID.init(), forKey: "id")
                trek.setValue("\(trekUD.name)", forKey: "name")
                trek.setValue("\(trekUD.destination)", forKey: "destination")
                trek.setValue("\(trekUD.departureDate)", forKey: "departureDate")
                trek.setValue("\(trekUD.returnDate)", forKey: "returnDate")
                trek.setValue("\(items)", forKey: "items")          // Change this to array of string
                trek.setValue("\(crosses)", forKey: "crosses")      // Change this to array of Bool
                trek.setValue("\(tags)", forKey: "tags")            // Change this to array of emojis
                trek.setValue("\(trekUD.imageName)", forKey: "imageName")
                trek.setValue("\(trekUD.imgData)", forKey: "imgData")
                trek.setValue("\(trekUD.streetNumber)", forKey: "streetNumber")
                trek.setValue("\(trekUD.streetName)", forKey: "streetName")
                trek.setValue("\(trekUD.subCity)", forKey: "subCity")
                trek.setValue("\(trekUD.city)", forKey: "city")
                trek.setValue("\(trekUD.municipality)", forKey: "municipality")
                trek.setValue("\(trekUD.province)", forKey: "province")
                trek.setValue("\(trekUD.postal)", forKey: "postal")
                trek.setValue("\(trekUD.country)", forKey: "country")
                trek.setValue("\(trekUD.countryISO)", forKey: "countryISO")
                trek.setValue("\(trekUD.region)", forKey: "region")
                trek.setValue("\(trekUD.ocean)", forKey: "ocean")
                trek.setValue(trekUD.latitude, forKey: "latitude")
                trek.setValue(trekUD.longitude, forKey: "longitude")
                trek.setValue(trekUD.distance, forKey: "distance")
                trek.setValue("\(trekUD.distanceUnit)", forKey: "distanceUnit")
                trek.setValue("\(trekUD.timeZone)", forKey: "timeZone")
                
                do {
                    try managedContext.save()
                        treksCoreData.append(trek)
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }else{
            print("No data found in UserDefaults.")
        }
    }
    

    func saveCoreData() {
      
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
      
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext

        // 2
        let entity = NSEntityDescription.entity(forEntityName: "Trek", in: managedContext)!

        let trek = NSManagedObject(entity: entity, insertInto: managedContext)
      
        // 3
        trek.setValue("test name 2", forKeyPath: "name")

        trek.setValue(UUID.init(), forKey: "id")
      
    // 4
        do {
            try managedContext.save()
                treksCoreData.append(trek)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func fetchCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
        let managedContext = appDelegate.persistentContainer.viewContext

        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Trek")

        fetchRequest.returnsObjectsAsFaults = false

        //3
        do {
            treksCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
