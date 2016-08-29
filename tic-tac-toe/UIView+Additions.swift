//
//  UIView+Additions.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/25/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

extension UIView {
    /// don't set a nib's owner. set a view's class to the one being loaded
    class func fromNib<T : UIView>() -> T {
        return NSBundle.mainBundle().loadNibNamed(String(T), owner: nil, options: nil)[0] as! T
    }
    
    /// set a view class as it's nib owner. don't set any class to the view itself. 
    /// your view will act as a content view
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName(), bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        addSubview(view)
        return view
    }
    
    func nibName() -> String {
        return String(self.dynamicType)
    }
}