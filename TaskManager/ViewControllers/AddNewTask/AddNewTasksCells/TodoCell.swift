//
//  TodoCell.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 07/07/22.
//

import UIKit

protocol TodoCellDelegate: AnyObject {
    func updateSelectedState(todo: Todos)
}

class TodoCell: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var radioButton: UIImageView!
    var todo: Todos?
    
    weak var delegate: TodoCellDelegate?
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
    }
    
    func configure(todo: Todos) {
        self.todo = todo
        self.label.text = todo.title
        setInitialButtonState(todo)
    }
    
    func customInit() {
        Bundle.main.loadNibNamed("TodoCell", owner: self)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    private func setInitialButtonState(_ todo: Todos) {
        if todo.isCompleted {
            radioButton.image = UIImage(named: "radio_button_selected")
        } else {
            radioButton.image = UIImage(named: "radio_button_unselected")
        }
    }

    private func setEndButtonState(_ todo: Todos) {
        if todo.isCompleted {
            radioButton.image = UIImage(named: "radio_button_unselected")
        } else {
            radioButton.image = UIImage(named: "radio_button_selected")
        }
    }
    
    @IBAction func onAddButtonClick() {
        guard let todo = todo else { return }
        setEndButtonState(todo)
        
        todo.isCompleted = !todo.isCompleted
        delegate?.updateSelectedState(todo: todo)
    }
}
