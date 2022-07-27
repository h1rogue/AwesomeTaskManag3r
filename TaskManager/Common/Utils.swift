//
//  Utils.swift
//  TaskManager
//
//  Created by Hirakjyoti Borah on 25/07/22.
//

import Foundation


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
