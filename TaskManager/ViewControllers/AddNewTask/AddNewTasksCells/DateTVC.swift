//
//  DateTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

class DateTVC: UITableViewCell {
    

    @IBOutlet weak private var startDateText: UILabel!
    @IBOutlet weak private var startDateLabel: UILabel!
    @IBOutlet weak private var endDateText: UILabel!
    @IBOutlet weak private var endDateLabel: UILabel!
    @IBOutlet weak private var notifyButton1: UIView!
    @IBOutlet weak private var notifyButton2: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.startDateLabel.text = dateFormatter.string(from: date)
        self.endDateLabel.text = dateFormatter.string(from: date)
        notifyButton1.layer.cornerRadius = notifyButton1.frame.height/2
        notifyButton2.layer.cornerRadius = notifyButton2.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
