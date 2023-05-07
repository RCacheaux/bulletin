//
//  File.swift
//  Chores
//
//  Created by Rene Cacheaux on 4/29/23.
//

import CoreData
import FamilyMembers
import IdentifiedCollections

class ChoresCoreDataStore {
    let container: NSPersistentContainer
    
    public init(inMemory: Bool = false) {
        let choresModel = ChoresCoreDataModel.makeModel()
        
        container = NSPersistentContainer(name: "ChoresModel", managedObjectModel: choresModel)
        
        if inMemory {
            let persistentStoreDescription = NSPersistentStoreDescription()
            persistentStoreDescription.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [persistentStoreDescription]
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func persist(_ chore: Chore) {
        let moc = container.viewContext
        
        let choreFetch = NSFetchRequest<ChoreMO>(entityName: "Chore")
        choreFetch.predicate = NSPredicate(format: "id == %i", chore.id)
        do {
            let result = try moc.fetch(choreFetch)
            if result.count > 0 {
                let managedObject = result[0]
                managedObject.name = chore.name
                managedObject.assigneeId = NSNumber(integerLiteral: chore.assigneeId!)
                try? moc.save()
                return
            }
        } catch {
            fatalError("Failed to fetch family members: \(error)")
        }
        
        // Otherwise, this is a new Chore
        let choreMO = ChoreMO(context: moc)

        choreMO.id = NSNumber(integerLiteral: chore.id)
        choreMO.name = chore.name
        choreMO.assigneeId = chore.assigneeId.map { id in
            return NSNumber(integerLiteral: chore.id)
        }
        
        try? moc.save()
    }
    
    func getAllChores() -> [Chore] {
        let moc = container.viewContext
        let choresFetch = NSFetchRequest<ChoreMO>(entityName: "Chore")
        
        do {
            let chores = try moc.fetch(choresFetch)
            return chores.map(toChore)
        } catch {
            fatalError("Failed to fetch family members: \(error)")
        }
    }
    
    func getAllFamilyMembers() -> IdentifiedArrayOf<FamilyMember> {
        //return IdentifiedArray(uniqueElements: FamilyMembers.getAllFamilyMembers())
        return IdentifiedArray(uniqueElements: [])
    }
    
    func assigneeFor(_ chore: Chore) -> FamilyMember? {
        if let assigneeId = chore.assigneeId {
            //TODO: Avoid calling for all family members.
            let familyMembers = getAllFamilyMembers()
            let assignee = familyMembers[id: assigneeId]
            return assignee
        } else {
            return nil
        }
    }
    
    func delete() {
        do {
            try container.persistentStoreCoordinator.destroyPersistentStore(at: container.persistentStoreDescriptions.first!.url!, type: .sqlite, options: nil)
        } catch {
            fatalError("Failed to destroy Core Data persistent store.")
        }
    }
}
