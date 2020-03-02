//
//  HomeView.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 27/12/2019.
//  Copyright © 2019 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit

let screenSize = UIScreen.main.bounds
let halfScreenHeight = screenSize.height/2
let yPos = (halfScreenHeight/2) + 50

class HomeView: UIView {
    
    let contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        
        view.backgroundColor = .clear
        //UIColor(red: 162, green: 132, blue: 94, alpha: 0)
        
        view.layer.borderColor = UIColor.white.cgColor
        
        return view
    }()
    
    let label : UILabel = {
        let lab = UILabel()
        
        return lab
    }()
    
    let addButton: UIButton = {
        let btn = UIButton()
        let image = UIImage(systemName: "plus.circle")
        btn.setImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 40
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.backgroundColor = .black
        btn.tintColor = .darkGray
        return btn
    }()
    
    let resourceButton: UIButton = {
        let btn = UIButton()
        let image = UIImage(systemName: "folder.circle")
        btn.setImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 40
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.backgroundColor = .black
        btn.tintColor = .darkGray
        return btn
    }()
    
    let thirdButton: UIButton = {
        let btn = UIButton()
        let image = UIImage(systemName: "paperclip.circle")
        btn.setImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 40
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.backgroundColor = .black
        btn.tintColor = .darkGray
        return btn
    }()
    
    let fourthButton: UIButton = {
        let btn = UIButton()
        let image = UIImage(systemName: "asterisk.circle")
        btn.setImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 40
        btn.contentHorizontalAlignment = .fill
        btn.contentVerticalAlignment = .fill
        btn.backgroundColor = .black
        btn.tintColor = .darkGray
        return btn
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
//        addSubview(addButton)
        
        backgroundColor = .brown
        
        contentView.addSubview(addButton)
        contentView.addSubview(resourceButton)
        contentView.addSubview(thirdButton)
        contentView.addSubview(fourthButton)
        
        addSubview(contentView)
        setUPConstraints()
        setUpButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUPConstraints(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        contentView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: yPos).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -yPos).isActive = true
    }
    
    func setUpButtonConstraints(){
        addButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        resourceButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        resourceButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        resourceButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        resourceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100).isActive = true
        
        thirdButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        thirdButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        thirdButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100).isActive = true
        thirdButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        fourthButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        fourthButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        fourthButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100).isActive = true
        fourthButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
    }
    
    
}
