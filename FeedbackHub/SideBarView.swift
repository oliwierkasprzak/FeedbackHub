//
//  SideBarView.swift
//  FeedbackHub
//
//  Created by Oliwier Kasprzak on 26/04/2023.
//

import SwiftUI

struct SideBarView: View {
    @EnvironmentObject var dataController: DataController
    var filters: [Filter] = [.all, .recent]
    
    @State private var tagToRename: Tag?
    @State private var renamingTag = false
    @State private var tagName = ""
    
    @State private var showingAwards = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var tags: FetchedResults<Tag>
    
    var tagFilter: [Filter] {
        tags.map { tag in
            Filter(id: tag.tagId, name: tag.tagName, icon: "tag", tag: tag)
        }
    }
    
    var body: some View {
        List(selection: $dataController.selectedFilter) {
            Section("Smart Filters") {
                ForEach(filters) { filter in
                    Label(filter.name, systemImage: filter.icon)
                }
            }
            
            Section("Tags") {
                ForEach(tagFilter) { filter in
                    NavigationLink(value: filter) {
                        Label(filter.name, systemImage: filter.icon)
                            .badge(filter.activeIssuesCount)
                            .contextMenu {
                                Button {
                                    rename(filter)
                                } label: {
                                    Label("Rename", systemImage: "pencil")
                                }
                                
                                Button(role: .destructive) {
                                    delete(filter)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .accessibilityElement()
                            .accessibilityLabel(filter.name)
                            .accessibilityHint("^[\(filter.activeIssuesCount) issue](inflect: true)")
                    }
                }
                .onDelete(perform: delete)
            }
        }
        .navigationTitle("Filters")
        .toolbar {
            #if DEBUG
            Button {
                dataController.removeAll()
                dataController.sampleData()
            } label: {
                Label("Add samples", systemImage: "flame")
            }
            #endif
            Button(action: dataController.addTag) {
                Label("Add tag", systemImage: "plus")
            }
            
            Button {
                showingAwards.toggle()
            } label: {
                Label("Awards", systemImage: "rosette")
            }
            
        }
        .alert("Rename tag", isPresented: $renamingTag) {
            Button("OK", action: completeRename)
            Button("Cancel", role: .cancel) { }
            TextField("New name", text: $tagName)
        }
        .sheet(isPresented: $showingAwards, content: AwardsView.init) 
    }
    
    func delete(_ offsets: IndexSet) {
        for offset in offsets {
            let item = tags[offset]
            dataController.deleteObject(item)
        }
    }
    
    func delete(_ filter: Filter) {
        guard let tag = filter.tag else { return }
        dataController.deleteObject(tag)
        dataController.save()
    }
    
    func rename(_ filter: Filter) {
        tagToRename = filter.tag
        tagName = filter.name
        renamingTag = true
    }
    
    func completeRename() {
        tagToRename?.name = tagName
        dataController.save()
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView()
            .environmentObject(DataController.preview)
    }
}
