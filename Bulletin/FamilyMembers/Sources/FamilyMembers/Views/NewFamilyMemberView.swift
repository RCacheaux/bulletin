//
//  NewFamilyMemberView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI

struct _NewFamilyMemberView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    let CreateFamilyMemberUseCase: (FamilyMember) -> CreateNewFamilyMemberUseCase
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(
                        "Name",
                        text: $name
                    )
                }
            }
            .navigationTitle("New Family Member")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add"){
                        let newFamilyMember = FamilyMember(id: 1,
                                                           name: name)
                        CreateFamilyMemberUseCase(newFamilyMember).run()
                        dismiss()
                    }
                }
            }
        }
    }
}

struct NewFamilyMemberView_Previews: PreviewProvider {
    struct Preview: View {
        let dc: FamilyMembersDependencyContainer
        
        @MainActor
        init() {
            self.dc = FamilyMembersDependencyContainer()
        }
        
        var body: some View {
            dc.newFamilyMemberView()
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
