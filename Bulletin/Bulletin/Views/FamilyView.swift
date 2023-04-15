//
//  FamilyView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI

struct FamilyView: View {
    @ObservedObject var model: BulletinModel
    @State private var showingNewFamilyMemberSheet = false
    @FetchRequest(sortDescriptors: []) var cdFamilyMembers: FetchedResults<CDFamilyMember>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(cdFamilyMembers) { cdFamilyMember in
                    Text(cdFamilyMember.name!)
                }
            }
            .navigationTitle("Family")
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
            NewFamilyMemberView(model: model)
        }
    }
}

struct FamilyView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = BulletinModel()
        var body: some View {
            FamilyView(model: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
