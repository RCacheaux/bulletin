//
//  NewChoreView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/2/23.
//

import SwiftUI

struct NewChoreView: View {
    @ObservedObject var model: ChoresModel
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
            .navigationTitle("New Chore")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add"){
                        let newChore = Chore(id: 1,
                                             name: name,
                                             assigneeId: nil)
                        //model.chores.append(newChore)
                        model.persist(newChore)
                        dismiss()
                    }
                }
            }
        }
        
        
    }
}

struct NewChoreView_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject private var model = ChoresModel()

        var body: some View {
            NewChoreView(model: model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
