import SwiftUI
import SwiftData

struct TasksView: View {

    @Environment(\.modelContext)
    private var context

    @StateObject private var vm = TasksViewModel()

    @Query(sort: \Task.createdAt, order: .reverse)
    private var tasks: [Task]

    @State private var newTaskText = ""
    @State private var isAddingTask = false

    var filteredTasks: [Task] {
        switch vm.filter {
        case .all:
            return tasks
        case .active:
            return tasks.filter { !$0.isCompleted }
        case .completed:
            return tasks.filter { $0.isCompleted }
        }
    }

    var body: some View {
        NavigationView {
            VStack {

                // inject context once
                Color.clear
                    .frame(height: 0)
                    .onAppear {
                        vm.setContext(context)
                    }

                // FILTER
                Picker("Фильтр", selection: $vm.filter) {
                    ForEach(TaskFilter.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // LIST
                List {
                    ForEach(filteredTasks) { task in
                        HStack {
                            Button {
                                vm.toggleTask(task)
                            } label: {
                                Image(systemName: task.isCompleted
                                      ? "checkmark.circle.fill"
                                      : "circle")
                            }

                            Text(task.title)
                                .strikethrough(task.isCompleted)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                vm.deleteTask(task)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }

                // ADD BUTTON
                Button {
                    isAddingTask = true
                } label: {
                    Label("Добавить задачу", systemImage: "plus")
                }
                .padding()
            }
            .navigationTitle("Задачи")
            .sheet(isPresented: $isAddingTask) {
                addTaskView
            }
        }
    }

    // MARK: - Add View

    private var addTaskView: some View {
        VStack {
            TextField("Задача", text: $newTaskText)
                .textFieldStyle(.roundedBorder)

            Button("Сохранить") {
                vm.addTask(title: newTaskText)
                newTaskText = ""
                isAddingTask = false
            }
        }
        .padding()
    }
}
