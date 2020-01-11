//
//  ResultsView.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 09/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit

let halfHeight = screenSize.height * CGFloat(0.5)

class ResultsView: UIView{
    
    let topView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: halfHeight - 10))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    let queryLabel : UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Short title"
        lab.textAlignment = .justified
        lab.font = UIFont.boldSystemFont(ofSize: 29)
        return lab
    }()
    
    let snippetLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "jfschbsakcbklnxanxml, xlk nskjgvj hdxc kab hkdbcxhkanskj vjkx ncabhjdbxckjjahjcb xjchbjhsbzc jhbjsjzcbxj bsjcbjsh bchbd jsjhcb jbcsdcscdscds cdacdd sndjkshakn dahjkc kjnkj hvjbb hjvjknklmk jnjnkkhui hbjkjjknlknk jbuhvygvhjb hjbknknkjbhjjh jbnjknjk jknjkj jbjhknkm jkvtsqweg dawerujvftrz sewe"
        lab.textAlignment = .natural
        lab.font = UIFont.systemFont(ofSize: 18)
        lab.numberOfLines = 6
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topView)
        topView.addSubview(queryLabel)
        topView.addSubview(snippetLabel)
        constrain()
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constrain(){
        let snippetHeight = halfHeight - (halfHeight/3)
        
        
        topView.addConstraints(top: safeAreaLayoutGuide.topAnchor, topConstant: 0, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, constant: 0)
        
        topView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(screenSize.height * 0.5)).isActive = true
        
        queryLabel.addConstraints(top: topView.topAnchor, topConstant: 0, bottom: nil, leading: topView.leadingAnchor, trailing: topView.trailingAnchor, constant: 10)
        queryLabel.heightAnchor.constraint(equalToConstant: halfHeight/5).isActive = true
        
        snippetLabel.addConstraints(top: queryLabel.bottomAnchor, topConstant: 0, bottom: topView.bottomAnchor, leading: queryLabel.leadingAnchor, trailing: queryLabel.trailingAnchor, constant: 0)
        
//        snippetLabel.heightAnchor.constraint(equalToConstant: snippetHeight - 10).isActive = true
    }
}
