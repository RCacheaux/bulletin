//
//  FamilyMember.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/8/23.
//

import Foundation

struct FamilyMember: Identifiable, Hashable {
    let id: URL
    let name: String
}

extension FamilyMember {
    static func preview() -> FamilyMember {
        let id = URL(string: "coredata://app.bulletin/familyMember/preview")!
        let name = "Preview Family Member"
        return FamilyMember(id: id, name: name)
    }
}
