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


//Struct which contains static methods for executing core data operations
struct CoreDataOperations {
    
    
    //Function which migrates the saved user default data to core data - this runs only once
    //on app start
    static func migrateData(){
        
        print("migrateData() called")
        
        // Referencing app delegate
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
        
    
        //If there are some treks saved in the user defaults then execute this code
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
            
                //Migrating items from [String] -> String
                for x in 0..<trekUD.items.count {
                    
                    // if last item don't add comma, otherwise do
                    if (x+1 == trekUD.items.count){
                        items += "\(trekUD.items[x])"
                    }else{
                        // Adding ⌥ character to indicate separation between items
                        items += "\(trekUD.items[x])⌥"
                    }
                }
                
                //Migrating tags from [String] -> String
                for y in 0..<trekUD.tags.count {
                    
                    // if last item don't add comma, otherwise do
                    if (y+1 == trekUD.tags.count){
                        tags += "\(trekUD.tags[y])"
                    }else{
                        tags += "\(trekUD.tags[y])⌥"
                    }
                }
                
                //Migrating crosses from [String] -> String
                for z in 0..<trekUD.crosses.count {
                    
                    // if last item don't add comma, otherwise do
                    if (z+1 == trekUD.crosses.count){
                        crosses += "\(trekUD.crosses[z])"
                    }else{
                        crosses += "\(trekUD.crosses[z])⌥"
                    }
                }
                
                //Copying the rest of the values but setting unique UUID
                trek.setValue(UUID.init(), forKey: "id")
                trek.setValue("\(trekUD.name)", forKey: "name")
                trek.setValue("\(trekUD.destination)", forKey: "destination")
                trek.setValue("\(trekUD.departureDate)", forKey: "departureDate")
                trek.setValue("\(trekUD.returnDate)", forKey: "returnDate")
                trek.setValue("\(items)", forKey: "items")
                trek.setValue("\(crosses)", forKey: "crosses")
                trek.setValue("\(tags)", forKey: "tags")
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
                
                //Appending data into the treksCoreData arrays
                SingletonStruct.treksCoreData.append(trek)
                counter += 1
            }
            
            //Saving context
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }else{
            print("migrateData() No data found in UserDefaults.")
        }
        
        // Clearing all data from the treksUserDefaults, allTreks, and user defaults
        treksUserDefaults.removeAll()
        SingletonStruct.allTreks.removeAll()
        SingletonStruct.defaults.removeObject(forKey: "saved")
    }
    
    //Function which saves the users treks into core data (similar method to MigrateData())
    static func saveCoreData() {
      
        //Referencing the app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
      
        //Getting the managaged context
        let managedContext = appDelegate.persistentContainer.viewContext

        //Looping through each trek in the allTreks array
        for trekUD in SingletonStruct.allTreks{
        
            //Creating new NSEntityDescription for the entity named 'Trek' in core data
            let trek = NSEntityDescription.insertNewObject(forEntityName: "Trek", into: managedContext)
            
            var items: String = ""
            var tags: String = ""
            var crosses: String = ""
            
            //Migrating items from [String] -> String
            for x in 0..<trekUD.items.count {
                
                // if last item don't add comma, otherwise do
                if (x+1 == trekUD.items.count){
                    items += "\(trekUD.items[x])"
                }else{
                    items += "\(trekUD.items[x])⌥"
                }
            }
            
            //Migrating tags from [String] -> String
            for y in 0..<trekUD.tags.count {
                
                // if last item don't add comma, otherwise do
                if (y+1 == trekUD.tags.count){
                    tags += "\(trekUD.tags[y])"
                }else{
                    tags += "\(trekUD.tags[y])⌥"
                }
            }
            
            //Migrating crosses from [String] -> String
            for z in 0..<trekUD.crosses.count {
                
                // if last item don't add comma, otherwise do
                if (z+1 == trekUD.crosses.count){
                    crosses += "\(trekUD.crosses[z])"
                }else{
                    crosses += "\(trekUD.crosses[z])⌥"
                }
            }
            
            //Copying the remain values but setting unique UUID
            trek.setValue(UUID.init(), forKey: "id")
            trek.setValue("\(trekUD.name)", forKey: "name")
            trek.setValue("\(trekUD.destination)", forKey: "destination")
            trek.setValue("\(trekUD.departureDate)", forKey: "departureDate")
            trek.setValue("\(trekUD.returnDate)", forKey: "returnDate")
            trek.setValue("\(items)", forKey: "items")
            trek.setValue("\(crosses)", forKey: "crosses")
            trek.setValue("\(tags)", forKey: "tags")
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
        
        //Trying to save the managed context
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //Function which fetches the data stored in core data
    static func fetchCoreData(){
        
        print("fetchCoreData() called")
        
        //Referencing the app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
        //Creating the managedContext and the fetchRequest for entity 'Trek'
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Trek")
        fetchRequest.returnsObjectsAsFaults = false

        //Removing all the data from treksCoreData because here is where we will
        //save the return value of the fetch request
        SingletonStruct.treksCoreData.removeAll()
        
        //Attempting to fetch and save in treksCoreData
        do {
            SingletonStruct.treksCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //Function which deletes all data in the core data
    static func deleteAllCoreData(){
        
        //Clearing the array treksCoreData
        SingletonStruct.treksCoreData.removeAll()
        
        print("deleteAllCoreData() called")
        
        //Referencing app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //Creating the managedContext, entity, and fetchRequest for 'Trek'
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Trek", in: managedContext)!
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trek")
        fetchRequest.returnsObjectsAsFaults = false
        
        //Attempting to delete all the objecvts in core data
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
    
    
    //Function which setups the trek format for the data in treksCoreData so that
    //it is useable by the application
    static func setupTrekFormat(){
        
        //Clearign allTreks (newly formatted Treks will saved in here)s
        SingletonStruct.allTreks.removeAll()
        
        print("setupTrekFormat() called")
        print("setupTrekFormat() Treks in CoreData: \(SingletonStruct.treksCoreData.count)")
        
        //Looping through each trek in treksCoreData
        for trek in SingletonStruct.treksCoreData {
            
            //Creating a new trek based on the TrekStruct struct
            var formattedTrek = TrekStruct(name: "", destination: "Destination", departureDate: "", returnDate: "", items: [], crosses: [], tags: [], imageName: "img", imgData: "", streetNumber: "", streetName: "", subCity: "", city: "", municipality: "", province: "", postal: "", country: "", countryISO: "", region: "", ocean: "", latitude: 0.0, longitude: 0.0, distance: 0.0, distanceUnit: "", timeZone: "")
            
            //Setting names as per the values saved in the treksCoreData array
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
    
            //Formatting items from String -> [String]
            for i in trek.value(forKey: "items") as! String {
                
                //Checking the special separator character
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
            
            //Formatting tags from String -> [String]
            for i in trek.value(forKey: "tags") as! String {

                //Checking the special separator character
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
            
            //Formatting tags from String -> [String]
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
            //Appending the newly formattedTrek to allTreks
            SingletonStruct.allTreks.append(formattedTrek)
        }
    }
}
