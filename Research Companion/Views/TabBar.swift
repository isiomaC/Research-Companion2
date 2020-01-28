//
//  TabBar.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 29/12/2019.
//  Copyright © 2019 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit

class TabBar: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        self.tabBar.isTranslucent = true
        
        let homeController = ViewController()
        let homeTabIcon = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        homeController.tabBarItem = homeTabIcon
        
        let sentimentController = SentimentViewController()
        let sentimentTabIcon = UITabBarItem(title: "Sentiment", image: UIImage(systemName: "circle.grid.hex.fill"), tag: 1)
        sentimentController.tabBarItem = sentimentTabIcon
        
        let menuController = MenuViewController()
        let menuTabIcon = UITabBarItem(title: "Menu", image: UIImage(systemName:"text.justifyright"), tag: 2)
        menuController.tabBarItem = menuTabIcon
        
        let tabControllers = [homeController, sentimentController, menuController]
        self.viewControllers = tabControllers.map({ (viewController) in
            UINavigationController(rootViewController: viewController)
        })
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print(viewController.children.first?.navigationItem.title as Any)
        
        return true
    }
    
    
}
