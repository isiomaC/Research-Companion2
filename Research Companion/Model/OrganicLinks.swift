//
//  Result.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 06/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import Foundation
import CoreData

class OrganicLinks{
    
    var links: [OrganicLinks]?
    
    static let sharedInstance : OrganicLinks = {
        var instance = OrganicLinks()
        return instance
    }()
    
}
