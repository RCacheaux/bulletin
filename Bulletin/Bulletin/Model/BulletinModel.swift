//
//  BulletinModel.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/2/23.
//

import SwiftUI
import CoreData
import Chores

class BulletinModel: ObservableObject {
    let container = NSPersistentContainer(name: "BulletinModel")
    @StateObject var choresModel = ChoresModel()
    //@Published var chores: [Chore] = []
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteCoreData() {
        do {
            try container.persistentStoreCoordinator.destroyPersistentStore(at: container.persistentStoreDescriptions.first!.url!, type: .sqlite, options: nil)
        } catch {
            fatalError("Failed to destroy Core Data persistent store.")
        }
    }
}
