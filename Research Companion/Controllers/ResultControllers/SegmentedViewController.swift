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

class SegmentedViewController: MXSegmentedPagerController{
    
    let pagerData = ["videos", "pdf", "images", "links"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnSwipe = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
     
        let res = ResultsView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 200))
        
        
//        segmentedPager.parallaxHeader.view = imgView
//        segmentedPager.parallaxHeader.height = 200
//        segmentedPager.parallaxHeader.mode = .center
//        segmentedPager.parallaxHeader.minimumHeight = screenSize.height/3
        
        segmentedPager.scrollToTop(animated: true)
        segmentedPager.segmentedControl.indicator.linePosition = .bottom
        segmentedPager.segmentedControl.textColor = .white
        segmentedPager.segmentedControl.selectedTextColor = .red
        segmentedPager.segmentedControl.indicator.lineView.backgroundColor = .red
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
        return 4
    }
    
    override func segmentedPagerShouldScrollToTop(_ segmentedPager: MXSegmentedPager) -> Bool {
        return true
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, viewControllerForPageAt index: Int) -> UIViewController {
        
        if pagerData[index] == "videos"{
            let viewC = SentimentViewController()
            return viewC
            
        }else if pagerData[index] == "pdf"{
            let viewC = PdfViewController()
            return viewC
            
        }else if pagerData[index] == "images"{
            let viewC = ImagesViewController()
            return viewC
            
        }
        
        return LinksViewController()
    }
    

}

extension SegmentedViewController{
   
    
}
