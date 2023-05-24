//
//  IssueViewToolbar.swift
//  FeedbackHub
//
//  Created by Oliwier Kasprzak on 24/05/2023.
//

import SwiftUI

struct IssueViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue
    var body: some View {
        Menu {
            Button {
                UIPasteboard.general.string = issue.title
            } label: {
                Label("Copy Issue Title", systemImage: "doc.on.doc")
            }
            
            Button {
                issue.completed.toggle()
                dataController.save()
            } label: {
                Label(issue.completed ? "Re-open Issue" : "Closed Issue", systemImage: "bubble.left.and.exclamationmark.bubble.right")
            }
            
            Divider()
            
            Section("Tags") {
                TagsMenuView(issue: issue)
            }
            
        } label: {
            Label("Action", systemImage: "ellipsis.circle")
        }

    }
}

struct IssueViewToolbar_Previews: PreviewProvider {
    static var previews: some View {
        IssueViewToolbar(issue: Issue.example)
    }
}
