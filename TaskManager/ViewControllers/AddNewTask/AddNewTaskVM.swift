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
        let startDate: String
        let endDate: String
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
}
