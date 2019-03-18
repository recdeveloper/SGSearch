//
//  MainNavigationViewController.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/15/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
}
