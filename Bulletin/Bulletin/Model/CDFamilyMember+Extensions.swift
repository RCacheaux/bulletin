//
//  CDFamilyMember+Extensions.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/15/23.
//

import Foundation

extension CDFamilyMember {
    var familyMember: FamilyMember {
        let id = self.objectID.uriRepresentation()
        let name = self.name!
        return FamilyMember(id: id, name: name)
    }
}
