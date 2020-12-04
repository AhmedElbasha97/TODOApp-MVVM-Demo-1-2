//
//  AddTaskView.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/24/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class AddTaskView: UIView {
    @IBOutlet weak var addTaskView: UIView!
    @IBOutlet weak var addTaskTextField: UITextField!
    @IBOutlet weak var addTaskLabel: UILabel!
    @IBOutlet weak var addTaskButton: UIButton!
    
    func setUp(){
        setUpTheBackGroundImage(imageName: Background.athentication, view: addTaskView)
        setUpTheLBL(label: addTaskLabel, LabelData: "Add Task", fontSize: 32.0, fontName: "System")
        shapeOfTextField(textField: addTaskTextField, placeHolder: "please Enter Your Task", isSceure: false, keyBoardType: .default)
        shapeTheBTNMaster(BTN: addTaskButton, nameOfTheBTN: "Add Task")
    }
    
    private func setUpTheBackGroundImage(imageName: String, view: UIView)  {
    view.layer.cornerRadius = 25
    view.backgroundColor = UIColor(patternImage: UIImage(named: "\(imageName)")! )
     }
          //MARK:- shapping the textfield
     private func shapeOfTextField(textField: UITextField, placeHolder: String, isSceure: Bool, keyBoardType: UIKeyboardType){
         textField.backgroundColor = UIColor(white: 1, alpha: 0.5)
         textField.layer.cornerRadius = 35
         textField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
         textField.layer.borderWidth = 0.5
         textField.clipsToBounds = true
         textField.placeholder = placeHolder
         textField.isSecureTextEntry = isSceure
         textField.keyboardType = keyBoardType
       
     }
    //MARK:- shapeTheButtons
    private func shapeTheBTNMaster(BTN: UIButton, nameOfTheBTN: String){
        BTN.backgroundColor = .clear
        BTN.layer.cornerRadius = BTN.frame.height / 2
        BTN.layer.borderWidth = 4
        BTN.layer.borderColor = UIColor.darkGray.cgColor
        BTN.setTitle("\(nameOfTheBTN)", for: .normal)
        BTN.setTitleColor(UIColor.darkGray, for:UIControl.State.normal)
        }
    //MARK:- setUPTheLabel
    private func setUpTheLBL(label: UILabel, LabelData: String, fontSize: Double, fontName: String){
        label.text = LabelData
        label.font = UIFont(name:"\(fontName)", size: CGFloat(fontSize))
    }

}
