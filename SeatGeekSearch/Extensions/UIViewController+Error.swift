//
//  UIViewController+Error.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/18/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showError(title: String){
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
