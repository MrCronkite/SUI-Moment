//
//  Task.swift
//  LayoutTask
//
//  Created by Влад Шимченко on 6.05.26.
//

import SwiftUI
import SwiftData


@Model
final class Task {
    var id: UUID
    var title: String
    var isCompleted: Bool
    var createdAt: Date

    init(title: String) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
        self.createdAt = Date()
    }
}
