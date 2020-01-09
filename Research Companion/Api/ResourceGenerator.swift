//
//  ResourceGenerator.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 01/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import Foundation

class ResourceGenerator {
    
    var semaphore = DispatchSemaphore (value: 0)
    var data: Data?
    var urlResponse: HTTPURLResponse?
    
    init() { }

    static let shared : ResourceGenerator = {
        let instance = ResourceGenerator()
        return instance
    }()

    func getResource(queryString: String) -> Progress {
        
        let parameters = [
            "data": [
                "domain": "google.co.uk",
                "lang": "en",
                "q": queryString,
                "loc": "Aarau,Aargau,Switzerland",
                "device": "desktop",
                "serp_type": "web"
            ]] as [String : Any]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        var request = URLRequest(url: URL(string: "https://api.serphouse.com/serp/live")!, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer 0BmIOWTf76AaEWmGbHa7ly7UWq29e9HVV10aZoZK0WqXm8wluVVdWoQw1k5z", forHTTPHeaderField: "Authorization")

        request.httpMethod = "POST"
        request.httpBody = postData as Data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
//          print(String(data: data, encoding: .utf8)!)
          self.data = data
          self.urlResponse = response as? HTTPURLResponse
          self.semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return task.progress
    }
    
}
