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
    @IBOutlet weak private var placeHolderText: UILabel!
    
    weak var delegate: TaskDetailTVCDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        taskView.layer.borderWidth = 1
        taskView.layer.borderColor = UIColor.black.cgColor
        taskView.addDefaultCornerRadius()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.notifyButton.layer.cornerRadius = self.notifyButton.frame.height/2
        self.taskDetailTextView.delegate = self
    }
    
    func configureError(text: String? = nil, error: ValidationErrors? = nil) {
        if let text = text {
            self.taskDetailTextView.text = text
        }
        
        if error != nil {
            self.errorMaglabel.text = error?.rawValue
            self.errorMaglabel.isHidden = false
        } else {
            self.errorMaglabel.isHidden = true
        }
    }
}

extension TaskDetailTVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeHolderText.isHidden = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.last == "\n" {
            taskDetailTextView.endEditing(true)
            textView.text.removeLast()
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                placeHolderText.isHidden = false
            }
            delegate?.taskDetailAdded(.init(taskDetail: textView.text))
        }
    }
}
