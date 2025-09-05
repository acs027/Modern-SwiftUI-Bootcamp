//
//  ContentView.swift
//  TaskManager
//
//  Created by ali cihan on 5.09.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm: ContentViewModel = ContentViewModel()
  
    
    var completedTasks: [Task] {
        vm.tasks.filter {
            $0.isCompleted
        }
    }
    
    var waitingTasks: [Task] {
        vm.tasks.filter {
            !$0.isCompleted
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                waitingTaskSection
                completedTaskSection
            }
            
            .alert("New Task", isPresented: $vm.taskDetailIsShowing) {
                TextField("Enter task", text: $vm.newTaskTitle)
                Button("Add") { vm.addTask() }
                Button("Cancel", role: .cancel) {  }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    showAddTaskButton()
                }
            }
        }
    }
    
    var waitingTaskSection: some View {
        Section("Waiting Tasks") {
            ForEach(waitingTasks, id: \.id) { task in
                Text(task.title)
                    .swipeActions(edge: .trailing) {
                        deleteButton(task: task)
                    }
                    .swipeActions(edge: .leading) {
                        toggleTaskIsCompleted(task: task)
                    }
            }
        }
    }
    
    var completedTaskSection: some View {
        Section("Completed Tasks") {
            ForEach(completedTasks, id: \.id) { task in
                Text(task.title)
                    .swipeActions(edge: .trailing) {
                        deleteButton(task: task)
                    }
                    .swipeActions(edge: .leading) {
                        toggleTaskIsCompleted(task: task)
                    }
            }
        }
    }
    
    private func showAddTaskButton() -> some View {
        Button {
            vm.taskDetailIsShowing.toggle()
        } label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 25, height: 25)
        }
    }
    
    private func deleteButton(task: Task) -> some View {
        Button(role: .destructive) {
            vm.deleteTask(id: task.id)
        } label: {
            Image(systemName: "trash")
        }
    }
    
    private func toggleTaskIsCompleted(task: Task) -> some View {
        Button {
            vm.toggleIsCompleted(id: task.id)
        } label: {
            Image(systemName: task.isCompleted ? "cross" : "checkmark")
        }
        .tint(task.isCompleted ? .gray : .green)
    }
}

#Preview {
    ContentView()
}
