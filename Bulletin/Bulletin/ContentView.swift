//
//  ContentView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: BulletinModel
    @State private var showingNewChoreSheet = false
    @State private var showingSettingsSheet = false
    
    var body: some View {
        NavigationStack {
            ChoresListView(model: model)
                .navigationTitle("Chores")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingSettingsSheet.toggle()
                        }) {
                            Image(systemName: "gearshape")
                        }
                    }
                    ToolbarItemGroup(placement: .bottomBar) {
                        Spacer()
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
            SettingsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = BulletinModel()
        var body: some View {
            ContentView(model: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
