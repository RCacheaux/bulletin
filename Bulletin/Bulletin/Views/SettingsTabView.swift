//
//  SettingsView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI

struct SettingsTabView: View {
    @ObservedObject var model: BulletinModel
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Family") {
                    FamilyView(model: model)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = BulletinModel()
        var body: some View {
            SettingsTabView(model: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
