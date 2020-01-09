//
//  VideoLinks.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 06/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import Foundation
import CoreData

//USeful fro querying
class VideoLinks{
    
    var links: [VideoLink]?
    
    static let sharedInstance: VideoLinks = {
        let instance = VideoLinks()
        return instance
    }()
}
