//
//  Task.swift
//  Testarwa
//
//  Created by Arwa ALghamdi on 14/06/1444 AH.
//

import SwiftUI
// Task Model
struct Task: Identifiable,Hashable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
    
}

