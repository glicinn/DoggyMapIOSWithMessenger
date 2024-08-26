//
//  Task.swift
//  DoggyMap
//
//  Created by Дмитрiй Дѣренъ on 01.04.2024.
//

import SwiftUI

// MARK: Task Model
struct Note: Identifiable{
    var id: UUID = .init()
    var dateAdded: Date
    var taskName: String
    var taskDescription: String
    var taskCategory: Category
}

var sampleTasks: [Note] = [
    .init(dateAdded: Date(timeIntervalSince1970: 1711993592), taskName: "Edit YT Video", taskDescription: " Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", taskCategory: .general),
    .init(dateAdded: Date(timeIntervalSince1970: 1711953600), taskName: "Multi-ScrollView", taskDescription: "", taskCategory: .challenge),
    .init(dateAdded: Date(timeIntervalSince1970: 1711961592), taskName: "Loreal Ipsum", taskDescription: "", taskCategory: .idea),
    .init(dateAdded: Date(timeIntervalSince1970: 1711990592), taskName: "Fix Shadow", taskDescription: "", taskCategory: .bug),
    .init(dateAdded: Date(timeIntervalSince1970: 1711975592), taskName: "Lorem Ipsum", taskDescription: "", taskCategory: .modifiers),
    .init(dateAdded: Date(timeIntervalSince1970: 1711940592), taskName: "Twitter/Instagram Post", taskDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", taskCategory: .general),
    .init(dateAdded: Date(timeIntervalSince1970: 1711940592), taskName: "Code writing", taskDescription: "", taskCategory: .coding)
]
