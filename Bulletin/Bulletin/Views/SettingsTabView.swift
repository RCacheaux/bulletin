//
//  SettingsView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI
import FamilyMembers

@MainActor
struct SettingsTabView: View {
    let dc: FamilyMembersDependencyContainer
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Family") {
                    FamilyView()
                }
            }
            .navigationTitle("Settings")
        }
    }

    func FamilyView() -> some View {
        return dc.familyView()
    }
}

struct SettingsView_Previews: PreviewProvider {
    struct Preview: View {
        var body: some View {
            SettingsTabView(dc: FamilyMembersDependencyContainer())
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
