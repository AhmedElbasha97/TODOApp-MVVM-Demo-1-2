//
//  ProfileView.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedElbasha on 30/11/2020.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
protocol MainNavigationDelegate: class {
    func showAuthState()
}
class ProfileView: UITableView {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var ageLbL: UILabel!
    @IBOutlet weak var emaiLBL: UILabel!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var logOutBTN: UIButton!
    @IBOutlet weak var EditBTN: UIButton!
    func setUP(tableView: UITableView){
        shapeTheBTNMaster(BTN: EditBTN, nameOfTheBTN: "Edit Your Profile")
        shapeTheBTNMaster(BTN: logOutBTN, nameOfTheBTN: "Log Out")
        setUpTableView(tableView: tableView)
    }
    //MARK:- shapeTheuttons
    private func shapeTheBTNMaster(BTN: UIButton, nameOfTheBTN: String){
        BTN.backgroundColor = .clear
        BTN.layer.cornerRadius = BTN.frame.height / 2
        BTN.layer.borderWidth = 4
        BTN.layer.borderColor = UIColor.darkGray.cgColor
        BTN.setTitle("\(nameOfTheBTN)", for: .normal)
        BTN.setTitleColor(UIColor.darkGray, for:UIControl.State.normal)
        }
    func setUpTableView(tableView: UITableView){
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            switch section {
            case 1:
                return "User Image"
            case 2:
                return "Etid Your Profile"
            case 3:
                return "User Name"
            case 4:
                return "User E-mail"
            case 5:
                return "User Age"
            case 6:
                return "Log Out"
            default:
                return "  "
            }
        }
    }
}

