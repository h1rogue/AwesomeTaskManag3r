//
//  TaskModel.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import Foundation


struct TaskModel: Codable {
    let title: String
    let startDate: String
    let endDate: String
    let taskDetail: String
    let taskCreationDate: String
    let priority: TaskModelPriority
    let todosList: [Todos]?
}

enum TaskModelPriority: Codable {
    case p0
    case p1
    case p2
}

struct Todos: Codable, Hashable {
    let title: String
    let todoDetail: String?
    let isCompleted: Bool
    
    init(from todo: Todos) {
        self.title = todo.title
        self.todoDetail = todo.todoDetail
        self.isCompleted = todo.isCompleted
    }
    
    init(title: String, todoDetail: String, isComplete: Bool) {
        self.title = title
        self.todoDetail = todoDetail
        self.isCompleted = isComplete
    }
}
