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
    //@Published var chores: [Chore] = []
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func persist(newChore: Chore) {
        let moc = container.viewContext
        let cdchore = CDChore(context: moc)
        
        cdchore.name = newChore.name
        cdchore.asignee = fetchFirstFamilyMember()
        
        try? moc.save()
    }
    
    func persist(chore: Chore) {
        let moc = container.viewContext
        
        let assignedToId = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: chore.assignedTo!.id)!
        let assignedToMO = moc.object(with: assignedToId) as! CDFamilyMember
        
        let choreId = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: chore.id)!
        let choreMO = moc.object(with: choreId) as! CDChore
        
        choreMO.asignee = assignedToMO
        
        try? moc.save()
    }
    
    func fetchFirstFamilyMember() -> CDFamilyMember {
        let moc = container.viewContext
        let familyMembersFetch = NSFetchRequest<CDFamilyMember>(entityName: "CDFamilyMember")
        familyMembersFetch.fetchLimit = 1
        
        do {
            if let familyMember = try moc.fetch(familyMembersFetch).first {
                return familyMember
            } else {
                fatalError("Failed to fetch family member, no family members in database.")
            }
            
        } catch {
            fatalError("Failed to fetch family member: \(error)")
        }
    }
    
    func persist(familyMember: FamilyMember) {
        let moc = container.viewContext
        let cdFamilyMember = CDFamilyMember(context: moc)
        cdFamilyMember.name = familyMember.name
        try? moc.save()
    }
    
    func deleteCoreData() {
        do {
            try container.persistentStoreCoordinator.destroyPersistentStore(at: container.persistentStoreDescriptions.first!.url!, type: .sqlite, options: nil)
        } catch {
            fatalError("Failed to destroy Core Data persistent store.")
        }
    }
}
