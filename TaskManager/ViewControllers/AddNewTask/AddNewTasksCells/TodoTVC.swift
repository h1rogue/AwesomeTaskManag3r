//
//  TodoTVC.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 06/07/22.
//

import UIKit

protocol TodoTVCDelegate: AnyObject {
    func presentNewTodoSnckbar()
}

class TodoTVC: UITableViewCell {
    @IBOutlet weak private var stackView: UIStackView!
    @IBOutlet weak private var notifyButton: UIView!
    @IBOutlet weak private var stackHeightConstraint: NSLayoutConstraint!

    weak var delegate: TodoTVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.notifyButton.layer.cornerRadius = self.notifyButton.frame.height/2
        addButton()
    }
    
    func addButton() {
        let button = UIButton()
        button.setTitle("Add New Todo", for: .normal)
        button.backgroundColor = .black
        button.addDefaultCornerRadius()
        stackView.addArrangedSubview(button)
        
        let addButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped))
        button.addGestureRecognizer(addButtonTapGesture)
    }
    
    @objc func addButtonTapped() {
        delegate?.presentNewTodoSnckbar()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
