//
//  AutoSizingTextView.swift
//  AutoSizingTextView
//
//  Created by Jason Seney on 8/28/15.
//  Copyright (c) 2015 JasonSeney. All rights reserved.
//

import Foundation
import UIKit

protocol AutoSizingTextViewDelegate {
    func didChangeHeight(height: CGFloat)
}

class AutoSizingTextView: UITextView, UITextViewDelegate {
    
    let sizingDelegate: AutoSizingTextViewDelegate
    let maxHeight: CGFloat
    
    init(maxHeight: CGFloat, sizingDelegate: AutoSizingTextViewDelegate) {
        self.sizingDelegate = sizingDelegate
        self.maxHeight = maxHeight
        
        super.init(frame: CGRectZero, textContainer: nil)
        
        self.delegate = self
        self.scrollEnabled = false
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func calcSize() -> CGSize {
        return self.sizeThatFits(CGSize(width: self.bounds.width, height: CGFloat.max))
    }
    
    override func intrinsicContentSize() -> CGSize {
        return calcSize()
    }
    
    func textViewDidChange(textView: UITextView) {
        
        let newSize = calcSize()
        
        if newSize.height > self.maxHeight {
            self.scrollEnabled = true
        } else {
            self.scrollEnabled = false
        }
        
        let oldHeight = self.frame.height
        
        self.updateConstraints()
        
        if oldHeight != newSize.height {
            sizingDelegate.didChangeHeight(newSize.height)
        }
    }
}