//
//  AddNewTaskVM.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import Foundation
import UIKit

protocol AddNewTaskVMDelegate: AnyObject {
    func reloadTitle(text: String?, error: ValidationErrors)
    func reloadTitleWithVal(_ with: String?)
    func reloadTaskDetail(text: String?, error: ValidationErrors)
    func reloadTaskDetailwithVal(_ with: String?)
    
    func saveData(data: [AddNewTaskVM.TaskSections : AddNewTaskVM.Items])
}

protocol ValidationErrorProtocol {
    var validationError: ValidationErrors? { get set }
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
    
    class TitleSection: Hashable, ValidationErrorProtocol {
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: AddNewTaskVM.TitleSection, rhs: AddNewTaskVM.TitleSection) -> Bool {
            return lhs.id == rhs.id
        }
        
        var validationError: ValidationErrors?
        var title: String
        let id: UUID = UUID()
        
        init(title: String, validationError: ValidationErrors? = nil) {
            self.title = title
            self.validationError = validationError
        }
    }
    
    struct TimeLineSection: Hashable {
        let startDate: Date
        let endDate: Date
    }
    
    enum Priorities: Hashable {
        case p0(ValidationErrors? = nil), p1(ValidationErrors? = nil), p2(ValidationErrors? = nil)
    }
    
    class TaskDetail: Hashable, ValidationErrorProtocol {
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        static func == (lhs: AddNewTaskVM.TaskDetail, rhs: AddNewTaskVM.TaskDetail) -> Bool {
            return lhs.id == rhs.id
        }
        
        var validationError: ValidationErrors?
        let id: UUID = UUID()
        var taskDetails: String
        
        init(taskDetail: String, validationError: ValidationErrors? = nil) {
            self.taskDetails = taskDetail
            self.validationError = validationError
        }
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
        snapShot.appendItems([.priorities(.p2())], toSection: .priority)
        snapShot.appendItems([.taskDetail(nil)], toSection: .taskDetails)
        snapShot.appendItems([.todos(todoList)], toSection: .todos)
        return snapShot
    }
    
    var mandatoryFields: [TaskSections] = [.title, .taskDetails]
    
    var taskValues: [TaskSections: Items] = [:]
    
    private func validateTitle(_ text: String) -> Result<String?,ValidationErrors> {
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty {
            return .failure(.emptyTitle)
        }
        if text.count > 25 {
            return .failure(.longTitle)
        }
        return .success(text)
    }
    
    private func validateTaskDetail(_ text: String) -> Result<String?,ValidationErrors> {
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty {
            return .failure(.emptyTaskDetail)
        }
        if text.count > 100 {
            return .failure(.longTaskDetail)
        }
        return .success(text)
    }
    
    func validateFields() {
        for section in mandatoryFields {
            switch section {
            case .title:
                if taskValues[.title] == nil {
                    delegate?.reloadTitle(text: nil, error: ValidationErrors.emptyTitle)
                } else {
                    let model = taskValues[.title]!
                    switch model {
                    case .titleSection(let model):
                        guard let model = model else { return }
                        switch validateTitle(model.title) {
                        case .success(let text):
                            delegate?.reloadTitleWithVal(text)
                        case .failure(let error):
                            if error == .emptyTitle {
                                delegate?.reloadTitle(text: "", error: error)
                            } else {
                                delegate?.reloadTitle(text: nil, error: error)
                            }
                        }
                    default:
                        break
                    }
                }
            case .taskDetails:
                if taskValues[.taskDetails] == nil {
                    delegate?.reloadTaskDetail(text: nil, error: .emptyTaskDetail)
                } else {
                    let model = taskValues[.taskDetails]!
                    switch model {
                    case .taskDetail(let model):
                        guard let model = model else { return }
                        switch validateTaskDetail(model.taskDetails) {
                        case .success(let text):
                            delegate?.reloadTaskDetailwithVal(text)
                        case .failure(let err):
                            delegate?.reloadTaskDetail(text: "", error: err)
                        }
                    default:
                        break
                    }
                }
            default:
                break
            }
        }
        updateTaskValues(section: .todos, item: .todos(todoList))
        saveTask()
    }
    
    func updateTaskValues(section: TaskSections, item: Items) {
            taskValues[section] = item
    }
    
    private func saveTask() {
        delegate?.saveData(data: taskValues)
    }
}
