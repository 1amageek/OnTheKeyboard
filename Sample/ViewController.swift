//
//  ViewController.swift
//  Sample
//
//  Created by 1amageek on 2018/01/13.
//  Copyright © 2018年 Stamp Inc. All rights reserved.
//

import UIKit
import Toolbar

class ViewController: UIViewController, OnTheKeyboard {

    var keyboardObservers: [Any] = []

    var toolBar: Toolbar = Toolbar()

    var toolbarBottomConstraint: NSLayoutConstraint?

    private(set) lazy var textView: UITextView = {
        let textView: UITextView = UITextView(frame: .zero)
        return textView
    }()

    override func loadView() {
        super.loadView()
        showToolBar(view)
        self.toolBar.setItems([ToolbarItem(customView: self.textView)], animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addKeyboardObservers()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObservers()
    }
}

