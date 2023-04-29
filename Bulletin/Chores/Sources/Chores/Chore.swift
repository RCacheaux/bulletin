//
//  Chore.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import Foundation
import FamilyMembers

struct Chore: Identifiable {
    let id: UUID
    let name: String
    let assigneeId: UUID?
}

extension Chore {
    static func preview(assigneeId: UUID) -> Chore {
        let id = UUID()
        let name = "Preview Chore"
        let assigneeId = assigneeId
        return Chore(id: id, name: name, assigneeId: assigneeId)
    }
    
    static func previewList() -> [Chore] {
        let familyMembers = FamilyMember.previewFamilyMembers()
        return [
            Chore(id: UUID(), name: "Trash", assigneeId: familyMembers.randomElement()!.id),
            Chore(id: UUID(), name: "Dishes", assigneeId: familyMembers.randomElement()!.id),
            Chore(id: UUID(), name: "School Pickup", assigneeId: familyMembers.randomElement()!.id)
        ]
    }
}
