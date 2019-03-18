//
//  UINavigationBar+LargeTitle.swift
//  SeatGeekSearch
//
//  Created by Rob Caraway on 3/18/19.
//  Copyright © 2019 Rob Caraway. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func fitLargeTitleToSize(title: String) {
        let margins: CGFloat = 60
        let maxWidth: CGFloat = UIScreen.main.bounds.size.width - margins
        var fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        var width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
        while width > maxWidth {
            fontSize -= 1
            width = title.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]).width
        }
        largeTitleTextAttributes =
            [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)
        ]
    }
}

extension UINavigationItem {
    func hideBackButtonText() {
        let margins: CGFloat = 44.0
        let labelWidth = UIScreen.main.bounds.width - margins - (UIApplication.shared.keyWindow?.safeAreaInsets.left ?? 0 + (UIApplication.shared.keyWindow?.safeAreaInsets.right ?? 0) )
        let label = UILabel(frame: CGRect(x:0, y:0, width:labelWidth, height:100))
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .left
        label.text = "        "
        titleView = label
    }
}
