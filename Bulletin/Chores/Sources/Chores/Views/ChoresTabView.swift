//
//  ChoresTabView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/15/23.
//

import SwiftUI
import FamilyMembers

public struct ChoresTabView: View {
    @ObservedObject var model: ChoresModel
    @State private var showingNewChoreSheet = false
    
    public init(model: ChoresModel, showingNewChoreSheet: Bool = false) {
        self.model = model
        self.showingNewChoreSheet = showingNewChoreSheet
    }
    
    public var body: some View {
        NavigationStack {
            ChoresListView(model: model,
                           chores: model.getAllChores(),
                           familyMembers: model.getAllFamilyMembers())
                .navigationTitle("Chores")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingNewChoreSheet.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
        .sheet(isPresented: $showingNewChoreSheet) {
            NewChoreView(model: model)
        }
    }
}

struct ChoresTabView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = ChoresModel()
        var body: some View {
            ChoresTabView(model: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
