//
//  VideosViewController.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 27/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import UIKit

class ArticleViewController: MyViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var cellId = "collectionCell"
    
    var selectedIndex: IndexPath?
    
    var articleData : [MyArticle]?
    
    var researchName: String?
    
    var queryString: String?
    
    var miniArticle: [MyArticle]?
    
    var colView: UICollectionView?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        
        view.backgroundColor = .black
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpCollectionView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let selection = selectedIndex {
            UIView.animate(withDuration: .leastNonzeroMagnitude) {
                self.colView?.scrollToItem(at: selection, at: [.centeredVertically, .centeredHorizontally], animated: true)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.layoutIfNeeded()
    }
}


extension ArticleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{

    //MARK: - When setting up a collection view make sure the estimated content size is always larger than the size of the internal content
    
    func setUpCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        //ESTIMATED item size is 220.79
        layout.estimatedItemSize = CGSize(width: screenSize.width - 10, height: screenSize.height*0.3)

        layout.minimumInteritemSpacing = 10
        
        var lastCellOffset: CGFloat = 0
        if let tabController = tabBarController {
            lastCellOffset = topbarHeight + tabController.tabBar.frame.height + 66
        }
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - lastCellOffset), collectionViewLayout: layout)
        collectionView.clearsContextBeforeDrawing = false
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = true
        colView = collectionView
        
        if let mColView = colView{
             view.addSubview(mColView)
        }

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if let jdata = articleData {
                return jdata.count
            }else{
                return 2
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        print(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionCell
        
        let downloadgesture = UITapGestureRecognizer(target: self, action: #selector(download))
        downloadgesture.numberOfTapsRequired = 1
        
        let saveGesture = UITapGestureRecognizer(target: self, action: #selector(save))
        saveGesture.numberOfTapsRequired = 1
        
        let deleteGesture = UITapGestureRecognizer(target: self, action: #selector(deleteItem))
        deleteGesture.numberOfTapsRequired = 1
        
        if let data = articleData{
            
            selectedIndex = indexPath
            cell.tag = indexPath.row
            cell.titleLabel.text = data[indexPath.row].title

            if !data[indexPath.row].abstract!.isEmpty || data[indexPath.row].abstract != ""  {
                cell.abstractLabel.text = data[indexPath.row].abstract
            }else{
                cell.abstractLabel.text = "Please Download Article to View data"
            }
            
            cell.deleteIcon.image = UIImage(systemName: "trash")
            cell.deleteIcon.isUserInteractionEnabled = true
            cell.deleteIcon.addGestureRecognizer(deleteGesture)
            cell.deleteIcon.tag = indexPath.row
           
            cell.favoriteIcon.image = UIImage(systemName: "bookmark")
            cell.favoriteIcon.addGestureRecognizer(saveGesture)
            cell.favoriteIcon.isUserInteractionEnabled = true
            cell.favoriteIcon.tag = indexPath.row
            
            cell.downloadIcon.isUserInteractionEnabled = true
            cell.downloadIcon.tag = indexPath.row
            cell.downloadIcon.image = UIImage(systemName: "arrow.down.to.line.alt")
            cell.downloadIcon.addGestureRecognizer(downloadgesture)
            
            
            print("line: [\(#line)] ",cell.frame.height)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row  == articleData?.count {
            print("Get More Data ", "Line: \(#line)")
            getMoreData()
        }
    }
    
    func getMoreData(){
        
        //Call Api Again here..
        ResourceGenerator.shared.postSearchArticles(query: ["query": queryString!]) { (articles, success) in
            if success{
                if let art = articles {
                    self.articleData?.append(contentsOf: art)
                    
                    self.colView?.reloadData()
                }
                
            }
        }
        
        //Get All data and divide it
    }
    
    @objc func download(sender: UITapGestureRecognizer){
        
        let sendingView = sender.view as! UIImageView
        
        if let articles = articleData, let id = articles[sendingView.tag].id{
            
            startActivityIndicator()
            
            ResourceGenerator.shared.postDownloadArticle(byId: Int(id)) { (data, success) in
                if success{
                    self.stopActivityIndicator()
                    let pdfController = PdfViewController()
                    pdfController.delegate = self
                    pdfController.data = data
                    self.navigationController?.pushViewController(pdfController, animated: true)
                }
            }
        }
        
        print("\(#line) \(sendingView)  cell: \(sendingView.tag)")
    }
    
    

    @objc func save(sender: UITapGestureRecognizer){
        let favoriteIcon = sender.view as! UIImageView
        
        //toggle save boolean here
        //saved = !save
        
        //MARK: - Waiting on CoreData to load Model
        let mResearch = Research(context: self.context)
        
        mResearch.name = researchName
        
        mResearch.queryString = queryString
        
        let mArticle = Article(context: self.context)
        mArticle.abstract = articleData?[favoriteIcon.tag].abstract
        mArticle.authors = articleData?[favoriteIcon.tag].authors
        mArticle.contributors = articleData?[favoriteIcon.tag].contributors
        mArticle.datePublished = articleData?[favoriteIcon.tag].datePublished
        mArticle.doi = articleData?[favoriteIcon.tag].doi
        mArticle.downloadUrl = articleData?[favoriteIcon.tag].downloadUrl
        mArticle.publisher = articleData?[favoriteIcon.tag].publisher
        mArticle.oai = articleData?[favoriteIcon.tag].oai
        mArticle.year = (articleData?[favoriteIcon.tag].year)!
        mArticle.research = mResearch
        
        mResearch.addToArticles(mArticle)
        
        if saveToCoreData() {
            favoriteIcon.image = UIImage(systemName: "bookmark.fill")
        }else{
            favoriteIcon.image = UIImage(systemName: "bookmark")
        }
        
        print("sender's View \(String(describing: favoriteIcon))")
        print("\(favoriteIcon.tag) bookamrk tapped")
    }
    
    
    @objc func deleteItem(sender: UITapGestureRecognizer){
        
        let deleteIcon = sender.view as! UIImageView
        
        articleData?.remove(at: deleteIcon.tag)
        
        UIView.animate(withDuration: 0.5) {
            self.colView?.reloadData()
        }
        
        print("Deleted Line: \(#line) ", deleteIcon.tag)
    }
    
    func saveToCoreData() -> Bool  {
        do {
            try context.save()
            print("Line \(#line) saved")
            return true
            
        } catch {
            print(error)
            return false
        }
    }

}

extension ArticleViewController: pdfDataGottenFromSendingView{
    func sendBack(gotData: Int) {
        print(gotData)
    }
}


