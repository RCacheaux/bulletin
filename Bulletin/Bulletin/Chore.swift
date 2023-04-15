//
//  Chore.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import Foundation

struct Chore: Identifiable {
    let id: URL
    let name: String
    let assignedTo: FamilyMember?
}

extension Chore {
    static func preview() -> Chore {
        let id = URL(string: "coredata://app.bulletin/chore/preview")!
        let name = "Preview Chore"
        let assignedTo = FamilyMember.preview()
        return Chore(id: id, name: name, assignedTo: assignedTo)
    }
}
