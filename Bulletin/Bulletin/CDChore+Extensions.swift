//
//  CDChore+Extensions.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/15/23.
//

import Foundation

extension CDChore {
    var chore: Chore {
        let id = self.objectID.uriRepresentation()
        let name = self.name!
        let assignedTo = self.asignee!.familyMember
        return Chore(id: id, name: name, assignedTo: assignedTo)
    }
}
