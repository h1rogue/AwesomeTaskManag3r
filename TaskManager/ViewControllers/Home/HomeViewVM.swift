//
//  HomeViewVM.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import Foundation

protocol HomeVMDelegate: AnyObject {
    func doSomething()
}

class HomeVM {
    var taskList: [TaskModel]
    weak var delegate: HomeVMDelegate?
    
    init(delegate: HomeVMDelegate) {
        self.delegate = delegate
        taskList = [TaskModel]()
    }
}
