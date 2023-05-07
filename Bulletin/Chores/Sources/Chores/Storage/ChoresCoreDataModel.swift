//
//  File.swift
//  Chores
//
//  Created by Rene Cacheaux on 4/29/23.
//

import CoreData

class ChoresCoreDataModel {
    static func makeModel() -> NSManagedObjectModel {
        let choreEntity = NSEntityDescription()
        choreEntity.name = "Chore"
        choreEntity.managedObjectClassName = "ChoreMO"
        
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.type = .integer64
        choreEntity.properties.append(idAttribute)
        choreEntity.uniquenessConstraints = [["id"]]
        
        let nameAttribute = NSAttributeDescription()
        nameAttribute.name = "name"
        nameAttribute.type = .string
        choreEntity.properties.append(nameAttribute)
        
        let assigneeIdAttribute = NSAttributeDescription()
        assigneeIdAttribute.name = "assigneeId"
        assigneeIdAttribute.type = .integer64
        choreEntity.properties.append(assigneeIdAttribute)
        
        let model = NSManagedObjectModel()
        model.entities = [choreEntity]
        
        return model
    }
}

@objc(ChoreMO)
class ChoreMO: NSManagedObject {
    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var assigneeId: NSNumber?
}

func toChore(managedObject: ChoreMO) -> Chore {
    return Chore(id: managedObject.id!.intValue, name: managedObject.name!, assigneeId: managedObject.assigneeId?.intValue)
}
