//
//  IdDataStore.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/16/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import UIKit
import CoreData

protocol IdDataStore {
    func add(identity: Identifiable)
    func remove(identity: Identifiable)
    func contains(identity: Identifiable) -> Bool
}

private extension ID {
    
    //@REQUIRE: context is part of the SeatGeekSearch container
    func insert(into context: NSManagedObjectContext) {
        let favoritePhoto = NSEntityDescription.insertNewObject(forEntityName: "Identity", into: context)
        favoritePhoto.setValue(self, forKey: "idString")
    }
    
    //@REQUIRE: context is part of the SeatGeekSearch container
    func managedObject(from context: NSManagedObjectContext) -> NSManagedObject? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Identity")
        request.predicate = NSPredicate(format: "idString = %@", self)
        guard let result = try? context.fetch(request).first as? NSManagedObject else { return nil }
        return result
    }
    
}

private extension NSManagedObject {
    
    //@REQUIRE: NSManagedObject is part of the SeatGeekSearch container
    func id() -> String? {
        return value(forKey: "idString") as? ID
    }
    
}

//TODO: handle all core data operations in a queue
class SeatGeekDataStore: IdDataStore {
    
    private let persistentContainer: NSPersistentContainer
    private(set) var ids:Set<ID> = Set<ID>()
    
    // MARK: initialization
    
    init() {
        persistentContainer = NSPersistentContainer(name: "SeatGeekSearch")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription , error) in
            if error != nil {
                fatalError("Store would not load")
            }
        })
        fetchIdentities()
    }
    
    func fetchIdentities() {
        let objectContext:NSManagedObjectContext = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Identity")
        do {
            let results = try objectContext.fetch(request) as! [NSManagedObject]
            ids = Set(results.compactMap { $0.id() })
        } catch {
            fatalError("Favorite Results failed to load or failed to convert to Photo object")
        }
    }
    
    // MARK: protocol main methods
    
    func add(identity: Identifiable) {
        guard !ids.contains(identity.id) else { return }
        identity.id.insert(into: persistentContainer.viewContext)
        if persistentContainer.viewContext.hasChanges {
            try? persistentContainer.viewContext.save() //TODO: proper failure handling
        }
        ids.insert(identity.id)
    }
    
    func remove(identity: Identifiable) {
        guard ids.contains(identity.id) else { return }
        guard let object = identity.id.managedObject(from: persistentContainer.viewContext) else { return }
        persistentContainer.viewContext.delete(object)
        if persistentContainer.viewContext.hasChanges {
            try? persistentContainer.viewContext.save() //TODO: proper failure handling
        }
        ids.remove(identity.id)
    }
    
    func contains(identity: Identifiable) -> Bool {
        return ids.contains(identity.id)
    }
    
}



