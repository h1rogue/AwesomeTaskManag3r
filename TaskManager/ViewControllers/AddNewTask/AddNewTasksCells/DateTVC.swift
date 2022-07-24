//
//  DateTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

protocol DateTVCDelegate: AnyObject {
    func editDateClicked(dateType: DateType)
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
  
    weak var delegate: DateTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func setupCell() {
        notifyButton1.layer.cornerRadius = notifyButton1.frame.height/2
        notifyButton2.layer.cornerRadius = notifyButton2.frame.height/2
    }
    
    func configure() {
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
