//
//  ResourceGenerator.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 01/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData
import PDFKit

class ResourceGenerator {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var semaphore = DispatchSemaphore(value: 0)
    var data: Data?
    var urlResponse: HTTPURLResponse?
    
    var coreUKurlString = "https://core.ac.uk:443/api-v2/"
    var springerUrlString = ""
    var arxicUrlString = ""
    
    init() { }
    
    convenience init(urlString: String){
        self.init()
        self.coreUKurlString = urlString
    }

    //MARK: - Singleton Pattern to access other parts of this class, *fault* singletons retain state
    static let shared : ResourceGenerator = {
        let instance = ResourceGenerator()
        return instance
    }()
    
    // MARK: - Set HTTP endpoint and headers
    func createURLRequest(url: String, postBody: Any) -> URLRequest{
        var request = URLRequest(url: URL(string: coreUKurlString + url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postBody, options: [])
        return request
    }
    
    // MARK: - Artcile Search Post Request
    // Post request to search through Articles...
    
    func postSearchArticles(query: [String: Any], completion: @escaping ([MyArticle]? ,Bool) -> Void){
                
        let link = "articles/search?metadata=true&fulltext=false&citations=false&similar=false&duplicate=false&urls=false&faithfulMetadata=false&apiKey=\(valueforAPIkey(named: "API_KEY"))"
        
        AF.request(createURLRequest(url: link, postBody: [query])).responseJSON { (response) in
            
            print("\(#function) \(#line)", response)
            
            var myArticles = [MyArticle]()
            if response.error == nil {
                
                
                
                let resultJSON : JSON = JSON(response.data!)
                
                resultJSON[0]["data"].array?.forEach({ (jsonObject) in
                    
                    let art = MyArticle(json: jsonObject)
                    myArticles.append(art!)
                    
                    
//                    let mArticle = Article(context: self.context)
//
//                    mArticle.id = jsonObject["id"].int32Value
//                    mArticle.year = jsonObject["year"].int16Value
//                    mArticle.datePublished = jsonObject["datePublished"].stringValue
//                    mArticle.abstract = jsonObject["description"].stringValue
//                    mArticle.title = jsonObject["title"].stringValue
//                    mArticle.oai = jsonObject["oai"].stringValue
//                    mArticle.downloadUrl = jsonObject["downloadUrl"].stringValue
//                    mArticle.doi = jsonObject["doi"].stringValue
//                    mArticle.publisher = jsonObject["publisher"].stringValue
//
//                    if jsonObject["authors"].array?.count != 0{
//                        mArticle.authors = jsonObject["authors"].array?.description
//                    }
//
//                    if jsonObject["contributors"].array?.count != 0{
//                        mArticle.contributors = jsonObject["contributors"].array?.description
//                    }
                    
                })
                
                completion(myArticles, true)
//                self.saveData()
                
            }else{
                print(response.error!)
                completion(nil, false)
            }
        }
    }
    
    //  MARK: - Get Request to download Article pdf by Article id..
       
    func postDownloadArticle(byId Id: Int = 191178916, completion: @escaping (Data, Bool) -> Void) {
       
       let link = "articles/get/\(Id)/download/pdf?apiKey=\(valueforAPIkey(named: "API_KEY"))"
       
       AF.request(coreUKurlString + link, method: .get).responseData { (response) in
           
           if response.error == nil {
               
               //response.data is the pdf file in data format..
               if let pdfdata = response.data{
                   completion(pdfdata, true)
               }
               
           }else{
               print(response.error as Any)
               completion(Data(), false)
           }
       }
    }
    
    
    // MARK: - Post Request to get Article(pdf) by id
    // Post Request to get Journal by id, post body is an array of ids,
    // ***** for saved articles
    
    func postGetArticle(byId query: [Int]){
        let link = "articles/get?metadata=true&fulltext=false&citations=false&similar=false&duplicate=false&urls=false&faithfulMetadata=false&apiKey=\(valueforAPIkey(named: "API_KEY"))"
        
        AF.request(createURLRequest(url: link, postBody: query)).responseJSON { (response) in
            
            if response.error == nil{
                
                let resultJSON = JSON(response.data!)
                
                print(resultJSON)
                
               //contains all the Article properties
               // resultJSON["data"]
                
            }
        }
        
    }
    
    // Journal might not be needed, because theres no pdf
    
    // MARK: - Post Request to get Journal By ISSN
    // Post request to get journal by issn, post body is an array of issn
    
    func postGetJournal(byIssn query: [String], completion: @escaping ([MyJournal]?, Bool) -> Void){
         let searchLink = "journals/get?apiKey=\(valueforAPIkey(named: "API_KEY"))"
        
        AF.request(createURLRequest(url: searchLink, postBody: query)).responseJSON { (response) in
            if response.error == nil{
                
                let resultJSON = JSON(response.data!)
                
                print(resultJSON)
                
                var mJournals = [MyJournal]()
  
                resultJSON.array?.forEach({ (json) in
                    
                    let mJourn = MyJournal(json: json["data"])
                    
                    mJournals.append(mJourn!)
                    
//                    let mJournal = Journal(context: self.context)
//
//                    mJournal.title = json["data"]["title"].stringValue
//                    mJournal.language = json["data"]["language"].stringValue
//                    mJournal.rights = json["data"]["rights"].stringValue
//                    mJournal.publisher = json["data"]["publisher"].stringValue
//
//                    let mSubject = JSubject(context: self.context)
//                    var subArray = [String]()
//                    json["data"]["subjects"].array?.forEach({ (subs) in
//                        subArray.append(subs.stringValue)
//                    })
//
//                    mSubject.subs = subArray.description
//                    mSubject.journal = mJournal
//                    mJournal.subjects = mSubject
//
//                    let mIdentifier = JIdentifier(context: self.context)
//
//                    if json["data"]["identifiers"].count == 3{
//                        mIdentifier.oai = json["data"]["identifiers"][0].stringValue
//                        mIdentifier.url = json["data"]["identifiers"][2].stringValue
//                        mIdentifier.issn = json["data"]["identifiers"][1].stringValue
//                    }else{
//                        mIdentifier.oai = json["data"]["identifiers"][0].stringValue
//                        mIdentifier.url = json["data"]["identifiers"][3].stringValue
//
//                        let array = [json["data"]["identifiers"][1], json["data"]["identifiers"][2]]
//                        mIdentifier.issn = array.description
//                    }
//
//                    mIdentifier.journal = mJournal
//                    mJournal.identifiers = mIdentifier
                    
                })
                
                completion(mJournals, true)
//                self.saveData()
                
            }else{
                
                print(response.error as Any)
                completion(nil, false)
                
            }
        }
    }
    
    
     // MARK: - Post Request to Saerch Journal Article
    // Post Request to search through Journals, post body is a dictonary with "query" as key
    
    func postSearchJournals(postBody: [String: String], completion : @escaping ([MyJournal]?, Bool) -> Void){
        let serachLink = "journals/search?apiKey=\(valueforAPIkey(named: "API_KEY"))"

        AF.request(createURLRequest(url: serachLink, postBody: [postBody])).responseJSON { (response) in
           
            var mJournals = [MyJournal]()
            if response.error == nil {
                
                let resultJSON:JSON = JSON(response.data!)
   
                resultJSON[0]["data"].array?.forEach{ (json) in
                    
                    let mJour = MyJournal(json: json)
                    mJournals.append(mJour!)
                }
                
                completion(mJournals, true)
                
//                self.saveData()
                
            }else{
                print(response.error as Any)
                completion(nil, false)
            }
        }
    }
    
    
    // MARK: - Function for retrieving Api key from plist file
    
    func valueforAPIkey(named keyName: String) -> String{
        let pListFilePath = Bundle.main.path(forResource: "Apikeys", ofType: "plist")
        let content = NSDictionary(contentsOfFile: pListFilePath!)
        let val = content?.object(forKey: keyName) as! String
        return val
    }
    
    //MARK: - Save Journal
    func saveJournal(json: JSON){
        
            let mJournal = Journal(context: self.context)
           
           mJournal.title = json["title"].stringValue

           if json["rights"] != JSON.null{
                mJournal.rights = json["rights"].string
           }

           mJournal.language = json["language"].stringValue
           mJournal.publisher = json["publisher"].stringValue
           
           let mIdentifier = JIdentifier(context: self.context)
           
           if  json["identifiers"].arrayValue.count == 3 {
               mIdentifier.oai = json["identifiers"][0].stringValue
               mIdentifier.url = json["identifiers"][2].stringValue
               mIdentifier.issn = json["identifiers"][1].stringValue
           }else{
               mIdentifier.oai = json["identifiers"][0].stringValue
               mIdentifier.url = json["identifiers"][3].stringValue
               
               let array = [json["identifiers"][1], json["identifiers"][2]]
               mIdentifier.issn = array.description
           }
           
           mIdentifier.journal = mJournal
           mJournal.identifiers = mIdentifier
           
           let mSubject = JSubject(context: self.context)
           var subArray = [String]()
           
           json["subjects"].arrayValue.forEach { (json) in
               subArray.append(json.stringValue)
           }
           
           mSubject.subs = subArray.description
           mSubject.journal = mJournal
           
           mJournal.subjects = mSubject
        
//           self.saveData()
    }
    
    
    //MARK: - Save Article
    
    //MARK: - Function to save data to coreData SQLite Database
    
    func saveData(){
       do{
           try context.save()
           print("saved")
       }catch {
           print("An error occured while saving the data: \(error)")
       }
     }
    
    // MARK: - function to convert arrays stored as string back to array
    
    func convertStringToArray(text: String) -> [String]{
        let stringAsData = text.data(using: .utf16)
        if let val = stringAsData{
            let array = try! JSONDecoder().decode([String].self, from: val)
            return array
        }
        return []
    }
    
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



//For checking network

//var networkManager: NetworkReachabilityManager = NetworkReachabilityManager()!
//networkManager.startListening()
//networkManager.listener = { (status) -> Void in
//if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable {
//   print("No internet available")
//}else{
//   print("Internet available")
//}


//                for saving to users document directory, for saving pdf to document folder

//                let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//                let filePath = "\(documentPath)/my.pdf"
//
//                do {
//                    try fullpdfData!.write(to: URL(fileURLWithPath: filePath), options: .atomic)
//                } catch {
//                    print(error)
//                }
//                print(documentPath)
