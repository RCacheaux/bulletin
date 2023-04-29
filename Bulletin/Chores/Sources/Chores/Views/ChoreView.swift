//
//  ChoreView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/6/23.
//

import SwiftUI
import FamilyMembers

struct ChoreView: View {
    @ObservedObject var model: ChoresModel
    @State private var chore: Chore
    @State private var name: String
    @State private var assignee: FamilyMember?
    private var familyMembers: [FamilyMember]
    
    init(model: ChoresModel, chore: Chore, familyMembers: [FamilyMember]) {
        _chore = State(initialValue: chore)
        _name = State(initialValue: chore.name)
        _assignee = State(initialValue: model.assigneeFor(chore))
        self.model = model
        self.familyMembers = familyMembers
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
                    Picker("Assign To", selection: $assignee) {
                        Text("(Unassigned)").tag(nil as FamilyMember?)
                        ForEach(familyMembers) { member in
                            Text(member.name).tag(member as FamilyMember?)
                        }
                    }.onChange(of: assignee) { familyMember in
                        let chore = Chore(id: chore.id, name: chore.name, assigneeId: assignee?.id)
                        model.persist(chore)
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
        @StateObject private var model = ChoresModel()

        var body: some View {
            let familyMembers = FamilyMember.previewFamilyMembers()
            let assignee = familyMembers.first!
            ChoreView(model: model,
                      chore: Chore.preview(assigneeId: assignee.id),
                      familyMembers: familyMembers)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
