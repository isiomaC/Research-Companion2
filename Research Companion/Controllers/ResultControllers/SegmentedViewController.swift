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
    
    let data = ["videos", "pdf", "images", "links"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnSwipe = true
        
        let v = UIImageView()
        v.image = UIImage(named: "test")
        v.contentMode = .scaleAspectFill
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
     
        let res = ResultsView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 200))
        
        let imgView = UIImageView()
        imgView.image = UIImage(named: "test")
        
        
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
        return data[index]
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
        
        if data[index] == "videos"{
            let v = SentimentViewController()
           
            return v
        }
        
        return FavoritesViewController()
    }
    

}

extension SegmentedViewController{
   
    
}
