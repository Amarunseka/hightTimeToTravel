//
//  UIImageView.swift
//  hightTimeToTravel
//
//  Created by Миша on 31.05.2022.
//

import UIKit

extension UIImageView {
    
    static func likeImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = #colorLiteral(red: 0.4235294118, green: 0.06666666667, blue: 0.7882352941, alpha: 1)
        return imageView
    }
}
