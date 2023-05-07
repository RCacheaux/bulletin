//
//  AppState.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 5/6/23.
//

import Foundation
import FamilyMembers

enum LoadingState {
    case loading
    case loaded(FamilyMembersState)
}

@MainActor
class AppState: ObservableObject {
    @Published var loadingState: LoadingState = .loading
    let dc = FamilyMembersDependencyContainer()
    
    init() {
        Task {
            let familyState = await dc.loadState()
            self.loadingState = .loaded(familyState)
        }
    }
}
