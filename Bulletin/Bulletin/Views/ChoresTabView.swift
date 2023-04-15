//
//  ChoresTabView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/15/23.
//

import SwiftUI

struct ChoresTabView: View {
    @ObservedObject var model: BulletinModel
    @State private var showingNewChoreSheet = false
    @State private var showingSettingsSheet = false
    
    var body: some View {
        NavigationStack {
            ChoresListView(model: model)
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
        .sheet(isPresented: $showingSettingsSheet) {
            SettingsTabView(model: model)
        }
    }
}

struct ChoresTabView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = BulletinModel()
        var body: some View {
            ChoresTabView(model: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
