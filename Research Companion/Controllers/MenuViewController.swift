//
//  MenuViewController.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 29/12/2019.
//  Copyright © 2019 Isioma Anofienam. All rights reserved.
//

import Foundation
import UIKit


class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var table : UITableView!
    let cellId = "tableCell"
    let cellHeader = "tableHeader"
    var tagArray: [Int] = []
    
    var active = false
    
    var menuItem: [Section] = []
    
    func initializeTable(){
        
        table = UITableView(frame: CGRect(x: 0, y: topbarHeight, width: menuScreenSize, height: screenSize.height))
        table.register(TableCell.self, forCellReuseIdentifier: cellId)
        table.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: cellHeader)
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        table.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        table.separatorStyle = .none
//        table.backgroundColor = .clear
        view.addSubview(table)
    }
    
    func createMenuItem(){
        menuItem = [
            Section(name: "Resources", items: nil, collapsed: nil, activea: nil),
            Section(name: "History", items: ["Links", "Tags"], collapsed: true),
            Section(name: "Settings", items: ["Expanded search", "Limited search", "Background" ], collapsed: true),
            Section(name: "About", items: ["Acknowledgements"], collapsed: true),
            Section(name: "Rate Me", items: nil, collapsed: nil)
        ]
            
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTable()
        createMenuItem()
        navigationItem.title = "Menu"
        navigationController?.navigationBar.backgroundColor = .systemRed
        navigationController?.navigationBar.tintColor = .systemGray
        navigationController?.navigationBar.isTranslucent = true
        
        
        //change Menu views bg color here
//        view.backgroundColor = UIColor.black
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let collapsed = menuItem[section].collapsed  {
             return (collapsed ? 0 : menuItem[section].items!.count)
        }
        return 0
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TableCell
        
        let item = menuItem[indexPath.section].items![indexPath.row]
        cell.label1.text = item
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let collapsed = menuItem[indexPath.section].collapsed{
            
            if collapsed == true{
                return 0
            }
        }
        return 80
    }
   
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print( indexPath.section,  indexPath.row)

        if let menu = menuItem[indexPath.section].items?[indexPath.row] {
            
            if menu == "Links"{
                print(menu)
                navigationController?.pushViewController(HistoryController(), animated: true)
            }else if menu == "Tags"{
                print(menu)
                navigationController?.pushViewController(HistoryController(), animated: true)
            }else if menu == "Acknowledgements"{
                print(menu)
                navigationController?.pushViewController(AboutController(), animated: true)
            }else if menu == "Expanded search"{
                print(menu)
                navigationController?.pushViewController(SettingsController(), animated: true)
            }else if menu == "Limited search"{
                print(menu)
                navigationController?.pushViewController(SettingsController(), animated: true)
            }else if menu == "Background"{
                print(menu)
                navigationController?.pushViewController(SettingsController(), animated: true)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuItem.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: cellHeader) as! TableHeader
           tagArray.append(section)
           headerView.tag = section
           headerView.label1.text = menuItem[section].name
    
           if let items = menuItem[section].items{
               if !items.isEmpty{
                   headerView.imageView1.image = UIImage(named: "arrow")?.withTintColor(.white)
               }
           }
    
           let tap = UITapGestureRecognizer(target: self, action: #selector(expandMenu))
        
        
           headerView.isUserInteractionEnabled = true
           headerView.addGestureRecognizer(tap)
    
           if let collapsed = menuItem[section].collapsed{
            headerView.imageView1.transform = headerView.imageView1.transform.rotated(by: collapsed ? 0.0 : CGFloat(Double.pi))
           }
    
        return headerView
    }
    
//    [Assert] Unable to determine new global row index for preReloadFirstVisibleRow (0)
    
    //fix warning, it happens beacouse after collasing the cell rows, the table view cant
    //determine its current section index so its goes back top "0"
    
    @objc func expandMenu(sender: UITapGestureRecognizer){
          let tag = sender.view!.tag
    
          print("tappedd \(tag)")
        
          if let collapsed = menuItem[tag].collapsed {
                menuItem[tag].collapsed = !collapsed
                table.reloadSections(NSIndexSet(index: tag) as IndexSet, with: .automatic)
          }
        
          if menuItem[tag].name == "Resources"{
              navigationController?.pushViewController(ResourceController(), animated: true)
          }else if menuItem[tag].name == "Rate Me"{
              navigationController?.pushViewController(RateMeController(), animated: true)
          }
    }
}

//MARK :- Extensions

struct Section{
    var name: String?
    var items: [String]?
    var collapsed: Bool?
    var activea: Bool?
}

enum menuState {
    case expanded
    case collapsed
}

extension UIViewController{
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
