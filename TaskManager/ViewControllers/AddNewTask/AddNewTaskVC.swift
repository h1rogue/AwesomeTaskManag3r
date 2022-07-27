//
//  AddNewTaskVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

class AddNewTaskVC: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    var viewModel: AddNewTaskVM = AddNewTaskVM()
    
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setUpNavBar()
        setUpKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpTableView()
    }
    
    @objc private func detectKeyboardComingUp(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        var viewFrame: CGRect
        
        if let responder = UIResponder.firstResponder as? UITextField {
            let responderFrame = responder.frame
            let convFrame = self.view.convert(responderFrame, from: responder.superview)
            viewFrame = convFrame
        } else if let responder = UIResponder.firstResponder as? UITextView {
            let responderFrame = responder.frame
            let convFrame = self.view.convert(responderFrame, from: responder.superview)
            viewFrame = convFrame
        } else {
            return
        }
        
        if keyboardFrame.cgRectValue.intersects(viewFrame) {
            let intersectionFrameHeight = keyboardFrame.cgRectValue.intersection(viewFrame).height
            self.view.frame.origin.y =  -intersectionFrameHeight
        }
        return
    }

    @objc private func detectKeyboardGoingDown(_ sender: NSNotification) {
            self.view.frame.origin.y = 0
        return
    }
    
    private func setUpKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(detectKeyboardComingUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(detectKeyboardGoingDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorInset = .zero
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
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @IBAction func saveTask(_ sender: Any) {
        //MARK: todo
        self.view.endEditing(true)
        viewModel.validateFields()
    }
}

extension AddNewTaskVC : UITableViewDelegate {

}

extension AddNewTaskVC: AddNewTaskVMDelegate {
    
    func reloadTitle(text: String? = nil, error: ValidationErrors) {
        var snapshot = dataSource.snapshot()
        if let item = snapshot.itemIdentifiers(inSection: .title).first {
            switch item {
            case .titleSection(let model):
                guard let model = model else {
                    let newModel = AddNewTaskVM.TitleSection.init(title: "")
                    newModel.validationError = error
                    snapshot.deleteItems([.titleSection(nil)])
                    snapshot.appendItems([.titleSection(newModel)], toSection: .title)
                    dataSource.apply(snapshot, animatingDifferences: false)
                    return
                }
                model.validationError = error
                if let text = text {
                    model.title = text
                }
                snapshot.reconfigureItems([.titleSection(model)])
                dataSource.apply(snapshot, animatingDifferences: false)
            default:
                break
            }
        }
    }
    
    func reloadTaskDetail(text: String? = nil, error: ValidationErrors) {
        var snapshot = dataSource.snapshot()
        if let item = snapshot.itemIdentifiers(inSection: .taskDetails).first {
            switch item {
            case .taskDetail(let model):
                guard let model = model else {
                    let newModel = AddNewTaskVM.TaskDetail.init(taskDetail: "")
                    newModel.validationError = error
                    snapshot.deleteItems([.taskDetail(nil)])
                    snapshot.appendItems([.taskDetail(newModel)], toSection: .taskDetails)
                    dataSource.apply(snapshot, animatingDifferences: false)
                    return
                }
                model.validationError = error
                if let text = text {
                    model.taskDetails = text
                }
                snapshot.reconfigureItems([.taskDetail(model)])
                dataSource.apply(snapshot, animatingDifferences: false)
            default:
                break
            }
        }
    }
    
    func reloadTaskDetailwithVal(_ with: String?) {
        var snapshot = dataSource.snapshot()
        if let item = snapshot.itemIdentifiers(inSection: .taskDetails).first {
            switch item {
            case .taskDetail(let model):
                guard let model = model else {
                    var fText:String
                    if let text = with {
                        fText = text
                    } else {
                        fText = ""
                    }
                    let newModel = AddNewTaskVM.TaskDetail.init(taskDetail: fText)
                    newModel.validationError = nil
                    snapshot.deleteItems([.taskDetail(nil)])
                    snapshot.appendItems([.taskDetail(newModel)], toSection: .taskDetails)
                    dataSource.apply(snapshot, animatingDifferences: false)
                    return
                }
                if let text = with {
                    model.taskDetails = text
                }
                model.validationError = nil
                snapshot.reconfigureItems([.taskDetail(model)])
                dataSource.apply(snapshot, animatingDifferences: false)
            default:
                break
            }
        }
    }
    
    func reloadTitleWithVal(_ with: String?) {
        var snapshot = dataSource.snapshot()
        if let item = snapshot.itemIdentifiers(inSection: .title).first {
            switch item {
            case .titleSection(let model):
                guard let model = model else {
                    var fText:String
                    if let text = with {
                        fText = text
                    } else {
                        fText = ""
                    }
                    let newModel = AddNewTaskVM.TitleSection.init(title: fText)
                    newModel.validationError = nil
                    snapshot.deleteItems([.titleSection(nil)])
                    snapshot.appendItems([.titleSection(newModel)], toSection: .title)
                    dataSource.apply(snapshot, animatingDifferences: false)
                    return
                }
                if let text = with {
                    model.title = text
                }
                model.validationError = nil
                snapshot.reconfigureItems([.titleSection(model)])
                dataSource.apply(snapshot, animatingDifferences: false)
            default:
                break
            }
        }
    }
}

extension AddNewTaskVC {
    private func makeDataSource() -> AddNewTaskVM.DataSource {
        let dataSource = AddNewTaskVM.DataSource(tableView: self.tableView) { tableView, indexPath, itemIdentifier in
            switch (itemIdentifier) {
            case .titleSection(let model):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTVC.identifier, for: indexPath) as? TitleTVC else {
                    return UITableViewCell()
                }
                cell.configureError(text: model?.title, error: model?.validationError)
                cell.delegate = self
                return cell
            case .timeLineSection(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: DateTVC.identifier, for: indexPath) as? DateTVC
                cell?.delegate = self
                return cell
            case .priorities(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: PriorityTVC.identifier, for: indexPath) as? PriorityTVC
                cell?.delegate = self
                if let model = model {
                    cell?.configure(cellPriority: model)
                }
                return cell
            case .taskDetail(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: TaskDetailTVC.identifier, for: indexPath) as? TaskDetailTVC
                cell?.delegate = self
                cell?.configureError(text: model?.taskDetails, error: model?.validationError)
                return cell
            case .todos(let todoList):
                let cell = tableView.dequeueReusableCell(withIdentifier: TodoTVC.identifier, for: indexPath) as? TodoTVC
                cell?.delegate = self
                cell?.configure(todoList: todoList)
                return cell

            }
        }
        return dataSource
    }
    
    private func addSnapShot() {
        var snapShot = AddNewTaskVM.Snapshot()
        snapShot = viewModel.dummyItems(snapShot: snapShot)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    private func updateTodoSnapshot(_ todo: Todos) {
        var snapShot = dataSource.snapshot()
        viewModel.todoList.append(todo)
        snapShot.deleteSections([.todos])
        snapShot.appendSections([.todos])
        snapShot.appendItems([.todos(viewModel.todoList)], toSection: .todos)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
}

extension AddNewTaskVC: TodoTVCDelegate {
    func updateTodo(todo: Todos) {
        viewModel.todoList = viewModel.todoList.map {
            if todo.id == $0.id {
                $0.isCompleted = todo.isCompleted
            }
            return $0
        }
    }
    
    func presentNewTodoSnckbar() {
        let mainStory = UIStoryboard.init(name: "Main", bundle: .main)
        if let vc = UIStoryboard.instantiateViewController(mainStory)(withIdentifier: "AddTodosSnackbar") as? AddTodosSnackbar {
            vc.completionBlock = { title, desc in
                let todo = Todos(title: title, todoDetail: desc, isComplete: false)
                self.updateTodoSnapshot(todo)
            }
            modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
}

extension AddNewTaskVC: DateTVCDelegate {
    func editDateClicked(timeLine: AddNewTaskVM.TimeLineSection) {
            viewModel.updateTaskValues(section: .timeLine, item: .timeLineSection(timeLine))
    }
}

extension AddNewTaskVC: TitleTVCDelegate {
    func updateTitle(title: String) {
        viewModel.updateTaskValues(section: .title, item: .titleSection(.init(title: title)))
    }
}

extension AddNewTaskVC: PriorityTVCDelegate {
    func prioritySelected(_ priority: AddNewTaskVM.Priorities) {
        viewModel.updateTaskValues(section: .priority, item: .priorities(priority))
    }
}

extension AddNewTaskVC: TaskDetailTVCDelegate {
    func taskDetailAdded(_ taskDetail: AddNewTaskVM.TaskDetail) {
        viewModel.updateTaskValues(section: .taskDetails, item: .taskDetail(taskDetail))
    }
}


