//
//  NoIssueView.swift
//  FeedbackHub
//
//  Created by Oliwier Kasprzak on 09/05/2023.
//

import SwiftUI

struct NoIssueView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        Text("No Issue Selected")
            .font(.title)
            .foregroundColor(.secondary)
        
        Button("New Issue") {
            
        }
    }
}

struct NoIssueView_Previews: PreviewProvider {
    static var previews: some View {
        NoIssueView()
    }
}
