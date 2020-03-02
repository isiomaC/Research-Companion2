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
    
    static let shared: TabBar = {
        let instance = TabBar()
        return instance
    }()
    
    var tabBarHeight: CGFloat? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        tabBarHeight = tabBar.frame.height
       
        self.tabBar.isTranslucent = true
        
        let homeController = ViewController()
        let homeTabIcon = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        homeController.tabBarItem = homeTabIcon
        
        let menuController = MenuViewController()
        let menuTabIcon = UITabBarItem(title: "Menu", image: UIImage(systemName:"text.justifyright"), tag: 2)
        menuController.tabBarItem = menuTabIcon
        
        let tabControllers = [homeController, menuController]
        self.viewControllers = tabControllers.map({ (viewController) in
            UINavigationController(rootViewController: viewController)
        })
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print(viewController.children.first?.navigationItem.title as Any)
        
        return true
    }
    
    
}
