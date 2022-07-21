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
                cell?.delegate = self
                return cell

            }
        }
        return dataSource
    }
    
    private func addSnapShot() {
        var snapShot = AddNewTaskVM.Snapshot()
        snapShot.appendSections([.title, .timeLine, .priority, .taskDetails, .todos])
        snapShot.appendItems([.titleSection(.init(title: ""))], toSection: .title)
        snapShot.appendItems([.timeLineSection(.init(startDate: "", endDate: ""))], toSection: .timeLine)
        snapShot.appendItems([.priorities(.p0)], toSection: .priority)
        snapShot.appendItems([.taskDetail(.init(taskDetails: ""))], toSection: .taskDetails)
        snapShot.appendItems([.todos(.init(title: "", todoDetail: "", isComplete: false))], toSection: .todos)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    private func updateTodoSnapshot(_ todo: Todos) {
        var snapShot = AddNewTaskVM.Snapshot()
        snapShot.insertItems([.todos(.init(from: todo))], beforeItem: .todos(.init(title: "", todoDetail: "", isComplete: false)))
    }
}

extension AddNewTaskVC: TodoTVCDelegate {
    
    func presentNewTodoSnckbar() {
        let mainStory = UIStoryboard.init(name: "Main", bundle: .main)
        if let vc = UIStoryboard.instantiateViewController(mainStory)(withIdentifier: "AddTodosSnackbar") as? AddTodosSnackbar {
            vc.completionBlock = { title, desc in
                //todo: add new todo cell
                let todo = Todos(title: title, todoDetail: desc, isComplete: false)
                self.updateTodoSnapshot(todo)
            }
            modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
}
