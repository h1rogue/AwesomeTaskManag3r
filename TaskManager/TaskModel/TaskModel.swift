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
    let todoDetails: String
    let isCompleted: Bool
}
