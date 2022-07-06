//
//  TaskDetailTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

class TaskDetailTVC: UITableViewCell {

    @IBOutlet weak var taskDetailTextView: UITextView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.taskDetailTextView.text = "Add Task Details(Max 100 words.)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
