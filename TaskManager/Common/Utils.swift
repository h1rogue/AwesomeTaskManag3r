//
//  Utils.swift
//  TaskManager
//
//  Created by Hirakjyoti Borah on 25/07/22.
//

import Foundation
import UIKit


public enum ValidationErrors: String, Error {
case emptyTitle = "Title is empty."
case longTitle = "Title is more than 25 characters."
case titleModelFailure = "Title model is failed."
case emptyTaskDetail = "Task details is empty."
case longTaskDetail = "Task Detail is more than 100 characters."
case taskModelFailure = "Task Model Failed."
case emptyPriority = "Priority is empty."
case priorityModelFailure = "Priority Model Failed."
}

class CommonUtils {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func modelConverter(task: TaskModel) {
        
        let newTodoModel = TaskDataModel.init(context: context)
        newTodoModel.title = task.title
        newTodoModel.startDate = task.startDate
        newTodoModel.endDate = task.endDate
        newTodoModel.priority = task.priority
        newTodoModel.taskDetail = task.taskDetail
        newTodoModel.taskCreationDate = Date()
        newTodoModel.id = UUID()
    
        if let todos = task.todosList {
            newTodoModel.todoList = todos.map {
                let todo = SingleTodo(context: context)
                todo.title = $0.title
                todo.isComplete = $0.isCompleted
                todo.todoDetail = $0.todoDetail
                return todo
            }
        } else {
            newTodoModel.todoList = nil
        }
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    static func dbToModel(taskList: [TaskDataModel]) -> [TaskModel] {
     
        return taskList.map { model -> TaskModel in
            var newModel = TaskModel(id: UUID())
            newModel.title = model.title ?? ""
            newModel.startDate = model.startDate ?? Date()
            newModel.endDate = model.endDate ?? Date()
            newModel.taskDetail = model.taskDetail ?? ""
            newModel.priority = model.priority
            newModel.taskCreationDate = model.taskCreationDate ?? Date()
            if let todos = model.todoList {
                newModel.todosList = todos.map { model -> Todos in
                    let todo = Todos(title: model.title ?? "", todoDetail: model.todoDetail ?? "", isComplete: model.isComplete)
                    return todo
                    
                }
            } else {
                newModel.todosList = nil
            }
            return newModel
        }
    }
}
