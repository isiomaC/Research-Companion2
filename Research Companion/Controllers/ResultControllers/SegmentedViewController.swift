//
//  BaseViewController.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 09/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip
import MXSegmentedPager

protocol SegmentedControllerDataSource {
    func sendBackData()
}

class SegmentedViewController: MXSegmentedPagerController{
    
    let pagerData = ["articles", "journals"]
    
    var articleData : [MyArticle]?
    
    var journalData : [MyJournal]?
    
    var researchName : String?
    
    var queryString: String?
    
    var delegate : SegmentedControllerDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Article Data from SegmentedController", articleData!.count)

        if let jdata = journalData{
            print("Journal data from SegmentedController", jdata.count)
        }
        
//        navigationController?.hidesBarsOnSwipe = true
        
//        segmentedPager.parallaxHeader.view = imgView
//        segmentedPager.parallaxHeader.height = 200
//        segmentedPager.parallaxHeader.mode = .center
//        segmentedPager.parallaxHeader.minimumHeight = screenSize.height/3
    
        segmentedPager.scrollToTop(animated: true)
        segmentedPager.segmentedControl.indicator.linePosition = .bottom
        segmentedPager.segmentedControl.textColor = .white
        segmentedPager.segmentedControl.selectedTextColor = .systemBlue
        segmentedPager.segmentedControl.indicator.lineView.backgroundColor = .systemBlue
        segmentedPager.segmentedControl.bounces = true
       
    }
    
    @objc func tapped(_ view: UIView){
        print("tapped")
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return pagerData[index]
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
        print("\(parallaxHeader.progress)")
    }
    
    override func numberOfPages(in segmentedPager: MXSegmentedPager) -> Int {
        return pagerData.count
    }
    
    override func segmentedPagerShouldScrollToTop(_ segmentedPager: MXSegmentedPager) -> Bool {
        return true
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, viewControllerForPageAt index: Int) -> UIViewController {
        
        
        if pagerData[index] == "articles"{
            let articleController = ArticleViewController()
            self.addChild(articleController)
            articleController.articleData = articleData
            articleController.queryString = queryString
            articleController.researchName = researchName
            return articleController
        }
        
        let journalController = JournalViewController()
        self.addChild(journalController)
        journalController.journalData = journalData
        return journalController
    }

}

extension SegmentedViewController{
   
    
}
