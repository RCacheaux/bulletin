//
//  File.swift
//  FamilyMembers
//
//  Created by Rene Cacheaux on 5/5/23.
//

import Foundation

class ViewFamilyMemberUseCase {
    let remoteAPI: FamilyMembersRemoteAPI
    let coreDataStore: FamilyMembersCoreDataStore
    let state: FamilyMembersState
    
    init(remoteAPI: FamilyMembersRemoteAPI, coreDataStore: FamilyMembersCoreDataStore, state: FamilyMembersState) {
        self.remoteAPI = remoteAPI
        self.coreDataStore = coreDataStore
        self.state = state
    }

    func run() async {
        do {
            let familyMembers = try await remoteAPI.getFamilyMembers()
            await MainActor.run {
                familyMembers.forEach(coreDataStore.persist)
                state.familyMembers = coreDataStore.getAllFamilyMembers()
            }
        } catch {
            fatalError("Error fetching family members from remote API.")
        }
    }
}
