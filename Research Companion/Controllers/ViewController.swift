//
//  ViewController.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 27/12/2019.
//  Copyright © 2019 Isioma Anofienam. All rights reserved.
//

import UIKit
import SideMenu

let menuScreenOffset = screenSize.width/4
let menuScreenSize = screenSize.width - menuScreenOffset

class ViewController: UIViewController {
    
    var myView: HomeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView = HomeView()
        myView?.addButton.addTarget(self, action: #selector(newResource), for: .touchUpInside)
               
        view = myView
        navigationItem.title = "Companion"
        
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(openFavorites))
        
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "square.stack"), style: .plain, target: self, action: #selector(openMenu))

        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
        
//        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor.lightGray
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.isHidden = true
    }
    
    @objc func newResource(){
        navigationController?.pushViewController(AddResearchController(), animated: true)
    }
    
    @objc func openFavorites(){
        navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }
    
    @objc func openMenu(){
        let menu = SideMenuNavigationController(rootViewController: MenuViewController())
        SideMenuManager.default.leftMenuNavigationController = menu
        
        SideMenuManager.default.leftMenuNavigationController?.statusBarEndAlpha = 0
        SideMenuManager.default.leftMenuNavigationController?.presentationStyle.menuScaleFactor = 1
        SideMenuManager.default.leftMenuNavigationController?.presentationStyle.onTopShadowOpacity = 2
        
//          SideMenuManager.default.leftMenuNavigationController?.presentationStyle.presentingScaleFactor = 0.9
        
//        SideMenuManager.default.leftMenuNavigationController?.blurEffectStyle = .dark
//        SideMenuManager.default.leftMenuNavigationController?.presentationStyle = .slide
        
        SideMenuManager.default.leftMenuNavigationController?.menuWidth = menuScreenSize
        print(menu)
        print("Tapped")
        
        present(menu, animated: true, completion: nil)
    }
}

