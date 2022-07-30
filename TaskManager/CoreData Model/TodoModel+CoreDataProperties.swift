//
//  TodoModel+CoreDataProperties.swift
//  TaskManager
//
//  Created by Hirakjyoti Borah on 29/07/22.
//
//

import Foundation
import CoreData


extension TodoModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoModel> {
        return NSFetchRequest<TodoModel>(entityName: "TodoModel")
    }

    @NSManaged public var title: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var taskDetail: String?
    @NSManaged public var priority: Int16
    @NSManaged public var todosList:  ?

}

extension TodoModel : Identifiable {

}
