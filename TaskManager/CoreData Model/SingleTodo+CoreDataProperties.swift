//
//  SingleTodo+CoreDataProperties.swift
//  TaskManager
//
//  Created by Hirakjyoti Borah on 29/07/22.
//
//

import Foundation
import CoreData


extension SingleTodo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SingleTodo> {
        return NSFetchRequest<SingleTodo>(entityName: "SingleTodo")
    }

    @NSManaged public var title: String?
    @NSManaged public var todoDetail: String?
    @NSManaged public var isComplete: Bool

}

extension SingleTodo : Identifiable {

}
