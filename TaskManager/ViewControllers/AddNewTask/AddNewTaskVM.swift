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
        case titleSection(TitleSection)
        case timeLineSection(TimeLineSection)
        case taskDetail(TaskDetail)
        case priorities(Priorities)
        case todos(Todos)
    }
    
  
}
