//
//  ViewController.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 27/12/2019.
//  Copyright © 2019 Isioma Anofienam. All rights reserved.
//

import UIKit
import SideMenu
import JJFloatingActionButton

let menuScreenOffset = screenSize.width/4
let menuScreenSize = screenSize.width - menuScreenOffset

class ViewController: MyViewController {
    
    let cellId = "cellID"
    var data : [Artik]?
    
     var myCollection: MyCollectionView?
    
    lazy var floatingAction : JJFloatingActionButton = {
        let act = JJFloatingActionButton()
        act.translatesAutoresizingMaskIntoConstraints = false
        act.buttonDiameter = 65   //button size
        act.buttonColor = .systemBlue
        act.buttonImageSize = CGSize(width: 25, height: 25)   //base button size
        
//        act.buttonAnimationConfiguration = .transition(toImage: UIImage(systemName: "paperclip.circle")!)   //change image of base button on tap
        
        act.itemAnimationConfiguration = .slideIn()
        act.configureDefaultItem { (item) in
            item.titlePosition = .top
            item.titleLabel.font = .boldSystemFont(ofSize: UIFont.smallSystemFontSize)
            item.buttonImageColor = .systemBlue
            item.highlightedButtonColor = .darkGray
        }
        
        act.addItem(title: "Add", image: UIImage(systemName:
            "plus")?.withRenderingMode(.alwaysTemplate)) { (item) in
                print("Add tapped")
        }
        
        act.addItem(title: "View", image: UIImage(systemName: "return")?.withRenderingMode(.alwaysTemplate)) { (item) in
                print("View tapped")
        }
        
        return act
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Companion"
        setUpMyCollectionView()
        view.addSubview(myCollection!)
        view.addSubview(floatingAction)
        
        floatingAction.items.forEach { (item) in
            if item.titleLabel.text == "Add" {
                item.addTarget(self, action: #selector(self.newResource), for: .touchUpInside)
            }
        }
        addFloatingActionConstraints()
        setUpNavigationController()
        
        //MARK:- Removed Home View and replaced with JJFloating Action button..
//        myView = HomeView()
//        myView?.addButton.addTarget(self, action: #selector(newResource), for: .touchUpInside)
//        view = myView
    }
    
    func addFloatingActionConstraints(){
        floatingAction.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        floatingAction.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    func getArtikArray()-> [Artik]{
        let art = Artik(title: "Machine Learning", abstract: "Lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsume", date: "2019")
        
        let art2 = Artik(title: "Artificial Intelligence ", abstract: "Another abstract that wukk eb short and not useful, because i know this", date: "2020")
        
        let art3 =  Artik(title: "Quantum Intelligence ", abstract: "Another abstract that wukk eb short and not useful, because i know this", date: "1997")
        
        let art4 =  Artik(title: "Physics Body ", abstract: "Another abstract that wukk eb short and not useful, because i know this", date: "1653")
        
        return [art,art2, art3, art4 ]
    }
    
    func setUpMyCollectionView(){
        let flowLayout : UICollectionViewFlowLayout = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
            
            //ESTIMATED item size is 220.79
           layout.estimatedItemSize = CGSize(width: screenSize.width - 10, height: screenSize.height*0.3)

           layout.minimumInteritemSpacing = 10
           return layout
        }()
        
        let col = MyCollectionView(frame: screenSize, collectionViewLayout: flowLayout)
        col.register(CollectionCell.self, forCellWithReuseIdentifier: cellId)
        col.delegate = self
        col.dataSource = self
        data = getArtikArray()
        myCollection = col
       
    }
    
    func setUpNavigationController(){
         let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(openFavorites))
                
         let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "square.stack"), style: .plain, target: self, action: #selector(openMenu))

         navigationItem.rightBarButtonItem = rightBarButton
         navigationItem.leftBarButtonItem = leftBarButton
                
        //if isTranslucent=false then use bartintcolor property, if =true use backgroundcolor property
        
//                navigationController?.navigationBar.barTintColor = .blue
         navigationController?.navigationBar.backgroundColor = .systemBlue
         navigationController?.navigationBar.isTranslucent = true
         navigationController?.navigationBar.tintColor = UIColor.lightGray
         navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
    }
    
    @objc func newResource(){
        navigationController?.pushViewController(AddResearchController(), animated: true)
    }
    
    @objc func openFavorites(){
        navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }
    
    
    @objc func openMenu(){
//        let menu = SideMenuNavigationController(rootViewController: MenuViewController())
//        SideMenuManager.default.leftMenuNavigationController = menu
//
//        SideMenuManager.default.leftMenuNavigationController?.statusBarEndAlpha = 0
//        SideMenuManager.default.leftMenuNavigationController?.presentationStyle.menuScaleFactor = 1
//        SideMenuManager.default.leftMenuNavigationController?.presentationStyle.onTopShadowOpacity = 2
//
////          SideMenuManager.default.leftMenuNavigationController?.presentationStyle.presentingScaleFactor = 0.9
//
////        SideMenuManager.default.leftMenuNavigationController?.blurEffectStyle = .dark
////        SideMenuManager.default.leftMenuNavigationController?.presentationStyle = .slide
//
//        SideMenuManager.default.leftMenuNavigationController?.menuWidth = menuScreenSize
//        print(menu)
        print("Tapped")
        
//        present(menu, animated: true, completion: nil)
    }
}

extension ViewController :UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
        if let dat = data{
               return dat.count
           }else {
               return 3
           }
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionCell
           
           cell.tag = indexPath.row
           cell.titleLabel.text = data![indexPath.row].title
           cell.abstractLabel.text = data![indexPath.row].abstract
//                                     data![indexPath.row].date
           return cell
           
       }

    
}
