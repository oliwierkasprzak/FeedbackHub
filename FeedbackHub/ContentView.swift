//
//  ContentView.swift
//  FeedbackHub
//
//  Created by Oliwier Kasprzak on 25/04/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        List(selection: $dataController.selectedIssue) {
            ForEach(dataController.issuesForSelectedFilter()) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Issues")
        .searchable(text: $dataController.filterText, tokens: $dataController.filterTokens, suggestedTokens: .constant(dataController.suggestedFilterTokens), prompt: "Filter issues, or type # to add tags") { tag in
            Text(tag.tagName)
        }
    }
    
    func delete(_ offsets: IndexSet) {
        let issues = dataController.issuesForSelectedFilter()
        for offset in offsets {
            let item = issues[offset]
            dataController.deleteObject(item)
        }
    }
} 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
