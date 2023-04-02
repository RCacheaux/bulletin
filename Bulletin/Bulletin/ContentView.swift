//
//  ContentView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: BulletinModel
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            ChoresListView(model: model)
                .navigationTitle("Chores")
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Spacer()
                        Button(action: {
                            showingSheet.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
        .sheet(isPresented: $showingSheet) {
            NewChoreView(model: model)
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
