//
//  File.swift
//  FamilyMembers
//
//  Created by Rene Cacheaux on 4/29/23.
//

import Foundation

@MainActor
class CreateNewFamilyMemberUseCase {
    let newFamilyMember: FamilyMember
    let state: FamilyMembersState
    let dataStore: FamilyMembersCoreDataStore
    
    init(newFamilyMember: FamilyMember,
         state: FamilyMembersState,
         dataStore: FamilyMembersCoreDataStore) {
        self.newFamilyMember = newFamilyMember
        self.state = state
        self.dataStore = dataStore
    }
    
    func run() {
        dataStore.persist(newFamilyMember)
        state.familyMembers = dataStore.getAllFamilyMembers()
    }
}
