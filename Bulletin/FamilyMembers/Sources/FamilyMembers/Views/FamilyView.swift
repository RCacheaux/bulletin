//
//  FamilyView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI

public struct _FamilyView: View {
    @ObservedObject var familyMembersState: FamilyMembersState
    @State private var showingNewFamilyMemberSheet = false
    let NewFamilyMemberView: () -> AnyView
    
    init(familyMembersState: FamilyMembersState,
         showingNewFamilyMemberSheet: Bool = false,
         ViewFamilyMembersUseCase: @escaping () -> ViewFamilyMemberUseCase,
         NewFamilyMemberView: @escaping () -> AnyView) {
        self.familyMembersState = familyMembersState
        self.showingNewFamilyMemberSheet = showingNewFamilyMemberSheet
        self.NewFamilyMemberView = NewFamilyMemberView
        
        Task {
            await ViewFamilyMembersUseCase().run()
        }
    }
    
    public var body: some View {
        NavigationStack {
            List {
                // This view wants to make sure family members state is synced with what is in storage
                // Perhaps this calls for synchronous 'view' family member use case
                ForEach(familyMembersState.familyMembers) { familyMember in
                    Text(familyMember.name)
                }
            }
            .navigationTitle("Family")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingNewFamilyMemberSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingNewFamilyMemberSheet) {
            NewFamilyMemberView()
        }
    }
}

struct FamilyView_Previews: PreviewProvider {
    struct Preview: View {
        let dc: FamilyMembersDependencyContainer
        
        @MainActor
        init() {
            self.dc = FamilyMembersDependencyContainer()
        }
        
        var body: some View {
            dc.familyView()
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
