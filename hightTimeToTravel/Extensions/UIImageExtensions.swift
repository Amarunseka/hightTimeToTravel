//
//  UIImageExtensions.swift
//  hightTimeToTravel
//
//  Created by Миша on 31.05.2022.
//

import UIKit

extension UIImage {
    
    static let likeImage = {
        UIImage(systemName: "hand.thumbsup.fill")?.withRenderingMode(.alwaysTemplate)
    }
    
    static let unLikeImage = {
        UIImage(systemName: "hand.thumbsup")?.withRenderingMode(.alwaysTemplate)

    }
}
