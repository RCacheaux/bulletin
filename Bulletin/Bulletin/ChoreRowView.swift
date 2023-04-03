//
//  ChoreRowView.swift
//  Bulletin
//
//  Created by Rene Cacheaux on 4/1/23.
//

import SwiftUI

struct ChoreRowView: View {
    let chore: Chore
    
    var body: some View {
        HStack {
            Text(chore.name)
            Spacer()
        }
        .padding()
    }
}

struct ChoreRowView_Previews: PreviewProvider {
    static var previews: some View {
        ChoreRowView(chore: Chore(name: "Trash"))
    }
}
