//
//  MyJournal.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 07/02/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import SwiftyJSON
import Foundation

class MyJournal: NSObject {
    
    var title: String?
    var language: String?
    var publisher: String?
    var subjects: String?
    var rights : String?
    var identifiers : [String : String]?
    
    init?(json: JSON) {
       self.title = json["title"].string
       self.language = json["language"].string
       self.rights = json["rights"].string
       self.publisher = json["publisher"].string
       self.subjects = json["subjects"].array?.description
       
        if json["identifiers"].count == 3 {
            self.identifiers = ["oai": json["identifiers"][0].stringValue,
                                "issn" : json["identifiers"][1].stringValue,
                                "url" : json["identifiers"][2].stringValue
                               ]
        }else{
            self.identifiers = [
                "oai" : json["identifiers"][0].stringValue,
                "url" : json["identifiers"][3].stringValue,
                "issn" : [json["identifiers"][1].stringValue, json["identifiers"][2].stringValue].description
            ]
        }
    }

}
