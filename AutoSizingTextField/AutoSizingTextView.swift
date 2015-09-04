//
//  AutoSizingTextView.swift
//  AutoSizingTextView
//
//  Created by Jason Seney on 8/28/15.
//  Copyright (c) 2015 JasonSeney. All rights reserved.
//

import Foundation
import UIKit

/**
*  A delegate to handle specific functionality related to the resizing of a text view.
*/
protocol AutoSizingTextViewDelegate : UITextViewDelegate {
    /**
    Handle a change in an auto sizing text view's height
    
    :param: changeInHeight The number of points the height changed. (Positive if growing, negative if shrinking)
    */
    func didChangeHeight(changeInHeight: CGFloat)
}

class AutoSizingTextView: UITextView, UITextViewDelegate {
    
    // An optional delegate used to handle specific resizing actions
    private weak var sizingDelegate: AutoSizingTextViewDelegate?
    
    // The maximum height value to grow to, after which the view starts to scroll
    private let maxHeight: CGFloat
    
    // Sensible default for convience so the textview doesn't grow out of control
    static private let defaultMaxHeight = CGFloat(100)
    
    /**
    Creates a new instance of an auto sizing text view
    
    :param: maxHeight      The max height to grow to, afterwhich the text view scrolls. Defaults to 100.
    :param: sizingDelegate An optional delegate to
    
    :returns: A new instance of an auto sizing text view
    */
    init(maxHeight: CGFloat = AutoSizingTextView.defaultMaxHeight, sizingDelegate: AutoSizingTextViewDelegate?) {
        self.sizingDelegate = sizingDelegate
        self.maxHeight = maxHeight
        
        super.init(frame: CGRectZero, textContainer: nil)
        
        self.delegate = self
        self.scrollEnabled = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    Calculates the size that fits all the text based on the
    current width of this view.
    
    :returns: The width and height that can fit all the text
    */
    private func calcSize() -> CGSize {
        let fittedSize = sizeThatFits(CGSize(width: self.bounds.width, height: maxHeight))
        
        /**
        * Make sure that the fitted size is ACTUALLY shorter than our max height
        * Surprisingly, sizeThatFits CAN RETURN a size that is taller than the height of the size passed in.
        */
        return fittedSize.height <= maxHeight ? fittedSize : CGSize(width:self.bounds.width, height: maxHeight)
    }
    
    // MARK - UIView
    
    override func intrinsicContentSize() -> CGSize {
        return calcSize()
    }
    
    // MARK - UITextViewDelegate
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return sizingDelegate?.textView?(textView, shouldChangeTextInRange: range, replacementText: text) ?? true
    }
    
    func textViewDidChange(textView: UITextView) {
        
        var newHeight = calcSize().height
        let oldHeight = self.frame.height
        
        // When we've maxed out, turn scrolling on
        if newHeight >= maxHeight {
            scrollEnabled = true
        }
        else {
            scrollEnabled = false
        }
        
        updateConstraints()
        
        let changeInHeight = newHeight - oldHeight
        if changeInHeight != 0 {
            sizingDelegate?.didChangeHeight(changeInHeight)
        }
    }

}