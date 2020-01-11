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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnSwipe = true
        
        let v = UIImageView()
        v.image = UIImage(named: "test")
        v.contentMode = .scaleAspectFill
        
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        let ref = segmentedPager.parallaxHeader.view
        
        topView.addConstraints(top: ref?.topAnchor, topConstant: 0, bottom: ref?.bottomAnchor, leading: ref?.leadingAnchor, trailing: ref?.trailingAnchor, constant: 0)
        topView.backgroundColor = .green
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        topView.addGestureRecognizer(tap)
     
        let res = ResultsView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 200))
//        res.snippetLabel
        
        
        segmentedPager.parallaxHeader.view = res.snippetLabel
        
        ref?.translatesAutoresizingMaskIntoConstraints = false
        ref?.addConstraints(top: nil, topConstant: 0, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, constant: 20)
        segmentedPager.parallaxHeader.height = 200
        segmentedPager.parallaxHeader.mode = .center
        segmentedPager.parallaxHeader.minimumHeight = screenSize.height/3
        

        segmentedPager.segmentedControl.indicator.linePosition = .bottom
        segmentedPager.segmentedControl.textColor = .white
        segmentedPager.segmentedControl.selectedTextColor = .red
        segmentedPager.segmentedControl.indicator.lineView.backgroundColor = .red
       
    }
    
    @objc func tapped(_ view: UIView){
        print("tapped")
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return ["videos", "pdf", "images", "links"][index]
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
        print("\(parallaxHeader.progress)")
    }
    
    override func numberOfPages(in segmentedPager: MXSegmentedPager) -> Int {
        return 4
    }
    
    override func segmentedPagerShouldScrollToTop(_ segmentedPager: MXSegmentedPager) -> Bool {
        return false
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, viewForPageAt index: Int) -> UIView {
        //set views here
        let l = UILabel()
        l.text = "Page \(index)"
        return l
    }
}

extension SegmentedViewController{
   
    
}
