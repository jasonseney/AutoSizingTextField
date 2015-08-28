//
//  Container.swift
//  AutoGrowTextView
//
//  Created by Jason Seney on 8/27/15.
//  Copyright (c) 2015 Tumblr. All rights reserved.
//

import Foundation
import UIKit

class PaddedTextField: UITextField {
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return self.textRectForBounds(bounds)
    }
    
}

class Container : UIView {
   
    let textField = PaddedTextField()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 193/255, green: 225/255, blue: 238/255, alpha: 1.0)
        
        textField.placeholder = "Type all the text here!"
        textField.textColor = UIColor.blackColor()
        textField.backgroundColor = UIColor.whiteColor()
        textField.font = UIFont.systemFontOfSize(15)
        
        addSubview(textField)
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        addConstraints([
            NSLayoutConstraint(item: textField, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: textField, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: -10)
            ])
        
        addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat( "H:|-(padding)-[field]-(padding)-|",
                options: nil,
                metrics: ["padding" : 15],
                views: ["field" : textField]))

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}