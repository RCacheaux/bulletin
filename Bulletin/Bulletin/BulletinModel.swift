//
//  BulletinModel.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/2/23.
//

import SwiftUI
import CoreData

class BulletinModel: ObservableObject {
    let container = NSPersistentContainer(name: "BulletinModel")
    @Published var chores: [Chore] = []
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func persist(chore: Chore) {
        let moc = container.viewContext
        let cdchore = CDChore(context: moc)
        cdchore.name = chore.name
        try? moc.save()
    }
}
