//
//  PriorityTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

class PriorityTVC: UITableViewCell {

    @IBOutlet weak private var poButton: UIButton!
    @IBOutlet weak private var p1Button: UIButton!
    @IBOutlet weak private var p2Button: UIButton!
    @IBOutlet weak private var notifyButton: UIView!
    
    @IBAction private func poClicked() {
        
    }

    @IBAction private func p1Clicked() {
        
    }
    
    @IBAction private func p2Clicked() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.notifyButton.layer.cornerRadius = self.notifyButton.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
