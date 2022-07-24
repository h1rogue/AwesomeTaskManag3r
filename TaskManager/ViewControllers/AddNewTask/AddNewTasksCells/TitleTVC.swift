//
//  TitleTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

class TitleTVC: UITableViewCell {
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var notifyButton: UIView!
    @IBOutlet weak private var textField: UITextField!
    @IBOutlet weak private var errorMsgLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    func configure() {
        self.titleLabel.text = "Title"
        self.textField.placeholder = "Add Title"
        self.notifyButton.layer.cornerRadius = self.notifyButton.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TitleTVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.contentView.endEditing(true)
        return true
    }
}
