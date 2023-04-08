//
//  NewFamilyMemberView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI

struct NewFamilyMemberView: View {
    @ObservedObject var model: BulletinModel
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    
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
                        let newFamilyMember = FamilyMember(name: name)
                        model.persist(familyMember: newFamilyMember)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct NewFamilyMemberView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = BulletinModel()
        var body: some View {
            NewFamilyMemberView(model: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
