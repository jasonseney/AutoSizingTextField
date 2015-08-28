//
//  Container.swift
//  AutoGrowTextView
//
//  Created by Jason Seney on 8/27/15.
//  Copyright (c) 2015 Tumblr. All rights reserved.
//

import Foundation
import UIKit

class Container : UIView, AutoSizingTextViewDelegate {
    
    var textView: UITextView?
    
    required override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        textView = AutoSizingTextView(maxHeight: 80, sizingDelegate: self)
        
        if let textView = textView {
            textView.textColor = UIColor.blackColor()
            textView.backgroundColor = UIColor.whiteColor()
            textView.font = UIFont.systemFontOfSize(15)
            
            addSubview(textView)
            textView.setTranslatesAutoresizingMaskIntoConstraints(false)
            
            addConstraints([
                NSLayoutConstraint(item: textView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 10),
                NSLayoutConstraint(item: textView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: -10)
                ])
            
            addConstraints(
                NSLayoutConstraint.constraintsWithVisualFormat( "H:|-(padding)-[field]-(padding)-|",
                    options: nil,
                    metrics: ["padding" : 15],
                    views: ["field" : textView]))
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didChangeHeight(height: CGFloat) {
        println("Changing height to: " + height.description)
    }
}