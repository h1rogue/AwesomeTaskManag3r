//
//  AddNewTaskVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

class AddNewTaskVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: AddNewTaskVM? = AddNewTaskVM()
    
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        setUpNavBar()
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
        registerTableViewCells()
        addSnapShot()
    }
    
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: TitleTVC.identifier, bundle: .main), forCellReuseIdentifier: TitleTVC.identifier)
        tableView.register(UINib(nibName: DateTVC.identifier, bundle: .main), forCellReuseIdentifier: DateTVC.identifier)
        tableView.register(UINib(nibName: PriorityTVC.identifier, bundle: .main), forCellReuseIdentifier: PriorityTVC.identifier)
        tableView.register(UINib(nibName: TaskDetailTVC.identifier, bundle: .main), forCellReuseIdentifier: TaskDetailTVC.identifier)
        tableView.register(UINib(nibName: TodoTVC.identifier, bundle: .main), forCellReuseIdentifier: TodoTVC.identifier)
    }
    
    private func setUpNavBar() {
        self.navigationItem.title = "Add New Task"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func saveTask(_ sender: Any) {
        //MARK: on save task clicked
    }
}

extension AddNewTaskVC : UITableViewDelegate {

}

extension AddNewTaskVC: AddNewTaskVMDelegate {
    
}

extension AddNewTaskVC {
    private func makeDataSource() -> AddNewTaskVM.DataSource {
        let dataSource = AddNewTaskVM.DataSource(tableView: self.tableView) { tableView, indexPath, itemIdentifier in
            switch (itemIdentifier) {
            case .titleSection(_):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTVC.identifier, for: indexPath) as? TitleTVC else {
                    return UITableViewCell()
                }
                cell.configure()
                return cell
            case .timeLineSection(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: DateTVC.identifier, for: indexPath) as? DateTVC
                return cell
            case .priorities(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: PriorityTVC.identifier, for: indexPath) as? PriorityTVC
                return cell
            case .taskDetail(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: TaskDetailTVC.identifier, for: indexPath) as? TaskDetailTVC
                return cell
            case .todos(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: TodoTVC.identifier, for: indexPath) as? TodoTVC
                return cell

            }
        }
        return dataSource
    }
    
    private func addSnapShot() {
        var snapShot = AddNewTaskVM.Snapshot()
        snapShot.appendSections([.title, .timeLine, .priority, .taskDetails, .todos])
        snapShot.appendItems([.titleSection(.init(title: "hello"))], toSection: .title)
        snapShot.appendItems([.timeLineSection(.init(startDate: "12", endDate: "1234"))], toSection: .timeLine)
        snapShot.appendItems([.priorities(.p0)], toSection: .priority)
        snapShot.appendItems([.taskDetail(.init(taskDetails: "here tocc"))], toSection: .taskDetails)
        snapShot.appendItems([.todos(.init(title: "titld", todoDetail: "asasas", todoDetails: "asasa", isCompleted: false))], toSection: .todos)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
