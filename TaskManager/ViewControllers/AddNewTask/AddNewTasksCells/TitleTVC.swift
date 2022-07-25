//
//  TitleTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

protocol TitleTVCDelegate: AnyObject {
    func updateTitle(title: String)
}

class TitleTVC: UITableViewCell {
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var notifyButton: UIView!
    @IBOutlet weak private var textField: UITextField!
    @IBOutlet weak private var errorMsgLabel: UILabel!
    
    weak var delegate: TitleTVCDelegate?
    var titleText: String = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        configure()
    }
    
    func configure() {
        self.titleLabel.text = "Title"
        self.textField.placeholder = "Add Title"
        self.notifyButton.layer.cornerRadius = self.notifyButton.frame.height/2
        self.textField.borderStyle = .none
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.titleText = textField.text ?? ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.updateTitle(title: textField.text ?? "")
    }
}
