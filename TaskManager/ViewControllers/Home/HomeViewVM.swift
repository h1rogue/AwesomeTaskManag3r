//
//  HomeViewVM.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import Foundation
import UIKit

protocol HomeVMDelegate: AnyObject {
    func reloadData()
}

typealias HomeDataSource = UICollectionViewDiffableDataSource<HomeSection,TaskModel>
typealias HomeSnapshot = NSDiffableDataSourceSnapshot<HomeSection, TaskModel>

class HomeVM {
    
    private var taskList: [TaskModel]
    weak var delegate: HomeVMDelegate?
    
    init(delegate: HomeVMDelegate) {
        self.delegate = delegate
        taskList = [TaskModel]()
    }
    
    func modifyTaskList(data: [AddNewTaskVM.TaskSections : AddNewTaskVM.Items]) {
        var newTask = TaskModel(id: UUID())
        for key in data {
            switch key.0 {
            case .title:
                guard let data = data[.title] else { break }
                switch data {
                case .titleSection(let model):
                    guard let model = model else { break }
                    newTask.title = model.title
                default:
                    break
                }
            case .timeLine:
                guard let data = data[.timeLine] else { break }
                switch data {
                case .timeLineSection(let model):
                    guard let model = model else { break }
                    newTask.startDate = model.startDate
                    newTask.endDate = model.endDate
                default:
                    break
                }
            case .priority:
                guard let data = data[.priority] else { break }
                switch data {
                case .priorities(let model):
                    guard let model = model else { break }
                    switch model {
                    case .p2(_):
                        newTask.priority = 2
                    case .p1(_):
                        newTask.priority = 1
                    case .p0(_):
                        newTask.priority = 0
                    }
                default:
                    break
                }
            case .taskDetails:
                guard let data = data[.taskDetails] else { break }
                switch data {
                case .taskDetail(let model):
                    guard let model = model else { break }
                    newTask.taskDetail = model.taskDetails
                default:
                    break
                }
            case .todos:
                guard let data = data[.todos] else { break }
                switch data {
                case .todos(let model):
                    newTask.todosList = model
                default:
                    break
                }
            }
        }
        taskList.append(newTask)
        addToDB(newTask)
    }
    
    private func addToDB(_ task: TaskModel) {
        CommonUtils.modelConverter(task: task)
        delegate?.reloadData()
    }
    
    func getTaskList() -> [TaskModel] {
        return taskList
    }
    
    func retrieveData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            let todoModel = try context.fetch(TaskDataModel.fetchRequest())
            self.taskList = CommonUtils.dbToModel(taskList: todoModel)
            delegate?.reloadData()
        } catch {
            
        }
    }
}
