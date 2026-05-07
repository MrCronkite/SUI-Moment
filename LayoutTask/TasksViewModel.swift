//
//  TasksViewModel.swift
//  LayoutTask
//
//  Created by Влад Шимченко on 7.05.26.
//

import SwiftUI
import SwiftData

@MainActor
final class TasksViewModel: ObservableObject {

    var context: ModelContext!

    @Published var filter: TaskFilter = .all

    func setContext(_ context: ModelContext) {
        self.context = context
    }

    // MARK: - Actions
    
    func addTask(title: String) {
        let task = Task(title: title)
        context.insert(task)
        save()
    }

    func deleteTask(_ task: Task) {
        context.delete(task)
        save()
    }

    func toggleTask(_ task: Task) {
        task.isCompleted.toggle()
        save()
    }

    private func save() {
        try? context.save()
    }
}
