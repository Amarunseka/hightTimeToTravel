//
//  UIViewExtensions.swift
//  hightTimeToTravel
//
//  Created by Миша on 30.05.2022.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views:[UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
