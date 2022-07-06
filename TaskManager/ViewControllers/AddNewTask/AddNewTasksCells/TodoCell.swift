//
//  TodoCell.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 07/07/22.
//

import UIKit

class TodoCell: UIView {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var radioButton: UIImageView!
    var isTaskDone: Bool = false
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    func customInit() {
        if let view = Bundle.main.loadNibNamed("TodoCell", owner: self, options: nil)?[0] as? TodoCell {
            view.frame = bounds
            addSubview(view)
        }
    }
    
    @objc func onAddButtonClick() {
        if isTaskDone {
            radioButton.image = UIImage(named: "radio_button_unchecked")
        } else {
            radioButton.image = UIImage(named: "radio_button_checked")
        }
        
        isTaskDone = !isTaskDone
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        radioButton.image = UIImage(named: "radio_button_unchecked")
        radioButton.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onAddButtonClick))
        radioButton.addGestureRecognizer(tap)
    }
}
