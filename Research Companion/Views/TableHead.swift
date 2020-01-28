//
//  tableHead.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 27/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import UIKit

class TableHead: UITableViewHeaderFooterView {
    
    let label: UILabel = {
        var lab = UILabel()
        lab.textAlignment = .justified
        lab.textColor = .white
        lab.font = UIFont.boldSystemFont(ofSize: 15)
        lab.numberOfLines = 1
        lab.backgroundColor = .red
        lab.backgroundColor = UIColor(red: 162/255, green: 132/255, blue: 94/255, alpha: 0.2)
        return lab
    }()
    
    let arrowImage:UIImageView = {
       var img = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        img.clipsToBounds = true
        img.contentMode = .center
        img.image = UIImage(named: "arrow")
       return img
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
//        addSubview(arrowImage)
        label.addConstraints(top: topAnchor, topConstant: 0, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, constant: 0)
//        arrowImage.addConstraints(top: topAnchor, topConstant: 0, bottom: bottomAnchor, leading: nil, trailing: trailingAnchor, constant: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
        
    
}
