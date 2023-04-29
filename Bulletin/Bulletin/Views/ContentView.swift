//
//  ContentView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import SwiftUI
import Chores

struct ContentView: View {
    @ObservedObject var model: BulletinModel
    
    var body: some View {
        TabView {
            ChoresTabView(model: model.choresModel)
                .tabItem {
                    Label("Chores", systemImage: "list.bullet.clipboard")   
                }
            MealsTabView()
                .tabItem {
                    Label("Meals", systemImage: "takeoutbag.and.cup.and.straw")
                }
            SettingsTabView(model: model)
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
        @StateObject private var model = BulletinModel()
        var body: some View {
            ContentView(model: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
