//
//  ContentView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import SwiftUI
import Chores
import Meals

struct ContentView: View {
    @ObservedObject var model: ChoresModel
    
    var body: some View {
        TabView {
            ChoresTabView(model: model)
                .tabItem {
                    Label("Chores", systemImage: "list.bullet.clipboard")   
                }
            MealsTabView()
                .tabItem {
                    Label("Meals", systemImage: "takeoutbag.and.cup.and.straw")
                }
            SettingsTabView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            LoginView()
                .tabItem {
                    Label("Log In", systemImage: "key")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = ChoresModel()
        var body: some View {
            ContentView(model: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
