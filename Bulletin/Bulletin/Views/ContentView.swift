//
//  ContentView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: BulletinModel
    
    var body: some View {
        TabView {
            ChoresTabView(model: model)
                .tabItem {
                    Label("Chores", systemImage: "list.bullet.clipboard")   
                }
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