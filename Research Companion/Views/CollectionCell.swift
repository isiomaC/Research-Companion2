//
//  CollectionCell.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 08/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit

let iconWidth = (screenSize.width - CGFloat(10))/4
let colCellHeight = (screenSize.height*0.3)+10

class CollectionCell: UICollectionViewCell{
    
    var indexPath: IndexPath?
    
    var colView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: colCellHeight))
//        view.backgroundColor = .green
        return view
    }()
    
    //change holder to stack view
    var holder: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    var descriptionContainer: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var titleLabel: UILabel = {
       
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 20))
        lab.textColor = .init(white: 1, alpha: 0.2)
        lab.backgroundColor = .systemBlue
        lab.text = "Result from Search"
        lab.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        lab.contentMode = .left
        lab.shadowColor = .gray
        lab.shadowOffset = CGSize(width: 0, height: 1)
        lab.textAlignment = .left
        return lab
    }()
    
    var abstractLabel : UILabel = {
        
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 50))
        lab.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        lab.backgroundColor = .white
        lab.contentMode = .left
//        lab.numberOfLines = 4
        
        lab.text = "lorem ipsum lorem ipsum lorem ipsum loerm ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum loerm ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum loerm ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum loerm ipsum lorem ipsum"
        lab.numberOfLines = 0
        lab.textAlignment = .left
        lab.textColor = .systemGray3
        return lab
    }()
    
    var downloadIcon: UIImageView = {
       var img = UIImageView(frame: CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "link")
        img.clipsToBounds = true
        img.contentMode = .center
       return img
    }()
    
    var infoIcon: UIImageView = {
       var img = UIImageView(frame:  CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "book.fill")
        img.clipsToBounds = true
        img.contentMode = .center
        return img
    }()
    
    var deleteIcon: UIImageView = {
       var img = UIImageView(frame:  CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
       img.translatesAutoresizingMaskIntoConstraints = false
        img.image =  UIImage(systemName: "video.fill")
        img.clipsToBounds = true
        img.contentMode = .center
       return img
    }()
    
    var favoriteIcon: UIImageView = {
      var img = UIImageView(frame:  CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
      img.translatesAutoresizingMaskIntoConstraints = false
      img.image =  UIImage(systemName: "person.fill")
      img.clipsToBounds = true
      img.contentMode = .center
      return img
    }()
    
    //MARK: - The width of the collection view content, must be lesser or equal to the flowLayout width
    lazy var contentWidth : NSLayoutConstraint = {
        return self.contentView.widthAnchor.constraint(equalToConstant: screenSize.width-10)
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        contentWidth.isActive = true
        layer.cornerRadius = 10
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 10
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.cornerRadius = 10
        
        //frame is 220.79
//        print("from collectioncell", contentView.frame.height)
     
        contentView.constrain(top: nil, topConstant: 5, bottom: nil, bottomConstant: 0, leading: safeAreaLayoutGuide.leadingAnchor, leadingConstant: 5, trailing: safeAreaLayoutGuide.leadingAnchor, trailingConstant: 5)
        contentView.addSubview(descriptionContainer)
        contentView.addSubview(holder)
        descriptionContainer.layer.cornerRadius = 10
        setUpPlaceHolderViewsConstraint()
        
        setUpDescConstraints()
        
        setupIconConstraints()
        
        
        
//        if let lastsubview = contentView.subviews.last{
//            contentView.bottomAnchor.constraint(equalTo: lastsubview.bottomAnchor, constant:  0).isActive = true
//        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - for resizing cell based on the text content...
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        contentWidth.constant = targetSize.width
        let size = contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1), withHorizontalFittingPriority: .required, verticalFittingPriority: verticalFittingPriority)
        
        return size
//        print("\(#function) \(#line) \(targetSize) \(size)")
//        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    func setUpContraints(){
        
        //NB - Colview is 220
        colView.addConstraints(top: contentView.topAnchor, topConstant: 0, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, constant: 0)
        colView.heightAnchor.constraint(equalToConstant: CGFloat(Int(colCellHeight))).isActive = true
    }
    
    func setUpPlaceHolderViewsConstraint(){
           descriptionContainer.constrain(top: contentView.topAnchor, topConstant: 0, bottom: holder.topAnchor, bottomConstant: 0, leading: contentView.leadingAnchor, leadingConstant: 0, trailing: contentView.trailingAnchor, trailingConstant: 0)
            
//            descriptionContainer.heightAnchor.constraint(equalToConstant: colCellHeight - (colCellHeight*0.3)).isActive = true
            
            holder.constrain(top: descriptionContainer.bottomAnchor, topConstant: 0, bottom: contentView.bottomAnchor, bottomConstant: 0, leading: contentView.leadingAnchor, leadingConstant: 0, trailing: contentView.trailingAnchor, trailingConstant: 0)
            
//            holder.heightAnchor.constraint(equalToConstant: colCellHeight*0.3).isActive = true
       }
       
    
    
    func setupIconConstraints(){
        
        //NB - Remove colView and use default contentView
        
        holder.addSubview(deleteIcon)
        holder.addSubview(favoriteIcon)
        holder.addSubview(infoIcon)
        holder.addSubview(downloadIcon)
        

        
        
        deleteIcon.constrain(top: holder.topAnchor, topConstant: 0, bottom: holder.bottomAnchor, bottomConstant: 0, leading: holder.leadingAnchor, leadingConstant: 0, trailing: nil, trailingConstant: nil)
        deleteIcon.heightAnchor.constraint(equalToConstant: colView.frame.height * 0.3).isActive = true
        deleteIcon.widthAnchor.constraint(equalToConstant: CGFloat(Int(iconWidth))).isActive = true
        
        
        favoriteIcon.constrain(top: holder.topAnchor, topConstant: 0, bottom: holder.bottomAnchor, bottomConstant: 0, leading: deleteIcon.trailingAnchor, leadingConstant: 0, trailing: nil, trailingConstant: 0)
        favoriteIcon.heightAnchor.constraint(equalToConstant: colView.frame.height * 0.3).isActive = true
        favoriteIcon.widthAnchor.constraint(equalToConstant: CGFloat(Int(iconWidth))).isActive = true
        
        infoIcon.constrain(top: holder.topAnchor, topConstant: 0, bottom: holder.bottomAnchor, bottomConstant: 0, leading: favoriteIcon.trailingAnchor, leadingConstant: 0, trailing: nil, trailingConstant: 0)
        infoIcon.heightAnchor.constraint(equalToConstant: colView.frame.height * 0.3).isActive = true
        infoIcon.widthAnchor.constraint(equalToConstant: CGFloat(Int(iconWidth))).isActive = true
        
        
        downloadIcon.constrain(top: holder.topAnchor, topConstant: 0, bottom: holder.bottomAnchor, bottomConstant: 0, leading: infoIcon.trailingAnchor, leadingConstant: 0, trailing: holder.trailingAnchor, trailingConstant: 0)
        downloadIcon.heightAnchor.constraint(equalToConstant: colView.frame.height * 0.3).isActive = true
        downloadIcon.widthAnchor.constraint(equalToConstant: CGFloat(Int(iconWidth))).isActive = true

    }
    
    func setUpDescConstraints(){
        
        descriptionContainer.addSubview(titleLabel)
        descriptionContainer.addSubview(abstractLabel)

        titleLabel.constrain(top: descriptionContainer.topAnchor, topConstant: 0, bottom: abstractLabel.topAnchor, bottomConstant: 0, leading: descriptionContainer.leadingAnchor,
            leadingConstant: 15, trailing: descriptionContainer.trailingAnchor, trailingConstant: 15)
        titleLabel.layer.cornerRadius = 5
        
        
        abstractLabel.constrain(top: titleLabel.bottomAnchor, topConstant: 0, bottom: descriptionContainer.bottomAnchor, bottomConstant: 0, leading: descriptionContainer.leadingAnchor, leadingConstant: 15, trailing: descriptionContainer.trailingAnchor, trailingConstant: 15)
        
    }
    
    
}
