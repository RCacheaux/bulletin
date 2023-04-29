//
//  ChoreRowView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import SwiftUI
import FamilyMembers

struct ChoreRowView: View {
    let chore: Chore
    let assignee: FamilyMember?
    
    var body: some View {
        HStack {
            Text(chore.name)
            Spacer()
            Text(assignee?.name ?? "")
        }
        .padding([.leading, .trailing])
    }
}

struct ChoreRowView_Previews: PreviewProvider {
    static var previews: some View {
        let assignee = FamilyMember.preview()
        ChoreRowView(chore: Chore.preview(assigneeId: assignee.id),
                     assignee: assignee)
    }
}
