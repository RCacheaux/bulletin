//
//  File.swift
//  FamilyMembers
//
//  Created by Rene Cacheaux on 4/28/23.
//

import Foundation
import CoreData

internal let theModel = FamilyMembersModel()

public func getAllFamilyMembers() -> [FamilyMember] {
    return theModel.getAllFamilyMembers()
}

public struct FamilyMember: Identifiable, Hashable {
    public let id: UUID
    public let name: String
    
    public static func preview() -> FamilyMember {
        return FamilyMember(id: UUID(), name: "Bluey")
    }
    
    public static func previewFamilyMembers() -> [FamilyMember] {
        return [
            FamilyMember(id: UUID(), name: "Mum"),
            FamilyMember(id: UUID(), name: "Dad"),
            FamilyMember(id: UUID(), name: "Bingo"),
            FamilyMember(id: UUID(), name: "Bluey")
        ]
    }
}

@objc(FamilyMemberMO)
class FamilyMemberMO: NSManagedObject {
    @NSManaged var id: UUID?
    @NSManaged var name: String?
}

func toFamilyMember(managedObject: FamilyMemberMO) -> FamilyMember {
    return FamilyMember(id: managedObject.id!, name: managedObject.name!)
}



class FamilyMembersModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var familyMembers: [FamilyMember] = []
    
    init() {
        let familyMemberEntity = NSEntityDescription()
        familyMemberEntity.name = "FamilyMember"
        familyMemberEntity.managedObjectClassName = "FamilyMemberMO"
        
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.type = .uuid
        familyMemberEntity.properties.append(idAttribute)
        familyMemberEntity.uniquenessConstraints = [["id"]]
        
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
        
        self.familyMembers = getAllFamilyMembers()
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
    
    func persist(familyMember: FamilyMember) {
        let moc = container.viewContext
        let managedObject = FamilyMemberMO(context: moc)
        managedObject.id = familyMember.id
        managedObject.name = familyMember.name
        try? moc.save()
        
        self.familyMembers = getAllFamilyMembers()
    }
}
