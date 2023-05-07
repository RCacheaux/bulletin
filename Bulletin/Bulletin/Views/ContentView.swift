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
    @StateObject var appState: AppState = AppState()
    
    var body: some View {
        switch appState.loadingState {
        case .loading:
            Text("Loading...")
            
        case .loaded:
            TabView {
//                ChoresTabView(model: model)
//                    .tabItem {
//                        Label("Chores", systemImage: "list.bullet.clipboard")
//                    }
                MealsTabView()
                    .tabItem {
                        Label("Meals", systemImage: "takeoutbag.and.cup.and.straw")
                    }
                SettingsTabView(dc: appState.dc)
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
}

struct ContentView_Previews: PreviewProvider {
    struct Preview: View {
        var body: some View {
            ContentView()
        }
    }
    
    static var previews: some View {
        Preview()
        
    }
}
