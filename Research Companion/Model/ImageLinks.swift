//
//  ImageLinks.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 06/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import Foundation
import CoreData

class ImageLinks{
    
    var links: [ImageLink]?
    
    static let sharedInstance: ImageLinks = {
        var instance = ImageLinks()
        return instance
    }()
    
}
