//
//  CollectionCell.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 08/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit

let iconWidth = (screenSize.width - CGFloat(10))/5

class CollectionCell: UICollectionViewCell{
    
    var colView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height*0.3))
//        view.backgroundColor = .green
        return view
    }()
    
    var holder: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    var imageView: UIImageView = {
        var img = UIImageView(frame: CGRect(x: 0, y: 0, width: screenSize.width-CGFloat(15), height: (screenSize.height/2)-100))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    var linksIcon: UIImageView = {
       var img = UIImageView(frame: CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "link")
        img.clipsToBounds = true
        img.contentMode = .center
       return img
    }()
    
    var pdfIcon: UIImageView = {
       var img = UIImageView(frame:  CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "book.fill")
        img.clipsToBounds = true
        img.contentMode = .center
        return img
    }()
    
    var videoIcon: UIImageView = {
       var img = UIImageView(frame:  CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
       img.translatesAutoresizingMaskIntoConstraints = false
        img.image =  UIImage(systemName: "video.fill")
        img.clipsToBounds = true
        img.contentMode = .center
       return img
    }()
    
    var pictureIcon: UIImageView = {
      var img = UIImageView(frame:  CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
      img.translatesAutoresizingMaskIntoConstraints = false
      img.image =  UIImage(systemName: "person.fill")
      img.clipsToBounds = true
      img.contentMode = .center
      return img
    }()
    
    var favIcon: UIImageView = {
       var img = UIImageView(frame: CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
       img.translatesAutoresizingMaskIntoConstraints = false
        img.image =  UIImage(systemName: "bookmark.fill")
        img.clipsToBounds = true
        img.contentMode = .center
       return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(colView)
//        print(colView.frame.height * 0.3)
//        print(Int(iconWidth))
        
        setUpContraints()
        colView.addSubview(imageView)
        colView.addSubview(holder)
        holder.addSubview(linksIcon)
        holder.addSubview(pdfIcon)
        holder.addSubview(videoIcon)
        holder.addSubview(pictureIcon)
        holder.addSubview(favIcon)
        setUpImageConstraints()
        constraintss()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContraints(){
        
        colView.addConstraints(top: topAnchor, topConstant: 0, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, constant: 0)
        colView.heightAnchor.constraint(equalToConstant: screenSize.height*0.3).isActive = true
    }
    
    func constraintss(){
        
        imageView.addConstraints(top: colView.topAnchor, topConstant: 0, bottom: nil, leading: colView.leadingAnchor, trailing: colView.trailingAnchor, constant: 0)
        imageView.bottomAnchor.constraint(equalTo: colView.bottomAnchor, constant: -(colView.frame.height*0.3)).isActive = true
        
    }
    
    
    
    func setUpImageConstraints(){
        
        holder.addConstraints(top: nil, topConstant: 0, bottom: colView.bottomAnchor, leading: colView.leadingAnchor, trailing: colView.trailingAnchor, constant: 0)
        holder.topAnchor.constraint(equalTo: colView.topAnchor, constant: colView.frame.height - (colView.frame.height*0.3)).isActive = true
        
        linksIcon.addConstraints(top: holder.topAnchor, topConstant: 0, bottom: holder.bottomAnchor, leading: holder.leadingAnchor, trailing: nil, constant: 0)
        linksIcon.heightAnchor.constraint(equalToConstant: colView.frame.height * 0.3).isActive = true
        linksIcon.widthAnchor.constraint(equalToConstant: CGFloat(Int(iconWidth))).isActive = true
        
        pdfIcon.addConstraints(top: holder.topAnchor, topConstant: 0, bottom: holder.bottomAnchor, leading: linksIcon.trailingAnchor, trailing: nil, constant: 0)
        pdfIcon.heightAnchor.constraint(equalToConstant: colView.frame.height * 0.3).isActive = true
        pdfIcon.widthAnchor.constraint(equalToConstant: CGFloat(Int(iconWidth))).isActive = true

        videoIcon.addConstraints(top: holder.topAnchor, topConstant: 0, bottom: holder.bottomAnchor, leading: pdfIcon.trailingAnchor, trailing: nil, constant: 0)
        videoIcon.heightAnchor.constraint(equalToConstant: colView.frame.height * 0.3).isActive = true
        videoIcon.widthAnchor.constraint(equalToConstant: CGFloat(Int(iconWidth))).isActive = true
        
        pictureIcon.addConstraints(top: holder.topAnchor, topConstant: 0, bottom: holder.bottomAnchor, leading: videoIcon.trailingAnchor, trailing: nil, constant: 0)
        pictureIcon.heightAnchor.constraint(equalToConstant: colView.frame.height * 0.3).isActive = true
        pictureIcon.widthAnchor.constraint(equalToConstant: CGFloat(Int(iconWidth))).isActive = true


        favIcon.addConstraints(top: holder.topAnchor, topConstant: 0, bottom: holder.bottomAnchor, leading: nil, trailing: holder.trailingAnchor, constant: 0)
        favIcon.heightAnchor.constraint(equalToConstant: colView.frame.height * 0.3).isActive = true
        favIcon.widthAnchor.constraint(equalToConstant: CGFloat(Int(iconWidth))).isActive = true

    }
    
    
}
