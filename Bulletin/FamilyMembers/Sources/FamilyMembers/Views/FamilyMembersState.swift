//
//  File.swift
//  FamilyMembers
//
//  Created by Rene Cacheaux on 4/29/23.
//

import Foundation

@MainActor
public class FamilyMembersState: ObservableObject {
    @Published public internal(set) var familyMembers: [FamilyMember] = []
    @Published public internal(set) var loaded = false
}
