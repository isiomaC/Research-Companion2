//
//  AddView.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 29/12/2019.
//  Copyright © 2019 Isioma Anofienam. All rights reserved.
//

//Complete AddVIEW

import Foundation
import UIKit


//Add CipstoBounds property on other views..s

class AddView: UIView{
    
    let nameField: UITextField = {
        let textF = UITextField(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
        textF.font = UIFont.systemFont(ofSize: 15)
        textF.placeholder = "Name"
        textF.contentVerticalAlignment = .center
        textF.keyboardType = .default
        textF.borderStyle = .roundedRect
        textF.tag = 0
        return textF
    }()
    
    var queryField: UITextField = {
        let textF = UITextField(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
        textF.font = UIFont.systemFont(ofSize: 15)
        textF.placeholder = "Query String"
        textF.contentVerticalAlignment = .center
        textF.keyboardType = .default
        textF.borderStyle = .roundedRect
        textF.tag = 1
        return textF
    }()
    
    let resultLabel : UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
        lab.text = "Result"
        lab.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        lab.numberOfLines = 1
        lab.textColor = UIColor.lightText
        lab.contentMode = .left
        lab.shadowColor = UIColor.darkText
        lab.shadowOffset = CGSize(width: 0, height: 5)
        lab.textAlignment = .left
        return lab
    }()
    
    let dividerView : UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 1))
        v.backgroundColor = .separator
        return v
    }()
    
    //for label and switch
    let containerView1: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 70))
        v.backgroundColor = .clear
        v.contentMode = .center
        return v
    }()
    
    let label1 : UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
        lab.text = "Links"
        lab.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lab.numberOfLines = 1
        lab.textColor = UIColor.lightText
        lab.contentMode = .center
        lab.shadowColor = UIColor.systemGray3
        lab.shadowOffset = CGSize(width: 0, height: 1)
        lab.textAlignment = .left
        return lab
    }()
    
    let label2 : UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
        lab.text = "Files"
        lab.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lab.numberOfLines = 1
        lab.textColor = UIColor.lightText
        lab.contentMode = .center
        lab.shadowColor = UIColor.systemGray3
        lab.shadowOffset = CGSize(width: 0, height: 1)
        lab.textAlignment = .left
        return lab
    }()
    
    let label3 : UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
        lab.text = "Videos"
        lab.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lab.numberOfLines = 1
        lab.textColor = UIColor.lightText
        lab.contentMode = .center
        lab.shadowColor = UIColor.systemGray3
        lab.shadowOffset = CGSize(width: 0, height: 1)
        lab.textAlignment = .left
        return lab
    }()
    
    let label4 : UILabel = {
           let lab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 40))
           lab.text = "Images"
           lab.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
           lab.numberOfLines = 1
           lab.textColor = UIColor.lightText
           lab.contentMode = .center
           lab.shadowColor = UIColor.systemGray3
           lab.shadowOffset = CGSize(width: 0, height: 1)
           lab.textAlignment = .left
           return lab
       }()
    
    let switch1 : UISwitch = {
        let swt = UISwitch(frame: CGRect(x: 0, y: 0, width: 51, height: 31))
        swt.onTintColor = UIColor(red: 142/255, green: 196/255, blue: 0, alpha: 0.5)
        swt.isOn = false
        swt.tag = 0
        return swt
    }()
    
    let switch2 : UISwitch = {
       let swt = UISwitch()
       swt.onTintColor = UIColor(red: 142/255, green: 196/255, blue: 0, alpha: 0.5)
       swt.isOn = false
       swt.tag = 1
       return swt
    }()
    
    let switch3 : UISwitch = {
       let swt = UISwitch()
       swt.onTintColor = UIColor(red: 142/255, green: 196/255, blue: 0, alpha: 0.5)
       swt.isOn = false
        swt.tag = 2
       return swt
    }()
    
    let switch4 : UISwitch = {
       let swt = UISwitch()
       swt.onTintColor = UIColor(red: 142/255, green: 196/255, blue: 0, alpha: 0.5)
       swt.isOn = false
         swt.tag = 3
       return swt
    }()
    
    
    
    let createButton : UIButton = {
        let btn = UIButton( frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        btn.clipsToBounds = true
        btn.setTitle("Add", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        btn.tag = 0
        return btn
    }()
    
    let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: UIProgressView.Style.bar)
        progress.trackTintColor = .white
        return progress
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(nameField)
        addSubview(queryField)
        addSubview(resultLabel)
        addSubview(dividerView)
        
        containerView1.addSubview(label1)
        containerView1.addSubview(switch1)
        containerView1.addSubview(label2)
        containerView1.addSubview(switch2)
        containerView1.addSubview(label3)
        containerView1.addSubview(switch3)
        containerView1.addSubview(label4)
        containerView1.addSubview(switch4)
        setUpContainerConstraints()
        
        addSubview(createButton)
        addSubview(containerView1)
        addSubview(progressBar)
        
        setUpConstraints()
        
        
    }
    
    func setUpContainerConstraints(){
        
        //Label 1 and Switch 1
        label1.addConstraints(top: containerView1.topAnchor, topConstant: 15, bottom: nil, leading: containerView1.leadingAnchor, trailing: nil, constant: 10)
        label1.trailingAnchor.constraint(equalTo: containerView1.trailingAnchor, constant: -(screenSize.width/2)).isActive = true
        
        switch1.addConstraints(top: containerView1.topAnchor, topConstant: 10, bottom: nil, leading: nil, trailing: containerView1.trailingAnchor, constant: 0)
        switch1.leadingAnchor.constraint(equalTo: containerView1.leadingAnchor, constant: screenSize.width - (screenSize.width/5)).isActive = true
        
        
        //Label2 and switch 2
        label2.addConstraints(top: label1.bottomAnchor, topConstant: 25, bottom: nil, leading: containerView1.leadingAnchor, trailing: nil, constant: 10)
        label2.trailingAnchor.constraint(equalTo: containerView1.trailingAnchor, constant: -(screenSize.width/2)).isActive = true
               
        switch2.addConstraints(top: switch1.bottomAnchor, topConstant: 20, bottom: nil, leading: nil, trailing: containerView1.trailingAnchor, constant: 0)
        switch2.leadingAnchor.constraint(equalTo: containerView1.leadingAnchor, constant: screenSize.width - (screenSize.width/5)).isActive = true
        
        //Label3 and switch 3
        label3.addConstraints(top: label2.bottomAnchor, topConstant: 25, bottom: nil, leading: containerView1.leadingAnchor, trailing: nil, constant: 10)
        label3.trailingAnchor.constraint(equalTo: containerView1.trailingAnchor, constant: -(screenSize.width/2)).isActive = true
               
        switch3.addConstraints(top: switch2.bottomAnchor, topConstant: 20, bottom: nil, leading: nil, trailing: containerView1.trailingAnchor, constant: 0)
        switch3.leadingAnchor.constraint(equalTo: containerView1.leadingAnchor, constant: screenSize.width - (screenSize.width/5)).isActive = true
        
        //Label4 and switch 4
        label4.addConstraints(top: label3.bottomAnchor, topConstant: 25, bottom: nil, leading: containerView1.leadingAnchor, trailing: nil, constant: 10)
        label4.trailingAnchor.constraint(equalTo: containerView1.trailingAnchor, constant: -(screenSize.width/2)).isActive = true
               
        switch4.addConstraints(top: switch3.bottomAnchor, topConstant: 20, bottom: nil, leading: nil, trailing: containerView1.trailingAnchor, constant: 0)
        switch4.leadingAnchor.constraint(equalTo: containerView1.leadingAnchor, constant: screenSize.width - (screenSize.width/5)).isActive = true
    }
    
    func setUpConstraints(){
        nameField.addConstraints(top: topAnchor, topConstant: 100 , bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, constant: 20)
               
           queryField.addConstraints(top: nameField.bottomAnchor, topConstant: 20 , bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, constant: 20)
           
           resultLabel.addConstraints(top: queryField.bottomAnchor, topConstant: 20, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, constant: 20)
           
           dividerView.addConstraints(top: resultLabel.bottomAnchor, topConstant: 8, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, constant: 20)
           
           dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
           
           containerView1.addConstraints(top: dividerView.bottomAnchor, topConstant: 20, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, constant: 10)
           
           containerView1.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
          createButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
           createButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
         createButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been initialized")
    }
    
}
