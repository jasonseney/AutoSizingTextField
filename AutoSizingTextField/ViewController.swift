//
//  ViewController.swift
//  AutoGrowTextView
//
//  Created by Jason Seney on 8/27/15.
//  Copyright (c) 2015 Tumblr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let footer = Container()
        footer.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        view.addSubview(footer)
        
        // Vertical
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[footerView(footerHeight)]",
            options: nil,
            metrics: ["footerHeight" : 50],
            views: ["footerView" : footer])
        )
        
        bottomConstraint = NSLayoutConstraint(item: footer, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        if let bottomConstraint = bottomConstraint {
            view.addConstraint(bottomConstraint)
        }
        
        // Horizontal
        view.addConstraints([
            NSLayoutConstraint(item: footer, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: footer, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 0),
            ])
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardShowing:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardHiding:",
            name: UIKeyboardWillHideNotification,
            object: nil)
        
        let hideKeyboardTapGesture = UITapGestureRecognizer(target: footer.textField, action: "resignFirstResponder")
        self.view.addGestureRecognizer(hideKeyboardTapGesture)
        hideKeyboardTapGesture.cancelsTouchesInView = false
        
    }
    
    func keyboardShowing(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardFrame = userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        if let height = keyboardFrame?.size.height {
            self.bottomConstraint?.constant = -height
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardHiding(notification: NSNotification) {
        self.bottomConstraint?.constant = 0
        self.view.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

