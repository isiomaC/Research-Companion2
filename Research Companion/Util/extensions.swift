//
//  extensions.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 30/12/2019.
//  Copyright © 2019 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addConstraints(top: NSLayoutYAxisAnchor?, topConstant: CGFloat, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, constant: CGFloat ){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let leadingAnchor = leading {
            self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant).isActive = true
        }
        
        if let trailingAnchor = trailing {
            self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constant).isActive = true
        }
        
        if let topAnchor = top {
           self.topAnchor.constraint(equalTo: topAnchor, constant: topConstant).isActive = true
        }
        
        if let bottomAnchor = bottom {
           self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: constant).isActive = true
        }
        
    }
}

extension UIImage {
    func resized(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
