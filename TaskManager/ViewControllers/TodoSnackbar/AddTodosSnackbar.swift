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
    @IBOutlet weak private var titleMsgLabel: UILabel!
    @IBOutlet weak private var detailMsgLabel: UILabel!
    
    var titleText: String = ""
    var todoDetailsText: String = ""
    var completionBlock: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIGestureRecognizer(target: self, action: #selector(dismissBackground))
        dimmingView.isUserInteractionEnabled = true
        dimmingView.addGestureRecognizer(gesture)
        containerView.addDefaultCornerRadius()
        titleTextField.placeholder = "Add Title"
        titleTextField.tintColor = .lightGray
        titleTextField.delegate = self
        taskTextView.delegate = self
        
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
    
    private func validateFields() {
        var titleBool: Bool = false
        var descBool: Bool = false
        
        if titleText.count <= 0 {
            titleMsgLabel.isHidden = false
            titleMsgLabel.text = "Add title"
        } else if titleText.count > 30 {
            titleMsgLabel.isHidden = false
            titleMsgLabel.text = "max 30 character"
        } else {
            titleMsgLabel.isHidden = true
            titleBool = true
        }
        
        if todoDetailsText.count <= 0 {
            detailMsgLabel.isHidden = false
            detailMsgLabel.text = "Add description"
        } else {
            detailMsgLabel.isHidden = true
            descBool = true
        }
        
        if titleBool && descBool {
            if let completion = completionBlock {
                completion(titleText, todoDetailsText)
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func dismissBackground() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        validateFields()
    }
    
    
}

extension AddTodosSnackbar: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.titleText = textField.text ?? ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.titleText = textField.text ?? ""
        titleTextField.endEditing(true)
    }
}

extension AddTodosSnackbar: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.todoDetailsText = textView.text ?? ""
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .black
    }
}
