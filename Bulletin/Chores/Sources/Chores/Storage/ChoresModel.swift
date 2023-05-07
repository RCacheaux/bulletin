//
//  ChoresModel.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/28/23.
//

import Foundation
import CoreData
import FamilyMembers
import IdentifiedCollections

@MainActor
public class ChoresModel: ObservableObject {
    let coreDataStore = ChoresCoreDataStore()
    @Published var chores: [Chore] = []
    
    public init() {
        self.chores = getAllChores()
    }
    
    func persist(_ chore: Chore) {
        coreDataStore.persist(chore)
        self.chores = getAllChores()
    }
    
    func getAllChores() -> [Chore] {
        return coreDataStore.getAllChores()
    }
    
    func getAllFamilyMembers() -> IdentifiedArrayOf<FamilyMember> {
        //return IdentifiedArray(uniqueElements: FamilyMembers.getAllFamilyMembers())
        return IdentifiedArray(uniqueElements: [])
    }
    
    func assigneeFor(_ chore: Chore) -> FamilyMember? {
        if let assigneeId = chore.assigneeId {
            //TODO: Avoid calling for all family members.
            let familyMembers = getAllFamilyMembers()
            let assignee = familyMembers[id: assigneeId]
            return assignee
        } else {
            return nil
        }
    }
}
