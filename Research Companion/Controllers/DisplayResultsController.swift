//
//  DisplayResultsController.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 06/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SDWebImage

protocol dataPassedBetweenControllers {
    func sendBackToParent(testArray: [Int])
}

class DisplayResultsController: UIViewController{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var request : NSFetchRequest<Result> = Result.fetchRequest()
    var researchItems = [Result]()
    
    var cellId = "collection"
    var collectionView : UICollectionView!
   
    let padding: CGFloat = 15
    
    var testArray = [Int]()
    var result: Result?
    var links = [OrganicLink]()
    var images = [ImageLink]()
    var videos = [VideoLink]()
    var delegate : dataPassedBetweenControllers?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        print(testArray)
        
        print(images)
        print(videos)
    
        view.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent{
            //remove force unwrapping...
            delegate?.sendBackToParent(testArray: [1,2,3,4,5,6,7,8])
        }
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        
    }
    
    func fetchResearch(){
        do {
            researchItems = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
}

extension DisplayResultsController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
    func setUpCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenSize.width - padding, height: screenSize.height * 0.3)
        
//        layout.estimatedItemSize = CGSize(width: screenSize.width - padding, height: screenSize.height/3)
        
        print(screenSize.height*0.3)
        
        layout.minimumLineSpacing = 15
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
//        collectionView.setCollectionViewLayout(layout, animated: true)
        view.addSubview(collectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //change to return the number of items in array
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionCell
    
        if let img = images[indexPath.row].image{
            cell.imageView.sd_setImage(with: URL(string: img))
            cell.imageView.image?.sd_resizedImage(with: CGSize(width: 200, height: 200), scaleMode: .aspectFill)
            cell.favIcon.image = UIImage(systemName: "bookmark")
            cell.favIcon.isUserInteractionEnabled = true
            cell.favIcon.tag = indexPath.row
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(save))
                
            cell.favIcon.addGestureRecognizer(tapGesture)
        }
     
        return cell
    }
    
    @objc func save(sender: UITapGestureRecognizer){
        let imageV = sender.view as! UIImageView
        
        print("sender's View \(String(describing: imageV))")
        print("\(imageV.tag) bookamrk tapped")
    }
    
}
