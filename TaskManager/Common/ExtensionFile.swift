//
//  ExtensionFile.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 10/07/22.
//

import Foundation
import UIKit

extension UIView {
    func addDefaultCornerRadius(_ radius: Double = 4.0) {
        self.layer.cornerRadius = radius
    }
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIResponder {
   
    private static weak var _firstResponder: UIResponder?
    
    static var firstResponder: UIResponder? {
        _firstResponder = nil

        UIApplication.shared.sendAction(#selector(_recordFirstResponder), to: nil, from: nil, for: nil)
        return _firstResponder
    }
    
    @objc private func _recordFirstResponder() {
        UIResponder._firstResponder = self
    }
    
}
