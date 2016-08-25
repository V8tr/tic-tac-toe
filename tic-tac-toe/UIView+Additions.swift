//
//  UIView+Additions.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/25/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T : UIView>() -> T {
        return NSBundle.mainBundle().loadNibNamed(String(T), owner: nil, options: nil)[0] as! T
    }
    
    func nibName() -> String {
        return String(self.dynamicType)
    }
    
    func loadViewFromOwnedNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName(), bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        addSubview(view)
        return view
    }
}