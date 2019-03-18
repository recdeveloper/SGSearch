//
//  UIViewController+Tools.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/15/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    class func main() -> UIStoryboard {
        guard let infoList = Bundle.main.infoDictionary,
            let storyboardName = infoList["UIMainStoryboardFile"] as? String else {
            fatalError("Main Storyboard must exist")
        }
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }
    
    //@REQUIRE: the UIViewController's Storyboard ID MUST be the same as its class name
    //@REQUIRE: the UIViewController MUST be part of the given Storyboard
    func instantiate<T: UIViewController>() -> T {
        guard let viewController: T = instantiateViewController(withIdentifier: (String(describing: T.self))) as? T else {
            fatalError("Must Ensure a successful Storyboard View Controller is returned")
        }
        return viewController
    }
    
}
