//
//  AddNewTaskVM.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import Foundation
import UIKit

protocol AddNewTaskVMDelegate: AnyObject {
    
}

class AddNewTaskVM {
    
    typealias DataSource = UITableViewDiffableDataSource<TaskSections, Items>
    typealias Snapshot = NSDiffableDataSourceSnapshot<TaskSections, Items>
    weak var delegate: AddNewTaskVMDelegate?
    
    enum TaskSections {
        case title
        case timeLine
        case priority
        case taskDetails
        case todos
    }
    
    struct TitleSection: Hashable {
        let title: String
    }
    
    struct TimeLineSection: Hashable {
        let startDate: Date
        let endDate: Date
    }
    
    enum Priorities {
        case p0, p1, p2
    }
    
    struct TaskDetail: Hashable {
        let taskDetails: String
    }
    
    enum Items: Hashable {
        case titleSection(TitleSection?)
        case timeLineSection(TimeLineSection?)
        case taskDetail(TaskDetail?)
        case priorities(Priorities?)
        case todos([Todos])
    }
    
    let sectionList: [TaskSections] = [.title, .timeLine, .priority, .taskDetails, .todos]
    
    var todoList: [Todos] = []
    
    func dummyItems(snapShot: Snapshot) -> Snapshot {
        var snapShot = snapShot
        snapShot.appendSections(self.sectionList)
        snapShot.appendItems([.titleSection(nil)], toSection: .title)
        snapShot.appendItems([.timeLineSection(nil)], toSection: .timeLine)
        snapShot.appendItems([.priorities(.p0)], toSection: .priority)
        snapShot.appendItems([.taskDetail(nil)], toSection: .taskDetails)
        snapShot.appendItems([.todos(todoList)], toSection: .todos)
        return snapShot
    }
    
    var mandatoryFields: [TaskSections] = [.title, .taskDetails, .priority]
    
    var taskValues: [TaskSections: Items] = [:]
    
    private func validateTitle(_ text: String) -> Bool {
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty || text.count > 25 {
            return false
        }
        return true
    }
    
    private func validateTaskDetail(_ text: String) -> Bool {
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty || text.count > 100 {
            return false
        }
        return true
    }
    
    func saveTask() {
        
    }
    
    func validateFields() -> Bool {
        for section in mandatoryFields {
            switch section {
            case .title:
                if taskValues[.title] != nil {
                    switch taskValues[.title] {
                    case .titleSection(let model):
                        guard let model = model else { return false }
                        if !validateTitle(model.title) {
                            //MARK: todo
                            return false
                        }
                    default:
                        break
                    }
                } else {
                    return false
                }
            case .timeLine:
                break
            case .priority:
                if taskValues[.priority] == nil {
                    return false
                }
            case .taskDetails:
                if taskValues[.taskDetails] != nil {
                    switch taskValues[.taskDetails] {
                    case .taskDetail(let model):
                        guard let model = model else { return false }
                        if !validateTaskDetail(model.taskDetails) {
                            return false
                        }
                    default:
                        break
                    }
                } else {
                    return false
                }
            case .todos:
                break
            }
        }
        return true
    }
    
    func updateTaskValues(section: TaskSections, item: Items) {
            taskValues[section] = item
    }
}
