//
//  CoreDataOperations.swift
//  TrekPack
//
//  Created by Toby moktar on 2020-12-22.
//  Copyright © 2020 Moktar. All rights reserved.
//

import Foundation
import CoreData
import UIKit


struct CoreDataOperations {
    
    
    static func migrateData(){
        
        print("migrateData() called")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
      
      
        //Getting treks from user defaults
        guard let trekData = SingletonStruct.defaults.object(forKey: "saved") as? Data else {
            print("migrateData() can't find UserDefault Data")
            return
        }
        
        //Attempting to decode the trek data into an array of treks
        guard var treksUserDefaults = try? PropertyListDecoder().decode([TrekStruct].self, from: trekData) else {
            print("migrateData() error decoding UserDefault Data")
            return
        }
        
       
        
        //Loading the treks from the saved array in user defaults
        SingletonStruct.allTreks = treksUserDefaults
        SingletonStruct.treksCoreData.removeAll()
        
        print("UserDefault Treks: \(SingletonStruct.allTreks.count)")
        
        if (treksUserDefaults.isEmpty == false){
            
            let managedContext = appDelegate.persistentContainer.viewContext

            print("migrateDate() migrating: UserDefaults -> CoreData")
            
            var counter = 0
            
            // transfer data
            for trekUD in treksUserDefaults{
                
                let trek = NSEntityDescription.insertNewObject(forEntityName: "Trek", into: managedContext)
                
                var items: String = ""
                var tags: String = ""
                var crosses: String = ""
            
                // migrating items
                for x in 0..<trekUD.items.count {
                    
                    // if last item don't add comma, otherwise do
                    if (x+1 == trekUD.items.count){
                        items += "\(trekUD.items[x])"
                    }else{
                        items += "\(trekUD.items[x])⌥"
                    }
                }
                
                // migrating tags
                for y in 0..<trekUD.tags.count {
                    
                    // if last item don't add comma, otherwise do
                    if (y+1 == trekUD.tags.count){
                        tags += "\(trekUD.tags[y])"
                    }else{
                        tags += "\(trekUD.tags[y])⌥"
                    }
                }
                
                // migrating crosses
                for z in 0..<trekUD.crosses.count {
                    
                    // if last item don't add comma, otherwise do
                    if (z+1 == trekUD.crosses.count){
                        crosses += "\(trekUD.crosses[z])"
                    }else{
                        crosses += "\(trekUD.crosses[z])⌥"
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
                
                SingletonStruct.treksCoreData.append(trek)
                counter += 1
                
                    
                
                
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            
            
            
        }else{
            print("migrateData() No data found in UserDefaults.")
        }
        
        treksUserDefaults.removeAll()
        SingletonStruct.allTreks.removeAll()
        SingletonStruct.defaults.removeObject(forKey: "saved")
        
    }
    
    static func saveCoreData() {
      
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
      
        let managedContext = appDelegate.persistentContainer.viewContext

        
        
        for trekUD in SingletonStruct.allTreks{
        
            let trek = NSEntityDescription.insertNewObject(forEntityName: "Trek", into: managedContext)
            
            var items: String = ""
            var tags: String = ""
            var crosses: String = ""
            
            
        
            // migrating items
            for x in 0..<trekUD.items.count {
                
                // if last item don't add comma, otherwise do
                if (x+1 == trekUD.items.count){
                    items += "\(trekUD.items[x])"
                }else{
                    items += "\(trekUD.items[x])⌥"
                }
            }
            
            // migrating tags
            for y in 0..<trekUD.tags.count {
                
                // if last item don't add comma, otherwise do
                if (y+1 == trekUD.tags.count){
                    tags += "\(trekUD.tags[y])"
                }else{
                    tags += "\(trekUD.tags[y])⌥"
                }
            }
            
            // migrating crosses
            for z in 0..<trekUD.crosses.count {
                
                // if last item don't add comma, otherwise do
                if (z+1 == trekUD.crosses.count){
                    crosses += "\(trekUD.crosses[z])"
                }else{
                    crosses += "\(trekUD.crosses[z])⌥"
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
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func fetchCoreData(){
        
        print("fetchCoreData() called")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Trek")
        fetchRequest.returnsObjectsAsFaults = false

        
        SingletonStruct.treksCoreData.removeAll()
        
        do {
            SingletonStruct.treksCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    static func deleteAllCoreData(){
        
        SingletonStruct.treksCoreData.removeAll()
        
        print("deleteAllCoreData() called")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Trek", in: managedContext)!
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trek")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedContext.delete(objectData)
                try managedContext.save();
            }
        } catch let error {
            print("Delete all data in \(entity) error :", error)
        }
    }
    
    
    
    static func setupTrekFormat(){
        
        SingletonStruct.allTreks.removeAll()
        
        print("setupTrekFormat() called")
        print("setupTrekFormat() Treks in CoreData: \(SingletonStruct.treksCoreData.count)")
        
        for trek in SingletonStruct.treksCoreData {
            
            
            var formattedTrek = TrekStruct(name: "", destination: "Destination", departureDate: "", returnDate: "", items: [], crosses: [], tags: [], imageName: "img", imgData: "", streetNumber: "", streetName: "", subCity: "", city: "", municipality: "", province: "", postal: "", country: "", countryISO: "", region: "", ocean: "", latitude: 0.0, longitude: 0.0, distance: 0.0, distanceUnit: "", timeZone: "")
            
            formattedTrek.name = trek.value(forKey: "name") as! String
            formattedTrek.destination = trek.value(forKey: "destination") as! String
            formattedTrek.departureDate = trek.value(forKey: "departureDate") as! String
            formattedTrek.returnDate = trek.value(forKey: "returnDate") as! String
            formattedTrek.imageName = trek.value(forKey: "imageName") as! String
            formattedTrek.imgData = trek.value(forKey: "imgData") as! String
            formattedTrek.streetNumber = trek.value(forKey: "streetNumber") as! String
            formattedTrek.streetName = trek.value(forKey: "streetName") as! String
            formattedTrek.subCity = trek.value(forKey: "subCity") as! String
            formattedTrek.city = trek.value(forKey: "city") as! String
            formattedTrek.municipality = trek.value(forKey: "municipality") as! String
            formattedTrek.province = trek.value(forKey: "province") as! String
            formattedTrek.postal = trek.value(forKey: "postal") as! String
            formattedTrek.country = trek.value(forKey: "country") as! String
            formattedTrek.countryISO = trek.value(forKey: "countryISO") as! String
            formattedTrek.region = trek.value(forKey: "region") as! String
            formattedTrek.ocean = trek.value(forKey: "ocean") as! String
            formattedTrek.latitude = trek.value(forKey: "latitude") as! Double
            formattedTrek.longitude = trek.value(forKey: "longitude") as! Double
            formattedTrek.distance = trek.value(forKey: "distance") as! Double
            formattedTrek.distanceUnit = trek.value(forKey: "distanceUnit") as! String
            formattedTrek.timeZone = trek.value(forKey: "timeZone") as! String
            
            var counter = 0
            
            var item = ""
    
            // looping for items
            for i in trek.value(forKey: "items") as! String {
                
                if (i != "⌥") {
                    
                    item += "\(i)"
                    
                    // If it's the last character
                    if (counter+1 == (trek.value(forKey: "items") as! String).count){
                        formattedTrek.items.append(item)
                    }
                    
                }else{
                    formattedTrek.items.append(item)
                    item = ""
                }
                
                counter += 1
            }
            
            counter = 0
            
            var tag = ""

            for i in trek.value(forKey: "tags") as! String {

                if (i != "⌥") {

                    tag += "\(i)"

                    // If it's the last character
                    if (counter+1 == (trek.value(forKey: "tags") as! String).count){
                        formattedTrek.tags.append(tag)
                        tag = ""
                    }

                }else{
                    formattedTrek.tags.append(tag)
                    tag = ""
                }
                counter += 1
            }
            
            counter = 0
            
            var cross = ""
            
            
            for i in trek.value(forKey: "crosses") as! String {

                if (i != "⌥") {

                    cross += "\(i)"

                    // If it's the last character
                    if (counter+1 == (trek.value(forKey: "crosses") as! String).count){
                        
                        if (cross == "false"){
                            formattedTrek.crosses.append(false)
                        }else if (cross == "true"){
                            formattedTrek.crosses.append(true)
                        }
                        
                        cross = ""
                    }

                }else{
                    if (cross == "false"){
                        formattedTrek.crosses.append(false)
                    }else if (cross == "true"){
                        formattedTrek.crosses.append(true)
                    }
                    cross = ""
                }
                counter += 1
            }
            
        
//                print("BIRTHED TREK")
//                print(formattedTrek.name)
//                print(formattedTrek.destination)
//                print(formattedTrek.departureDate)
//                print(formattedTrek.returnDate)
//                print(formattedTrek.imageName)
//                print(formattedTrek.imgData)
//                print(formattedTrek.streetNumber)
//                print(formattedTrek.streetName)
//                print(formattedTrek.subCity)
//                print(formattedTrek.city)
//                print(formattedTrek.municipality)
//                print(formattedTrek.province)
//                print(formattedTrek.postal)
//                print(formattedTrek.country)
//                print(formattedTrek.countryISO)
//                print(formattedTrek.region)
//                print(formattedTrek.ocean)
//                print(formattedTrek.latitude)
//                print(formattedTrek.longitude)
//                print(formattedTrek.distance)
//                print(formattedTrek.distanceUnit)
//                print(formattedTrek.items)
//                print(formattedTrek.tags)
//                print(formattedTrek.crosses)
            

            
            SingletonStruct.allTreks.append(formattedTrek)
            
        }
        
    }
    
}
