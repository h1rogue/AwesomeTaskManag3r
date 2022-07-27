//
//  PriorityTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

protocol PriorityTVCDelegate: AnyObject {
    func prioritySelected(_ priority: AddNewTaskVM.Priorities)
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
    
    weak var delegate: PriorityTVCDelegate?
    
    var cellPriority: AddNewTaskVM.Priorities?
    
    func configure(cellPriority: AddNewTaskVM.Priorities) {
   
        switch cellPriority {
        case .p0(let err):
            if let err = err {
                errorMsgLabel.text = err.rawValue
                errorMsgLabel.isHidden = false
            } else {
                 errorMsgLabel.isHidden = true
            }
            poView.backgroundColor = .red
            poLabel.textColor = .white
        case .p1(let err):
            if let err = err {
                errorMsgLabel.text = err.rawValue
                errorMsgLabel.isHidden = false
            } else {
                errorMsgLabel.isHidden = true
            }
            p1View.backgroundColor = .orange
            p1Lbel.textColor = .white
        case .p2(let err):
            if let err = err {
                errorMsgLabel.text = err.rawValue
                errorMsgLabel.isHidden = false
            } else {
                errorMsgLabel.isHidden = true
            }
            p2View.backgroundColor = .systemGreen
            p2Label.textColor = .white
        }
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
        guard let cellPriority = cellPriority else { return }
        switch cellPriority {
        case .p0:
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
        if cellPriority != .p0() {
            cellPriority = .p0()
            unselectOther()
            delegate?.prioritySelected(.p0())
        }
    }

    @IBAction private func p1Clicked() {
        if cellPriority != .p1() {
            cellPriority = .p1()
            unselectOther()
            delegate?.prioritySelected(.p1())
        }
    }
    
    @IBAction private func p2Clicked() {
        if cellPriority != .p2() {
            cellPriority = .p2()
            unselectOther()
            delegate?.prioritySelected(.p2())
        }
    }
}
