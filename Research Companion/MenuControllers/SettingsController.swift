//
//  SettingsController.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 29/12/2019.
//  Copyright © 2019 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class SettingsController: UIViewController, IndicatorInfoProvider{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        
        navigationItem.title = "Settings"
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Set")
    }
}
