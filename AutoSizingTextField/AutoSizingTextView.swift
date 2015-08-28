//
//  AutoSizingTextView.swift
//  AutoSizingTextView
//
//  Created by Jason Seney on 8/28/15.
//  Copyright (c) 2015 JasonSeney. All rights reserved.
//

import Foundation
import UIKit

protocol SizingTextViewDelegate {
    func isChangingSize(textView: UITextView)
}

class AutoSizingTextView: UITextView, UITextViewDelegate {
    
    let sizingDelegate: SizingTextViewDelegate
    
    init(sizingDelegate: SizingTextViewDelegate) {
        self.sizingDelegate = sizingDelegate
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
        sizingDelegate.isChangingSize(textView)
        
        let newSize = calcSize()
        
        if newSize.height > 100 {
            self.scrollEnabled = true
        } else {
            self.scrollEnabled = false
        }
        
        self.updateConstraints()
    }
}