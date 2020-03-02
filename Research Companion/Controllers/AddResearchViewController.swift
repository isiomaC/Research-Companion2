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

class AddResearchController: MyViewController, UITextFieldDelegate{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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
        
//        ResourceGenerator.shared.postGetArticle(byId: [161432985])
        
        let resultVC = SegmentedViewController()
        resultVC.delegate = self
        
        startActivityIndicator()
        
        ResourceGenerator.shared.postSearchArticles(query: ["query": queryString]) { (articles, success) in
            if success {
                self.stopActivityIndicator()
                resultVC.articleData = articles
                resultVC.researchName = self.researchName
                print(articles)
                print(success)
                resultVC.queryString = self.queryString
                self.navigationController?.pushViewController(resultVC, animated: true)
            }else{
                
                print(success)
                self.stopActivityIndicator()
                
                //MARK: - display error message in as a toast..
                
                print("failed to retrieve data")
            }
        }
        
        
        ResourceGenerator.shared.postSearchJournals(postBody: ["query": queryString]) { (journals, success) in
            if success {
                resultVC.journalData = journals
            }else{
                print("failed to retrieve data")
            }
        }
        
//         ResourceGenerator.shared.postGetJournal(byIssn: ["issn:2165-4069", "issn:0975-900X", "issn:1137-3601" ])

//            let vc = DisplayResultsController()
//            vc.title = researchName
//            vc.delegate = self
//
//            vc.testArray = testArray
        
            //set view pager back after tesing pdf view
            
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

extension AddResearchController: dataPassedBetweenControllers, pdfDataGottenFromSendingView, SegmentedControllerDataSource {
    
    func sendBackData() {
        
    }
    
    
    func sendBackToParent(testArray: [Int]) {
        print(testArray)
    }
    
    func sendBack(gotData: Int) {
        print(gotData)
    }
    
}
