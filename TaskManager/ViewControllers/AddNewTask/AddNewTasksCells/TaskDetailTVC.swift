//
//  TaskDetailTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

protocol TaskDetailTVCDelegate: AnyObject {
    func taskDetailAdded(_ taskDetail: AddNewTaskVM.TaskDetail)
}

class TaskDetailTVC: UITableViewCell {

    @IBOutlet weak private var taskDetailTextView: UITextView!
    @IBOutlet weak private var notifyButton: UIView!
    @IBOutlet weak private var errorMaglabel: UILabel!
    @IBOutlet weak private var taskView: UIView!
    
    weak var delegate: TaskDetailTVCDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        taskView.layer.borderWidth = 1
        taskView.layer.borderColor = UIColor.black.cgColor
        taskView.addDefaultCornerRadius()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.taskDetailTextView.text = "Add Task Details (Max 100 words)."
        self.taskDetailTextView.textColor = .lightGray
        self.notifyButton.layer.cornerRadius = self.notifyButton.frame.height/2
        self.taskDetailTextView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TaskDetailTVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if taskDetailTextView.textColor == .lightGray {
            taskDetailTextView.text = ""
        }
        taskDetailTextView.textColor = .black
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.last == "\n" {
            taskDetailTextView.endEditing(true)
            textView.text.removeLast()
            delegate?.taskDetailAdded(AddNewTaskVM.TaskDetail(taskDetails: textView.text))
        }
    }
}
