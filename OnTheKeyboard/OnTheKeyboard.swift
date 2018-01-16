//
//  OnTheKeyboard.swift
//  OnTheKeyboard
//
//  Created by 1amageek on 2018/01/13.
//  Copyright © 2018年 Stamp Inc. All rights reserved.
//

import UIKit
import Toolbar

/// I referred to this page
/// https://qiita.com/marty-suzuki/items/92e65db593d3081b575b
///

public protocol KeyboardObservable: class {

    var keyboardObservers: [Any] { get set }

    func keyboardWillShow(_ notification: Notification)

    func keyboardDidShow(_ notification: Notification)

    func keyboardWillHide(_ notification: Notification)

    func keyboardDidHide(_ notification: Notification)

    func addKeyboardObservers()

    func removeKeyboardObservers()
}

public extension KeyboardObservable {

    func addKeyboardObservers() {
        keyboardObservers = [
            (.UIKeyboardWillShow, keyboardWillShow(_:)),
            (.UIKeyboardDidShow, keyboardDidShow(_:)),
            (.UIKeyboardWillHide, keyboardWillHide(_:)),
            (.UIKeyboardDidHide, keyboardDidHide(_:))
            ].map { NotificationCenter.default.addObserver(forName: $0, object: nil, queue: .main, using: $1) }
    }

    func removeKeyboardObservers() {
        keyboardObservers.forEach { NotificationCenter.default.removeObserver($0) }
        keyboardObservers.removeAll()
    }
}

public protocol OnTheKeyboard: KeyboardObservable {

    var toolBar: Toolbar { get }

    var toolbarBottomConstraint: NSLayoutConstraint? { get set }

    func keyboardWillLayout(_ frame: CGRect)

    func keyboardDidLayout(_ frame: CGRect)
}

public extension OnTheKeyboard where Self: UIViewController {

    public func showToolBar(_ view: UIView) {
        self.view.addSubview(self.toolBar)
        self.toolbarBottomConstraint = self.view.bottomAnchor.constraint(equalTo: self.toolBar.bottomAnchor, constant: 0)
        self.toolbarBottomConstraint?.isActive = true
    }

    public func keyboardWillShow(_ notification: Notification) {
        moveToolbar(up: true, notification: notification)
    }

    func keyboardWillHide(_ notification: Notification) {
        moveToolbar(up: false, notification: notification)
    }

    public func keyboardDidShow(_ notification: Notification) {

    }

    public func keyboardDidHide(_ notification: Notification) {

    }

    public func keyboardWillLayout(_ frame: CGRect) {

    }

    public func keyboardDidLayout(_ frame: CGRect) {

    }

    public func moveToolbar(up: Bool, notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        self.view.layoutIfNeeded()
        let animationDuration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        //let animationCurve: UIViewAnimationCurve = UIViewAnimationCurve(rawValue: (userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue)!
        let keyboardFrame: CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight: CGFloat = up ? keyboardFrame.height : 0
        self.toolbarBottomConstraint?.constant = keyboardHeight
        self.keyboardWillLayout(keyboardFrame)
        UIView.animate(withDuration: animationDuration, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.keyboardDidLayout(keyboardFrame)
        })
    }
}

