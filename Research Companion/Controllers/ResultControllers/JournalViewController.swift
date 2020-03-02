//
//  ImagesViewController.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 27/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import UIKit

class JournalViewController : UIViewController {
    
    var journalData : [MyJournal]?
    var cellID = "collection"

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        let collectionView = view.subviews.filter { $0 is UICollectionView }
        self.view.layoutIfNeeded()
    }

}

extension JournalViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{

    //MARK: - When seeting up a collection view make sure the estimated content sze is always larger than the size of the internal content -- Make use of the estimateditemsize and itemSize property of the CollectionViewFlowlayout
    
    func setUpCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
//        layout.itemSize = CGSize(width: screenSize.width - 10, height: screenSize.height * 0.3)
        
        //ESTIMATED item size is 220.79
        layout.estimatedItemSize = CGSize(width: screenSize.width - 10, height: screenSize.height*0.3)

        print("\(#function)----\(#line)----", screenSize.height*0.3)

        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 0
        
        var lastCellOffset: CGFloat = 0
        if let tabController = tabBarController {
            lastCellOffset = topbarHeight + tabController.tabBar.frame.height + 66
        }
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - lastCellOffset), collectionViewLayout: layout)
        
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = true
        
        view.addSubview(collectionView)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if let jdata = journalData {
            return jdata.count
        }else{
            return 2
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CollectionCell
        
        if let data = journalData{
            cell.titleLabel.text = data[indexPath.row].title
            cell.abstractLabel.text = "\(data[indexPath.row].publisher),  \(data[indexPath.row].subjects), \(data[indexPath.row].rights), \(data[indexPath.row].language)"
            
            cell.tag = indexPath.row
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(getJournal))
            tapGesture.numberOfTapsRequired = 1
            
            cell.downloadIcon.tag = indexPath.row
            cell.downloadIcon.isUserInteractionEnabled = true
            cell.downloadIcon.addGestureRecognizer(tapGesture)
            
            print("line:[\(#line)] ",cell.frame.height)
            
        }

        return cell
    }
    
    @objc func getJournal(sender: UITapGestureRecognizer){
        
        let sender = sender.view as! UIImageView
        
        if let journalISSN = journalData?[sender.tag].identifiers?["issn"]{
            ResourceGenerator.shared.postGetJournal(byIssn: [journalISSN]) { (journal, success) in
                
                if success{
                    
                    print(journal)
                    
                }else{
                    print("Error retrieving journal")
                }
            }
        }
        
        
    }
    
    

    @objc func save(sender: UITapGestureRecognizer){
        let imageV = sender.view as! UIImageView

        print("sender's View \(String(describing: imageV))")
        print("\(imageV.tag) bookamrk tapped")
    }

}


