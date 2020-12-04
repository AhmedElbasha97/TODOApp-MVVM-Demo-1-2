//
//  SignInView.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/23/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignInView: UIView {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var goToSignUpLBL: UILabel!
    @IBOutlet weak var signInLbl: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    func SetUpUp(view: UIView){
        setUpTheLBL(label: signInLbl, LabelData: "Sign In", fontSize: 44.0, fontName: "Kefa")
        setUpTheLBL(label: goToSignUpLBL, LabelData: "If You Aren't Already Regestier", fontSize: 15.0, fontName: "System")
        shapeTheBTNMaster(BTN: signInBtn, nameOfTheBTN:"Sign In")
        shapeTheBTNBranches(BTN: signUpBtn, nameOfTheBTN: "Sign Up")
    
        shapeOfTextField(textField: emailTextField, iconName: "emailIcon", placeHolder: "Enter Your Email", isSceure: false, keyBoardType: .emailAddress)
        shapeOfTextField(textField: passwordTextField, iconName:  "passwordIcon", placeHolder: "Enter Your Password", isSceure: true, keyBoardType: .alphabet)
  
        setUpTheBackGroundImage(imageName: "\(Background.athentication)", view: view)
        
    }
    //MARK:- set up backGround image for the views
     private func setUpTheBackGroundImage(imageName: String, view: UIView)  {
          let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
          backgroundImage.image = UIImage(named: "\(imageName)")
          backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
          view.insertSubview(backgroundImage, at: 0)
      }
     //MARK:- shapping the Button
    private func shapeTheBTNMaster(BTN: UIButton, nameOfTheBTN: String){
        BTN.backgroundColor = .clear
        BTN.layer.cornerRadius = BTN.frame.height / 2
        BTN.layer.borderWidth = 4
        BTN.layer.borderColor = UIColor.darkGray.cgColor
        BTN.setTitle("\(nameOfTheBTN)", for: .normal)
        BTN.setTitleColor(UIColor.darkGray, for:UIControl.State.normal)
        }
    private func shapeTheBTNBranches(BTN: UIButton, nameOfTheBTN: String){
             BTN.setTitle("\(nameOfTheBTN)", for: .normal)
    }
          //MARK:- shapping the textfield
     private func shapeOfTextField(textField: UITextField, iconName: String, placeHolder: String, isSceure: Bool, keyBoardType: UIKeyboardType){
         textField.backgroundColor = UIColor(white: 1, alpha: 0.5)
         textField.layer.cornerRadius = 35
         textField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
         textField.layer.borderWidth = 0.5
         textField.clipsToBounds = true
         textField.placeholder = placeHolder
         textField.isSecureTextEntry = isSceure
         textField.keyboardType = keyBoardType
         let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
         let image = UIImage(named: "\(iconName)")
         imageView.image = image
         imageView.contentMode = .scaleAspectFit
         let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
         view.addSubview(imageView)
         textField.leftViewMode = UITextField.ViewMode.always
         textField.leftView = view
     }
      //MARK:- setUPTheLabel
    private func setUpTheLBL(label: UILabel, LabelData: String, fontSize: Double, fontName: String){
        label.text = LabelData
        label.font = UIFont(name:"\(fontName)", size: CGFloat(fontSize))
    }
}
