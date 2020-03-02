//
//  MyViewController.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 13/02/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import UIKit

class MyViewController: UIViewController{
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         view.isHidden = false
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         view.isHidden = true
     }

    func startActivityIndicator(){
        
        activityIndicator.color = .red
        activityIndicator.frame = self.view.frame
        activityIndicator.center = self.view.center
        activityIndicator.backgroundColor = UIColor.init(white: 1, alpha: 0.2)
        activityIndicator.startAnimating()
        activityIndicator.isOpaque = true
        view.addSubview(activityIndicator)
        
    }
    
    func stopActivityIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        
    }
}
