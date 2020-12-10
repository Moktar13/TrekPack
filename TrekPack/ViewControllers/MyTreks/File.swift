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
    
    
    
    func saveCoreData() {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Trek",
                                   in: managedContext)!
      
      let trek = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
        trek.setValue("test name 2", forKeyPath: "name")

        trek.setValue(UUID.init(), forKey: "id")
      
      // 4
      do {
        try managedContext.save()
        treks.append(trek)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    
    func fetchCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Trek")
        
        fetchRequest.returnsObjectsAsFaults = false
          
          //3
          do {
            treks = try managedContext.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
    }
}
