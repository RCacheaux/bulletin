//
//  Chore.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import Foundation
import FamilyMembers

struct Chore: Identifiable {
    let id: Int
    let name: String
    let assigneeId: Int?
}

extension Chore {
    static func preview(assigneeId: Int) -> Chore {
        let id = 1
        let name = "Preview Chore"
        let assigneeId = assigneeId
        return Chore(id: id, name: name, assigneeId: assigneeId)
    }
    
    static func previewList() -> [Chore] {
        let familyMembers = FamilyMember.previewFamilyMembers()
        return [
            Chore(id: 1, name: "Trash", assigneeId: familyMembers.randomElement()!.id),
            Chore(id: 2, name: "Dishes", assigneeId: familyMembers.randomElement()!.id),
            Chore(id: 3, name: "School Pickup", assigneeId: familyMembers.randomElement()!.id)
        ]
    }
}
