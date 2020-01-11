//
//  AddResearchViewController.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 27/12/2019.
//  Copyright © 2019 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class AddResearchController: UIViewController, UITextFieldDelegate{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var knowlegdeModel: KnowledgeBox?
    var answerModel: AnswerBox?
    var resultModel: Result?
    var organicModelArray = [OrganicLink]()
    var imageModelArray = [ImageLink]()
    var videoModelArray = [VideoLink]()
    var testArray = [Int]()
    
    var tabBarHeight: CGFloat?
    var addView = AddView()
    
    var obs: NSKeyValueObservation?
    
    var showLinks: Bool?
    var showFiles: Bool?
    var showVideos: Bool?
    var showImages: Bool?
    
    var researchName: String = ""
    var queryString: String = ""
    
    private var downloadProgress: Progress? {
        didSet {
            obs?.invalidate()
            addView.progressBar.observedProgress = nil

            guard let progress = downloadProgress else {
                return
            }

            addView.progressBar.observedProgress = progress
            
            print(progress)
            
            //progress bar fraction completed returns 0.5 of complete tasks

            obs = progress.observe(\.fractionCompleted, options: []) { progress, change in
                
                DispatchQueue.main.async {
                    print(progress.fractionCompleted)
                    self.addView.progressBar.setProgress(Float(progress.fractionCompleted), animated: true)
                }
            }
        }
    }

    deinit {
        obs?.invalidate()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.absoluteURL)
        
        tabBarHeight = tabBarController?.tabBar.frame.height
        
        addView.progressBar.addConstraints(top: nil, topConstant: 0, bottom: addView.bottomAnchor, leading: nil, trailing: nil, constant: -tabBarHeight!)

//        addView.progressBar.transform = addView.progressBar.transform.scaledBy(x: 1, y: 6)
        
        addView.createButton.addConstraints(top: nil, topConstant: 0, bottom: addView.bottomAnchor, leading: nil, trailing: nil, constant: -(tabBarHeight! + 30 ))
        
        addView.nameField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        addView.queryField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        addView.switch1.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        addView.switch2.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        addView.switch3.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        addView.switch4.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        addView.createButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        
        showLinks = addView.switch1.isOn
        showFiles = addView.switch2.isOn
        showVideos = addView.switch3.isOn
        showImages = addView.switch4.isOn
        
        print(addView.createButton)
        
        view = addView
        navigationItem.title = "Add"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        
        let tag = textField.tag
        
        if let text = textField.text {
            if tag == 0 {
                researchName = text
            }else{
                queryString = text
            }
        }
    }
    
    @objc func switchChanged(_ swt: UISwitch){
        let tag = swt.tag
        
        if tag == 0 {
            print("Links", swt.isOn)
            showLinks = swt.isOn
        }else if tag == 1{
            print("Files", swt.isOn)
            showFiles = swt.isOn
        }else if tag == 2{
            print("Videos", swt.isOn)
            showVideos = swt.isOn
        }else if tag == 3{
            print("Images", swt.isOn)
            showImages = swt.isOn
        }
        
    }
    
    @objc func submit(_ button: UIButton){
        let tag = button.tag
        print(tag)
        
        testArray = [6,9,9,9,0,7,5,5]
        
        downloadProgress = ResourceGenerator.shared.getResource(queryString: queryString)

//        if let d = ResourceGenerator.shared.data{
//            let json = try! JSON(data: d)
//
//            _ = json["status"]
//
//            let answerBoxJson = json["results"]["results"]["answer_box"]
//            let imagesJson = json["results"]["results"]["inline_images"]
//            let videosJson = json["results"]["results"]["inline_videos"]
//            let knowledgeCardJson = json["results"]["results"]["knowledge_card"]
//            let organicLinksJson = json["results"]["results"]["organic"]
//
//            resultModel = Result(context: self.context)
//            resultModel?.title = "Results for \(queryString)"
//
//            answerModel = AnswerBox(context: self.context)
//            answerModel?.title = answerBoxJson["title"].stringValue
//            answerModel?.answer = answerBoxJson["answer"].stringValue
//            answerModel?.link = answerBoxJson["link"].stringValue
//            answerModel?.result = resultModel
//            resultModel?.answer = answerModel
//
//            imagesJson.arrayValue.forEach { (image) in
//
//                print("Image Key:--------->  ::\(image["image"].stringValue)")
//                let imag = ImageLink(context: self.context)
//                if image["image"] == JSON.null {
//                    print("Null detected")
//                }else{
//                    imag.image = image["image"].stringValue
//                    imag.result = resultModel
//                    imageModelArray.append(imag)
//                }
//                print("image Context: ______> \(String(describing: imag.image))")
//
//
//                resultModel?.addToImageLinks(imag)
//            }
//
//            print(imageModelArray.count)
//            print(imageModelArray)
//
//            for key in videosJson.arrayValue{
//                let videoLink = VideoLink(context: self.context)
//                videoLink.title = key["title"].stringValue
//                videoLink.url = key["url"].stringValue
//                videoLink.channel = key["channel"].stringValue
//                videoLink.source = key["source"].stringValue
//                videoLink.result = resultModel
//                videoModelArray.append(videoLink)
//                resultModel?.addToVideoLinks(videoLink)
//            }
//
//            knowlegdeModel = KnowledgeBox(context: self.context)
//            knowlegdeModel?.title = knowledgeCardJson["title"].stringValue
//            knowlegdeModel?.info = knowledgeCardJson["info"].stringValue
//            knowlegdeModel?.result = resultModel
//            resultModel?.knowledge = knowlegdeModel
//
//            organicLinksJson.arrayValue.forEach { (links) in
//                let organic = OrganicLink(context: self.context)
//                organic.link = links["link"].stringValue
//                organic.title = links["title"].stringValue
//                organic.snippet = links["snippet"].stringValue
//                organic.result = resultModel
//                organicModelArray.append(organic)
//                resultModel?.addToOrganicLinks(organic)
//            }
//
//            print(organicModelArray.count)
//
//            saveData()
            
            let vc = DisplayResultsController()
            vc.title = researchName
            vc.delegate = self
//            vc.links = organicModelArray
//            vc.images = imageModelArray
//            vc.videos = videoModelArray
            vc.testArray = testArray
        
            let vc2 = SegmentedViewController()
            navigationController?.pushViewController(vc2, animated: true)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func saveData(){
        do{
            try context.save()
            print("saved")
        }catch {
            print("An error occured while saving the data: \(error)")
        }
    }
}

extension AddResearchController: dataPassedBetweenControllers{
    
    func sendBackToParent(testArray: [Int]) {
        print(testArray)
    }
    
}
