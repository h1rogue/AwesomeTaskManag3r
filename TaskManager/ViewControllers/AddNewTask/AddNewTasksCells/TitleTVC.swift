//
//  TitleTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

class TitleTVC: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var notifyButton: UIView!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        self.titleLabel.text = "title"
        self.textField.placeholder = "Add Title"
        self.notifyButton.layer.cornerRadius = self.notifyButton.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
