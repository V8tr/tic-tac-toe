//
//  UIViewController+Additions.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/29/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable {
    static var storyboardIdentifier: String { get }
    static var storyboardName: String { get }

    static func fromStoryboard<T : UIViewController>() -> T
}

extension UIViewController: StoryboardInstantiable {
    class var storyboardName: String {
        return NSBundle.mainBundle().infoDictionary?["UIMainStoryboardFile"] as! String
    }
    
    class var storyboardIdentifier: String {
        let classString = NSStringFromClass(self)
        let components = classString.componentsSeparatedByString(".")
        assert(components.count > 0, "Failed extract class name from \(classString)")
        return components.last!
    }
    
    static func fromStoryboard<T : UIViewController>() -> T {
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(self.storyboardIdentifier) as! T
    }
}