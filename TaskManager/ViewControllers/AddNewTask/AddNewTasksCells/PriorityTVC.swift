//
//  PriorityTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

enum TaskPriority {
    case po,p1,p2
}

class PriorityTVC: UITableViewCell {

    @IBOutlet weak private var poButton: UIButton!
    @IBOutlet weak private var p1Button: UIButton!
    @IBOutlet weak private var p2Button: UIButton!
    @IBOutlet weak private var notifyButton: UIView!
    @IBOutlet weak private var poView: UIView!
    @IBOutlet weak private var p1View: UIView!
    @IBOutlet weak private var p2View: UIView!
    @IBOutlet weak private var errorMsgLabel: UILabel!
    
    @IBOutlet weak private var poLabel: UILabel!
    @IBOutlet weak private var p1Lbel: UILabel!
    @IBOutlet weak private var p2Label: UILabel!
    
    var cellPriority: TaskPriority = .p2
    
    
    func configure(cellPriority: TaskPriority) {
        self.cellPriority = cellPriority
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        poView.layer.borderWidth = 1
        poView.layer.borderColor = UIColor.red.cgColor
        
        p1View.layer.borderWidth = 1
        p1View.layer.borderColor = UIColor.orange.cgColor
        
        p2View.layer.borderWidth = 1
        p2View.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        poView.addDefaultCornerRadius()
        p1View.addDefaultCornerRadius()
        p2View.addDefaultCornerRadius()
        self.notifyButton.layer.cornerRadius = self.notifyButton.frame.height/2
    }
    
    private func unselectOther() {
        var a: Int
        switch cellPriority {
        case .po:
            poView.backgroundColor = .red
            poLabel.textColor = .white
            a = 0
        case .p1:
            p1View.backgroundColor = .orange
            p1Lbel.textColor = .white
            a = 1
        case .p2:
            p2View.backgroundColor = .systemGreen
            p2Label.textColor = .white
            a = 2
        }
        
        for i in 0...2 {
            if i != a {
                switch i {
                case 0:
                    poView.backgroundColor = .white
                    poLabel.textColor = .black
                case 1:
                    p1View.backgroundColor = .white
                    p1Lbel.textColor = .black
                case 2:
                    p2View.backgroundColor = .white
                    p2Label.textColor = .black
                default:
                    break
                }
            }
        }
    }
    
    @IBAction private func poClicked() {
        cellPriority = .po
        unselectOther()
    }

    @IBAction private func p1Clicked() {
        cellPriority = .p1
        unselectOther()
    }
    
    @IBAction private func p2Clicked() {
        cellPriority = .p2
        unselectOther()
    }
}
