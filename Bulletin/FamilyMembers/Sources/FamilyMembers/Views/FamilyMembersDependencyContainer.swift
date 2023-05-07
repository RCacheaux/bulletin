//
//  File.swift
//  FamilyMembers
//
//  Created by Rene Cacheaux on 5/6/23.
//

import Foundation
import SwiftUI

@MainActor
public class FamilyMembersDependencyContainer {
    private let state = FamilyMembersState()
    private let remoteAPI = FamilyMembersRemoteAPI()
    private let coreDataStore = FamilyMembersCoreDataStore()
    
    public init() {}
    
    public func loadState() async -> FamilyMembersState {
        let useCase = ViewFamilyMemberUseCase(remoteAPI: remoteAPI,
                                              coreDataStore: coreDataStore,
                                              state: state)
        await useCase.run()
        return state
    }
    
    public func newFamilyMemberView() -> AnyView {
        let view = _NewFamilyMemberView(CreateFamilyMemberUseCase: makeCreateUseCase)
        return AnyView(view)
    }
    
    private func makeCreateUseCase(newFamilyMember: FamilyMember) -> CreateNewFamilyMemberUseCase {
        return CreateNewFamilyMemberUseCase(newFamilyMember: newFamilyMember,
                                            state: state,
                                            dataStore: coreDataStore)
    }

    private func makeViewUseCase() -> ViewFamilyMemberUseCase {
        return ViewFamilyMemberUseCase(remoteAPI: remoteAPI,
                                       coreDataStore: coreDataStore,
                                       state: state)
    }

    public func familyView() -> some View {
        return _FamilyView(familyMembersState: state,
                           ViewFamilyMembersUseCase: makeViewUseCase,
                           NewFamilyMemberView: newFamilyMemberView)
    }
}
