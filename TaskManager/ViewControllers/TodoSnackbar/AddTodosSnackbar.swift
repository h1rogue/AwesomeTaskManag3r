//
//  AddTodosSnackbar.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 15/07/22.
//

import UIKit

class AddTodosSnackbar: UIViewController {

    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var dimmingView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var taskLabel: UILabel!
    @IBOutlet weak private var taskTextView: UITextView!
    @IBOutlet weak private var cancelButton: UIButton!
    @IBOutlet weak private var saveButton: UIButton!
    @IBOutlet weak private var seperatorView: UIView!
    @IBOutlet weak private var seperatorHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIGestureRecognizer(target: self, action: #selector(dismissBackground))
        dimmingView.isUserInteractionEnabled = true
        dimmingView.addGestureRecognizer(gesture)
        containerView.addDefaultCornerRadius()
        titleTextField.placeholder = "Add Title"
        titleTextField.tintColor = .lightGray
        titleTextField.delegate = self
        
        addKeyboardNotification()
    }
    
    @objc private func detectKeyboardComingUp(_ sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        var viewFrame: CGRect
        
        if let responder = UIResponder.firstResponder as? UITextField {
            let responderFrame = responder.frame
            let convFrame = self.view.convert(responderFrame, from: responder.superview)
            viewFrame = convFrame
        } else if let responder = UIResponder.firstResponder as? UITextView {
            let responderFrame = responder.frame
            let convFrame = self.view.convert(responderFrame, from: responder.superview)
            viewFrame = convFrame
        } else {
            return
        }
        
        if keyboardFrame.cgRectValue.intersects(viewFrame) {
            self.seperatorHeight.constant = keyboardFrame.cgRectValue.height
            self.view.layoutIfNeeded()
        }
        return
    }

    @objc private func detectKeyboardGoingDown(_ sender: NSNotification) {
        self.seperatorHeight.constant = 10
        self.view.layoutIfNeeded()
        return
    }
    
    private func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(detectKeyboardComingUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(detectKeyboardGoingDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissBackground() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
    }
}

extension AddTodosSnackbar: UITextFieldDelegate {
    
}
