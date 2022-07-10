//
//  TodoTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

class TodoTVC: UITableViewCell {
    @IBOutlet weak private var stackView: UIStackView!
    @IBOutlet weak private var notifyButton: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.notifyButton.layer.cornerRadius = self.notifyButton.frame.height/2
    }
    
    func configure() {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
