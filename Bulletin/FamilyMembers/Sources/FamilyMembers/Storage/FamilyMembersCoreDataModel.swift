//
//  File.swift
//  FamilyMembers
//
//  Created by Rene Cacheaux on 4/29/23.
//

import CoreData

class FamilyMembersCoreDatamodel {
    static func makeModel() -> NSManagedObjectModel {
        let familyMemberEntity = NSEntityDescription()
        familyMemberEntity.name = "FamilyMember"
        familyMemberEntity.managedObjectClassName = "FamilyMemberMO"
        
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.type = .integer64
        familyMemberEntity.properties.append(idAttribute)
        familyMemberEntity.uniquenessConstraints = [["id"]]
        
        let nameAttribute = NSAttributeDescription()
        nameAttribute.name = "name"
        nameAttribute.type = .string
        familyMemberEntity.properties.append(nameAttribute)
        
        let model = NSManagedObjectModel()
        model.entities = [familyMemberEntity]
        
        return model
    }
}

@objc(FamilyMemberMO)
class FamilyMemberMO: NSManagedObject {
    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
}

func toFamilyMember(managedObject: FamilyMemberMO) -> FamilyMember {
    return FamilyMember(id: managedObject.id!.intValue, name: managedObject.name!)
}
