//
//  ToDoListView.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/23/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ToDoListView: UIView {
    @IBOutlet weak var todoTable: UITableView!
    func setUp(){
     setUpTheBackGroundImage(imageName: Background.insideTheApp, table: todoTable)
    }
    private func setUpTheBackGroundImage(imageName: String, table: UITableView)  {
    table.separatorStyle = UITableViewCell.SeparatorStyle.none
    table.backgroundView = UIImageView(image: UIImage(named: "\(imageName)"))
     }
}
