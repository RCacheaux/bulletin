//
//  FamilyView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI

struct FamilyView: View {
    @State private var showingNewFamilyMemberSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                Text("Mum")
                Text("Dad")
                Text("Bingo")
                Text("Bluey")
            }
            .navigationTitle("Family")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingNewFamilyMemberSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingNewFamilyMemberSheet) {
            NewFamilyMemberView()
        }
    }
}

struct FamilyView_Previews: PreviewProvider {
    static var previews: some View {
        FamilyView()
    }
}
