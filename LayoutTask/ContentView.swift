

import SwiftUI

struct TasksView: View {

    @State private var tasks: [Task] = [
        Task(title: "Купить продукты"),
        Task(title: "Сделать домашку"),
        Task(title: "Позвонить маме")
    ]

    @State private var newTaskText: String = ""
    @State private var isAddingTask: Bool = false
    @State private var editingTask: Task?
    @State private var editedText: String = ""
    @State private var filter: TaskFilter = .all

    private var filteredTasks: [Task] {
        switch filter {
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
                Picker("Фильтр", selection: $filter) {
                    ForEach(TaskFilter.allCases, id: \.self) { filter in
                        Text(filter.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                List {
                    ForEach(filteredTasks) { task in

                        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                            let binding = $tasks[index]

                            HStack {
                                Button(action: {
                                    binding.isCompleted.wrappedValue.toggle()
                                }) {
                                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(task.isCompleted ? .green : .gray)
                                        .font(.title2)
                                }
                                .buttonStyle(.plain)

                                TextField("Задача", text: binding.title)
                                    .strikethrough(task.isCompleted)
                                    .foregroundColor(task.isCompleted ? .gray : .primary)
                            }
                            .padding(.vertical, 4)
                            .swipeActions(edge: .trailing) {
                                Button() {
                                    startEditingTask(task)
                                } label: {
                                    Label("", systemImage: "pencil")
                                }

                                Button(role: .destructive) {
                                    deleteTask(task)
                                } label: {
                                    Label("", systemImage: "trash")
                                }
                            }
                        }
                    }
                }

                Button(action: {
                    isAddingTask = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Добавить задачу")
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle(Text("Задачи"))
            .sheet(isPresented: $isAddingTask) {
                addTaskView
            }
            .sheet(item: $editingTask) { task in
                VStack(spacing: 16) {
                    Text("Редактировать задачу")
                        .font(.title)

                    TextField("Задача", text: $editedText)
                        .textFieldStyle(.roundedBorder)

                    Button("Сохранить") {
                        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                            tasks[index].title = editedText
                        }
                        editingTask = nil
                    }

                    Button("Отмена") {
                        editingTask = nil
                    }
                }
                .padding()
            }
        }
    }


    private var addTaskView: some View {
        VStack(spacing: 16) {
            Text("Новая задача")
                .font(.title)

            TextField("Введите задачу", text: $newTaskText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Сохранить") {
                addTask()
                isAddingTask = false
            }.disabled(newTaskText.isEmpty)

            Button("Отмена") {
                isAddingTask = false
            }
        }
        .padding()
    }

    private func addTask() {
        let newTask = Task(title: newTaskText)
        tasks.append(newTask)
        newTaskText = ""
    }

    private func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }

    private func startEditingTask(_ task: Task) {
        withAnimation {
            self.editingTask = task
            self.editedText = task.title
        }
    }
}
