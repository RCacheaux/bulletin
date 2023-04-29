//
//  ChoresListView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import SwiftUI
import FamilyMembers
import IdentifiedCollections

struct ChoresListView: View {
    @ObservedObject var model: ChoresModel
    var chores: [Chore]
    var familyMembers: IdentifiedArrayOf<FamilyMember>
    
    var body: some View {
        List {
            ForEach(chores) { chore in
                NavigationLink {
                    ChoreView(model: model,
                              chore: chore,
                              familyMembers: familyMembers.elements
                    )
                } label: {
                    ChoreRowView(chore: chore,
                                 assignee: model.assigneeFor(chore))
                }
            }
        }
    }
}

struct ChoresListView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = ChoresModel()

        var body: some View {
            ChoresListView(model: model,
                           chores: Chore.previewList(),
                           familyMembers: IdentifiedArray(uniqueElements: FamilyMember.previewFamilyMembers()))
        }
    }
    
    static var previews: some View {
        NavigationStack {
            Preview()
        }
    }
}
