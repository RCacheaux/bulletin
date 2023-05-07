//
//  File.swift
//  FamilyMembers
//
//  Created by Rene Cacheaux on 5/5/23.
//

import Foundation
import BulletinRemoteAPI

class FamilyMembersRemoteAPI {
    
    func getFamilyMembers() async throws -> [FamilyMember] {
        let remoteAPI = BulletinRemoteAPI()
        let path = "familyMembers"
        
        let data = try await remoteAPI.data(for: path)
        let familyMembers = try JSONDecoder().decode([FamilyMember].self, from: data)
        return familyMembers
    }
}
