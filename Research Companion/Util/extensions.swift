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
    
    
    func constrain(top: NSLayoutYAxisAnchor?, topConstant: CGFloat?, bottom: NSLayoutYAxisAnchor?, bottomConstant: CGFloat?, leading: NSLayoutXAxisAnchor?, leadingConstant: CGFloat?, trailing: NSLayoutXAxisAnchor?, trailingConstant: CGFloat?){
        
            self.translatesAutoresizingMaskIntoConstraints = false
              
            if let leadingAnchor = leading, let leadC = leadingConstant {
                  self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadC).isActive = true
            }
              
            if let trailingAnchor = trailing, let trailC = trailingConstant {
                  self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -trailC).isActive = true
            }
              
            if let topAnchor = top, let topC = topConstant {
                 self.topAnchor.constraint(equalTo: topAnchor, constant: topC).isActive = true
            }
              
            if let bottomAnchor = bottom, let bottomC = bottomConstant {
                 self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomC).isActive = true
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


class MyCollectionView: UICollectionView{
   
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.clearsContextBeforeDrawing = false
        self.backgroundColor = .white
        self.isScrollEnabled = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



struct Artik{
    var title: String
    var abstract: String
    var date: String
}
