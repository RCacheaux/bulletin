//
//  File.swift
//  FamilyMembers
//
//  Created by Rene Cacheaux on 4/28/23.
//

import Foundation
import CoreData

public struct FamilyMember {
    let id: UUID
    let name: String
}

@objc(FamilyMemberMO)
class FamilyMemberMO: NSManagedObject {
    @NSManaged var id: UUID?
    @NSManaged var name: String?
}

func toFamilyMember(managedObject: FamilyMemberMO) -> FamilyMember {
    return FamilyMember(id: managedObject.id!, name: managedObject.name!)
}



public class FamilyMembersModel: ObservableObject {
    let container: NSPersistentContainer
    
    public init() {
        let familyMemberEntity = NSEntityDescription()
        familyMemberEntity.name = "FamilyMember"
        familyMemberEntity.managedObjectClassName = "FamilyMemberMO"
        familyMemberEntity.uniquenessConstraints = [["id"]]
        
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.type = .uuid
        familyMemberEntity.properties.append(idAttribute)
        
        let nameAttribute = NSAttributeDescription()
        nameAttribute.name = "name"
        nameAttribute.type = .string
        familyMemberEntity.properties.append(nameAttribute)
        
        let model = NSManagedObjectModel()
        model.entities = [familyMemberEntity]
        
        container = NSPersistentContainer(name: "FamilyMembersModel", managedObjectModel: model)
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    public func allFamilyMembers() -> [FamilyMember] {
        let moc = container.viewContext
        let familyMembersFetch = NSFetchRequest<FamilyMemberMO>(entityName: "FamilyMember")
        
        do {
            let familyMembers = try moc.fetch(familyMembersFetch)
            return familyMembers.map(toFamilyMember)
        } catch {
            fatalError("Failed to fetch family members: \(error)")
        }
        
    }
}
