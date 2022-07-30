//
//  TaskCollectionVC.swift
//  TaskManager
//
//  Created by Hirakjyoti Borah on 29/07/22.
//

import UIKit

class TaskCollectionCVC: UICollectionViewCell {

    @IBOutlet weak private var titleView: UIView!
    @IBOutlet weak private var taskTitle: UILabel!
    @IBOutlet weak private var startDate: UILabel!
    @IBOutlet weak private var endDate: UILabel!
    @IBOutlet weak private var taskDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addDefaultCornerRadius()
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 2
    }
    
    func configure(model: TaskModel) {
        self.taskTitle.text = model.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let startDate = "Start Date:  \(dateFormatter.string(from: model.startDate))"
        let endDate = "End Date:  \(dateFormatter.string(from: model.endDate))"
        
        self.startDate.text = startDate
        self.endDate.text = endDate
        self.taskDetails.text = model.taskDetail
        
        switch model.priority {
        case 0:
            titleView.backgroundColor = .red
        case 1:
            titleView.backgroundColor = .orange
        case 2:
            titleView.backgroundColor = .systemGreen
        default:
            break
        }
    }
}
