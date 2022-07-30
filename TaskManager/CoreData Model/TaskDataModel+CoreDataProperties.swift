//
//  TaskDataModel+CoreDataProperties.swift
//  TaskManager
//
//  Created by Hirakjyoti Borah on 29/07/22.
//
//

import Foundation
import CoreData


extension TaskDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskDataModel> {
        return NSFetchRequest<TaskDataModel>(entityName: "TaskDataModel")
    }

    @NSManaged public var title: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var taskDetail: String?
    @NSManaged public var priority: Int16
    @NSManaged public var todoList: [SingleTodo]?
    @NSManaged public var taskCreationDate: Date?
    @NSManaged public var id: UUID?

}

extension TaskDataModel : Identifiable {

}
