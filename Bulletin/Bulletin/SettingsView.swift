//
//  SettingsView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var model: BulletinModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Family") {
                    FamilyView(model: model)
                }
            }
            Text("")
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done"){
                            dismiss()
                        }
                    }
                }
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = BulletinModel()
        var body: some View {
            SettingsView(model: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
