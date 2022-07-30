//
//  TaskModel.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import Foundation
import CoreData


enum HomeSection {
    case home
}

struct TaskModel: Identifiable, Hashable {
    var id: UUID
    var title: String = ""
    var startDate: Date = Date()
    var endDate: Date = Date()
    var taskDetail: String = ""
    var taskCreationDate: Date = Date()
    var priority: Int16 = 2
    var todosList: [Todos]?
}

class Todos: Hashable {
    
    static func == (lhs: Todos, rhs: Todos) -> Bool {
        return lhs.title == rhs.title && lhs.todoDetail == rhs.todoDetail && lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(title);
        hasher.combine(todoDetail)
        hasher.combine(id)
    }
    
    let title: String
    let todoDetail: String?
    var isCompleted: Bool
    var id: UUID = UUID()
    
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
