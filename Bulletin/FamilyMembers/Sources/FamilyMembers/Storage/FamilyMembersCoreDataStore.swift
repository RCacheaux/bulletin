//
//  File.swift
//  FamilyMembers
//
//  Created by Rene Cacheaux on 4/29/23.
//

import CoreData

internal let familyMembersCoreDataStore = FamilyMembersCoreDataStore()

class FamilyMembersCoreDataStore {
    let container: NSPersistentContainer
    
    public init(inMemory: Bool = false) {
        let model = FamilyMembersCoreDatamodel.makeModel()
        
        container = NSPersistentContainer(name: "FamilyMembersModel", managedObjectModel: model)
        
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
    
    func getAllFamilyMembers() -> [FamilyMember] {
        let moc = container.viewContext
        let familyMembersFetch = NSFetchRequest<FamilyMemberMO>(entityName: "FamilyMember")
        
        do {
            let familyMembers = try moc.fetch(familyMembersFetch)
            return familyMembers.map(toFamilyMember)
        } catch {
            fatalError("Failed to fetch family members: \(error)")
        }
    }
    
    func getFirstFamilyMember() -> FamilyMember? {
        let moc = container.viewContext
        let familyMembersFetch = NSFetchRequest<FamilyMemberMO>(entityName: "FamilyMember")
        familyMembersFetch.fetchLimit = 1
        
        do {
            if let managedObject = try moc.fetch(familyMembersFetch).first {
                return toFamilyMember(managedObject: managedObject)
            } else {
                return nil
            }
        } catch {
            fatalError("Failed to fetch family member: \(error)")
        }
    }
    
    func persist(_ familyMember: FamilyMember) {
        let moc = container.viewContext
        
        let fetch = NSFetchRequest<FamilyMemberMO>(entityName: "FamilyMember")
        fetch.predicate = NSPredicate(format: "id == %i", familyMember.id)
        do {
            let result = try moc.fetch(fetch)
            if result.count > 0 {
                let managedObject = result[0]
                managedObject.name = familyMember.name
                try? moc.save()
                return
            }
        } catch {
            fatalError("Failed to fetch family members: \(error)")
        }
        
        
        let managedObject = FamilyMemberMO(context: moc)
        managedObject.id = NSNumber(integerLiteral: familyMember.id)
        managedObject.name = familyMember.name
        try? moc.save()
    }
    
    func delete() {
        do {
            try container.persistentStoreCoordinator.destroyPersistentStore(at: container.persistentStoreDescriptions.first!.url!, type: .sqlite, options: nil)
        } catch {
            fatalError("Failed to destroy Core Data persistent store.")
        }
    }
}
