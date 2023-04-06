//
//  SettingsView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
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
    static var previews: some View {
        SettingsView()
    }
}
