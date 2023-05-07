//
//  File.swift
//  FamilyMembers
//
//  Created by Rene Cacheaux on 4/29/23.
//

import Foundation

public struct FamilyMember: Identifiable, Hashable, Decodable {
    public let id: Int
    public let name: String
    
    public static func preview() -> FamilyMember {
        return FamilyMember(id: 1, name: "Bluey")
    }
    
    public static func previewFamilyMembers() -> [FamilyMember] {
        return [
            FamilyMember(id: 1, name: "Mum"),
            FamilyMember(id: 2, name: "Dad"),
            FamilyMember(id: 3, name: "Bingo"),
            FamilyMember(id: 4, name: "Bluey")
        ]
    }
}
