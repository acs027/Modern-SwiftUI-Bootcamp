//
//  ContentViewModel.swift
//  TaskManager
//
//  Created by ali cihan on 5.09.2025.
//

import Foundation


final class ContentViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var newTaskTitle: String = ""
    @Published var taskDetailIsShowing: Bool = false {
        didSet {
            if oldValue {
                resetNewTaskTitle()
            }
        }
    }
    
    init() {
        let task = Task(id: UUID(), title: "Title", isCompleted: false)
        self.tasks = [task]
    }
    
    func deleteTask(id: UUID) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        tasks.remove(at: index)
        
    }
    
    func toggleIsCompleted(id: UUID) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        tasks[index].isCompleted.toggle()
    }
    
    func addTask() {
        let newTask = Task(id: UUID(), title: newTaskTitle, isCompleted: false)
        tasks.append(newTask)
    }
    
    private func resetNewTaskTitle() {
        newTaskTitle = ""
    }
}
