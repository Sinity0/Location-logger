//
//  CoreData manager.swift
//  LocationLogger
//
//  Created by Niar on 7/11/17.
//  Copyright © 2017 Niar. All rights reserved.
//

import UIKit
import Foundation
import CoreData

final class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func fetchTokens() -> [AnyObject] {
        
        let fetchRequest: NSFetchRequest<Locations> = Locations.fetchRequest()
        var res: [AnyObject] = []
        
        do {
            res = try getContext().fetch(fetchRequest)

        } catch {
            print("Fetch request error: \(error)")
        }
        
        return res
    }
    
    func save(latitude: Double, longitude: Double, city: String, date: Date, snippet: String) {
        
        let managedContext = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Locations", in: managedContext)!
        
        let credentials = NSManagedObject(entity: entity, insertInto: managedContext)
        
        credentials.setValue(latitude, forKey: "latitude")
        credentials.setValue(longitude, forKey: "longitude")
        credentials.setValue(city, forKey: "city")
        credentials.setValue(date, forKey: "date")
        credentials.setValue(snippet, forKey: "snippet")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
