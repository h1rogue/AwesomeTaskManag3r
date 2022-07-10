//
//  TaskDetailTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

class TaskDetailTVC: UITableViewCell {

    @IBOutlet weak private var taskDetailTextView: UITextView!
    @IBOutlet weak private var notifyButton: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.taskDetailTextView.text = "Add Task Details(Max 100 words.)"
        self.taskDetailTextView.textColor = .lightGray
        self.notifyButton.layer.cornerRadius = self.notifyButton.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
