//
//  DateTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

protocol DateTVCDelegate: AnyObject {
    func editDateClicked(timeLine: AddNewTaskVM.TimeLineSection)
}

enum DateType {
    case start
    case end
}

class DateTVC: UITableViewCell {
    
    @IBOutlet weak private var startDateText: UILabel!
    @IBOutlet weak private var endDateText: UILabel!
    @IBOutlet weak private var notifyButton1: UIView!
    @IBOutlet weak private var notifyButton2: UIView!
    @IBOutlet weak private var startDatePicker: UIDatePicker!
    @IBOutlet weak private var endDatePicker: UIDatePicker!
    

    var startDateEdited: Bool = false
    var endDateEdited: Bool = false
    
    weak var delegate: DateTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        startDatePicker.addDefaultCornerRadius()
        endDatePicker.addDefaultCornerRadius()
    }
    
    func setupCell() {
        notifyButton1.layer.cornerRadius = notifyButton1.frame.height/2
        notifyButton2.layer.cornerRadius = notifyButton2.frame.height/2
        startDatePicker.layer.borderColor = UIColor.black.cgColor
        startDatePicker.layer.borderWidth = 1
        endDatePicker.layer.borderColor = UIColor.black.cgColor
        endDatePicker.layer.borderWidth = 1
        
        startDatePicker.addTarget(self, action: #selector(startDateSelected), for: .editingDidEnd)
        endDatePicker.addTarget(self, action: #selector(endDateSelected), for: .editingDidEnd)
        
        delegate?.editDateClicked(timeLine: AddNewTaskVM.TimeLineSection(startDate: Date(), endDate: Date()))
    }
    
    @objc func startDateSelected() {
        startDateEdited = true
        if endDateEdited {
            delegate?.editDateClicked(timeLine: AddNewTaskVM.TimeLineSection(startDate: startDatePicker.date, endDate: endDatePicker.date))
        }
    }
    
    @objc func endDateSelected() {
        endDateEdited = true
        if startDateEdited {
            delegate?.editDateClicked(timeLine: AddNewTaskVM.TimeLineSection(startDate: startDatePicker.date, endDate: endDatePicker.date))
        }
    }
    
    func configure() {
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
