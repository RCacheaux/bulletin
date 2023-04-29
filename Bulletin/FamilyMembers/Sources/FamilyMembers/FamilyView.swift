//
//  FamilyView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI

public struct FamilyView: View {
    @ObservedObject var model: FamilyMembersModel
    @State private var showingNewFamilyMemberSheet = false
    
    public init(showingNewFamilyMemberSheet: Bool = false) {
        self.model = theModel
        self.showingNewFamilyMemberSheet = showingNewFamilyMemberSheet
    }
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach(model.getAllFamilyMembers()) { familyMember in
                    Text(familyMember.name)
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
        var body: some View {
            FamilyView()
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
