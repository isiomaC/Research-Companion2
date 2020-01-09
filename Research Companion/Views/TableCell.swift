//
//  Tablecell.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 29/12/2019.
//  Copyright © 2019 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit

class TableCell: UITableViewCell{
    
    let label1: UILabel = {
        var lab = UILabel()
        lab.textAlignment = .justified
        lab.textColor = .white
        lab.font = UIFont.boldSystemFont(ofSize: 18)
        lab.numberOfLines = 0
        lab.backgroundColor = UIColor(red: 162/255, green: 132/255, blue: 94/255, alpha: 0.2)
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label1)
        constrain()
        
    }
    
    func constrain(){
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        label1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        label1.heightAnchor.constraint(equalToConstant: 80).isActive = true
        label1.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not beeb implemented")
    }
}
