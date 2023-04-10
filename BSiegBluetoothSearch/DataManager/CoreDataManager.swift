//
//  CoreDataManager.swift
//  BSiegBluetoothSearch
//
//  Created by JOJO on 2023/4/10.
//

import UIKit
import CoreData

class CoreDataManager {
  
  static var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "BluetoothScanner")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
      
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  static var backgroundContext: NSManagedObjectContext = {
    return CoreDataManager.persistentContainer.newBackgroundContext()
  }()
  
  init() {
 
    
  }
  
}
