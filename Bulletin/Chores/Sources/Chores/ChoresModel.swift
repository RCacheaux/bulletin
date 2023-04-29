//
//  ChoresModel.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/28/23.
//

import Foundation
import CoreData
import FamilyMembers
import IdentifiedCollections

@objc(ChoreMO)
class ChoreMO: NSManagedObject {
    @NSManaged var id: UUID?
    @NSManaged var name: String?
    @NSManaged var assigneeId: UUID?
}


public class ChoresModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var chores: [Chore] = []
    
    public init() {
        let choreEntity = NSEntityDescription()
        choreEntity.name = "Chore"
        choreEntity.managedObjectClassName = "ChoreMO"
        
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.type = .uuid
        choreEntity.properties.append(idAttribute)
        choreEntity.uniquenessConstraints = [["id"]]
        
        let nameAttribute = NSAttributeDescription()
        nameAttribute.name = "name"
        nameAttribute.type = .string
        choreEntity.properties.append(nameAttribute)
        
        let assigneeIdAttribute = NSAttributeDescription()
        assigneeIdAttribute.name = "assigneeId"
        assigneeIdAttribute.type = .uuid
        choreEntity.properties.append(assigneeIdAttribute)
        
        let model = NSManagedObjectModel()
        model.entities = [choreEntity]
        
        container = NSPersistentContainer(name: "ChoresModel", managedObjectModel: model)
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        self.chores = getAllChores()
    }
    
    func persist(_ chore: Chore) {
        let moc = container.viewContext
        
        let choreFetch = NSFetchRequest<ChoreMO>(entityName: "Chore")
        choreFetch.predicate = NSPredicate(format: "id == %@", chore.id as CVarArg)
        do {
            let result = try moc.fetch(choreFetch)
            if result.count > 0 {
                let managedObject = result[0]
                managedObject.name = chore.name
                managedObject.assigneeId = chore.assigneeId
                try? moc.save()
                self.chores = getAllChores()
                return
            }
        } catch {
            fatalError("Failed to fetch family members: \(error)")
        }
        
        // Otherwise, this is a new Chore
        let choreMO = ChoreMO(context: moc)

        choreMO.id = chore.id
        choreMO.name = chore.name
        choreMO.assigneeId = chore.assigneeId
        
        try? moc.save()
        
        self.chores = getAllChores()
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
        return IdentifiedArray(uniqueElements: FamilyMembers.getAllFamilyMembers())
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
//
//    func persist(chore: Chore) {
//        let moc = container.viewContext
//
//        let assignedToId = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: chore.assignedTo!.id)!
//
//        let choreId = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: chore.id)!
//        let choreMO = moc.object(with: choreId) as! CDChore
//
//        choreMO.asignee = assignedToMO
//
//        try? moc.save()
//    }
//
//    func fetchFirstFamilyMember() -> CDFamilyMember {
//        let moc = container.viewContext
//        let familyMembersFetch = NSFetchRequest<CDFamilyMember>(entityName: "CDFamilyMember")
//        familyMembersFetch.fetchLimit = 1
//
//        do {
//            if let familyMember = try moc.fetch(familyMembersFetch).first {
//                return familyMember
//            } else {
//                fatalError("Failed to fetch family member, no family members in database.")
//            }
//
//        } catch {
//            fatalError("Failed to fetch family member: \(error)")
//        }
//    }
//
//    func persist(familyMember: FamilyMember) {
//        let moc = container.viewContext
//        let cdFamilyMember = CDFamilyMember(context: moc)
//        cdFamilyMember.name = familyMember.name
//        try? moc.save()
//    }
    
    func deleteCoreData() {
        do {
            try container.persistentStoreCoordinator.destroyPersistentStore(at: container.persistentStoreDescriptions.first!.url!, type: .sqlite, options: nil)
        } catch {
            fatalError("Failed to destroy Core Data persistent store.")
        }
    }
}


func toChore(managedObject: ChoreMO) -> Chore {
    return Chore(id: managedObject.id!, name: managedObject.name!, assigneeId: managedObject.assigneeId)
}
