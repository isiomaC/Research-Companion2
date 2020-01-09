//
//  SentimentViewController.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 29/12/2019.
//  Copyright © 2019 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit

class SentimentViewController: UIViewController{
    
    override func loadView() {
        super.loadView()
        view = HomeView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .blue
    }
}
