//
//  MyArticle.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 07/02/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import Foundation
import SwiftyJSON

class MyArticle {
    
    var oai : String?
    var doi : String?
    var abstract : String?
    var authors : String?
    var contributors : String?
    var datePublished : String?
    var downloadUrl : String?
    var title: String?
    var id : Int32?
    var year : Int16?
    var publisher : String?
    
    init?(json: JSON) {

        if json != JSON.null{
            self.id = json["id"].int32Value
            self.year = json["year"].int16Value
            self.datePublished = json["datePublished"].stringValue
            self.abstract = json["description"].stringValue
            self.title = json["title"].stringValue
            self.oai = json["oai"].stringValue
            self.downloadUrl = json["downloadUrl"].stringValue
            self.doi = json["doi"].stringValue
            self.publisher = json["publisher"].stringValue
            
            if json["authors"].array?.count != 0{
                self.authors = json["authors"].array?.description
            }
            
            if json["contributors"].array?.count != 0{
                self.contributors = json["contributors"].array?.description
            }
        }
    }
    
}
