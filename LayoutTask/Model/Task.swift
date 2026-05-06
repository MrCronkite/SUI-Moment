//
//  Task.swift
//  LayoutTask
//
//  Created by Влад Шимченко on 6.05.26.
//

import SwiftUI

enum TaskFilter: String, CaseIterable {
    case all = "All"
    case active = "Active"
    case completed = "Completed"
}

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}
