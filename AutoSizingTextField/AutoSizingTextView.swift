//
//  AutoSizingTextView.swift
//  AutoSizingTextView
//
//  Created by Jason Seney on 8/28/15.
//  Copyright (c) 2015 JasonSeney. All rights reserved.
//

import Foundation
import UIKit

class AutoSizingTextView: UITextView, UITextViewDelegate {
    
    init() {
        super.init(frame: CGRectZero, textContainer: nil)
        self.delegate = self
        self.scrollEnabled = false
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func intrinsicContentSize() -> CGSize {
        
        let newSize = self.sizeThatFits(CGSize(width: CGFloat.max, height: CGFloat.max))
        println(newSize)
        return newSize
    }
    
    func textViewDidChange(textView: UITextView) {
        textView.sizeToFit()
    }
}