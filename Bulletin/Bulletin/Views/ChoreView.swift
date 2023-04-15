//
//  ChoreView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI

struct ChoreView: View {
    @ObservedObject var model: BulletinModel
    @State private var chore: Chore
    @State private var name: String
    @State private var assignedTo: FamilyMember
    @FetchRequest var cdFamilyMembers: FetchedResults<CDFamilyMember>
    
    var familyMembers: [FamilyMember] {
        return cdFamilyMembers.map { familyMember in
            let memberID = familyMember.objectID.uriRepresentation()
            return FamilyMember(id: memberID, name: familyMember.name!)
        }
    }
    
    init(model: BulletinModel, chore: Chore) {
        _cdFamilyMembers = FetchRequest<CDFamilyMember>(sortDescriptors: [])
        _chore = State(initialValue: chore)
        _name = State(initialValue: chore.name)
        _assignedTo = State(initialValue: chore.assignedTo!)
        self.model = model
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(
                        "Name",
                        text: $name
                    )
                }
                Section {
                    Picker("Assign To", selection: $assignedTo) {
                        ForEach(familyMembers) { member in
                            Text(member.name).tag(member)
                        }
                    }.onChange(of: assignedTo) { familyMember in
                        let chore = Chore(id: chore.id, name: chore.name, assignedTo: familyMember)
                        model.persist(chore: chore)
                    }
                }
            }
            //.navigationTitle("New Chore")
            //.navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChoreView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = BulletinModel()

        var body: some View {
            ChoreView(model: model,
                      chore: Chore.preview())
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
