//
//  ProfileVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/1/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
protocol MainNavigationDelegate: class {
    func showAuthState()
}
protocol  ProfileVCProtcol: class{
func showloader()
func hideLoader()
func PresentError(errorMassage: String)
func setUpUserData(name: String, email: String, age: Int, id: String)
func setUpUserImage(userImage: Data)
func setDefaultUserimage()
func GoToSignInVC()
}
class ProfileVC: UITableViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var ageLbL: UILabel!
    @IBOutlet weak var emaiLBL: UILabel!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var logOutBTN: UIButton!
    @IBOutlet weak var EditBTN: UIButton!

    //MARK: variables
   private var id: String!
   private var imagePicker: ImagePicker!
   private var textField1: UITextField?
   private var textField2: UITextField?
   private var textField3: UITextField?
   private var textField4: UITextField?
   private var presenter: ProfileVCViewModelProtocol!
   var  delegate: MainNavigationDelegate?
   // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPSupViews()
        presenter.getUserData()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        // Do any additional setup after loading the view.
    }
    //MARK: buttons
    //MARK: edit button
    @IBAction func editBTN(_ sender: Any) {
        present(showEditAlert(), animated: true)
    }
    //MARK: add user image button
    @IBAction func addUserImage(_ sender: UIButton) {
        imagePicker.present(from: sender )
    }
    //MARK: log out button
    @IBAction func loggingOut(_ sender: Any) {
        presenter.LoggingOut()
    }
    // MARK:- Puplic Method
    class func create() -> ProfileVC {
        let profileVC: ProfileVC = UIViewController.create(storyboardName: Storyboards.profile, identifier: ViewControllers.profilVC)
             profileVC.presenter = ProfileVCViewModel(view: profileVC)
        return profileVC
    }

}
//MARK:- private Func
extension ProfileVC{
    //MARK:-seting Sup Views
    private func setUPSupViews(){
        shapeTheBTNMaster(BTN: EditBTN, nameOfTheBTN: "Edit Your Profile")
        shapeTheBTNMaster(BTN: logOutBTN, nameOfTheBTN: "Log Out")
         setUpNavBar(disappear: false, titleOfNavBar: "Profile")
    }
    //MARK:- Set Up Navegation Bar
    private func setUpNavBar(disappear:Bool, titleOfNavBar: String = ""){
          self.navigationController?.isNavigationBarHidden = disappear
          self.navigationItem.title = titleOfNavBar
    }
    //MARK:- shaping Buttons
    private func shapeTheBTNMaster(BTN: UIButton, nameOfTheBTN: String){
        BTN.backgroundColor = .clear
        BTN.layer.cornerRadius = BTN.frame.height / 2
        BTN.layer.borderWidth = 4
        BTN.layer.borderColor = UIColor.darkGray.cgColor
        BTN.setTitle("\(nameOfTheBTN)", for: .normal)
        BTN.setTitleColor(UIColor.darkGray, for:UIControl.State.normal)
        }
}
//MARK:- user choose image
extension ProfileVC: ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        guard let UserImage = image!.jpegData(compressionQuality: 0.8) else {return}
        self.presenter.getUserImageFromVC(image: UserImage, id: id)
       
    }
    
    
}

//MARK: Edit Alert
extension ProfileVC: UITextFieldDelegate{
       //MARK:- show ALERT FOR EDIT PROFILE
       private func showAlertForEdit(){
            self.present(showEditAlert(), animated: true)
       }
       //MARK:- ALERT FOR EDIT PROFILE
       private func showEditAlert() -> UIAlertController{
           let alertEmailAddEditView:UIAlertController = {
           let alert = UIAlertController(title:"My App", message: "Customize Edit Email or Age or Name Pop Up", preferredStyle:UIAlertController.Style.alert)

           //ADD TEXT FIELD (YOU CAN ADD MULTIPLE TEXTFILED AS WELL)
       
           alert.addTextField { (textField : UITextField!) -> Void in
               textField.delegate = self
               textField.placeholder = "user name"
               self.textField1 = textField
           }
           alert.addTextField { (textField : UITextField!) -> Void in
               textField.delegate = self
               textField.keyboardType = UIKeyboardType.emailAddress
               self.textField2 = textField
               textField.placeholder = "user E-Mail"
           }
    
           alert.addTextField { (textField : UITextField!) -> Void in
               textField.delegate = self
               textField.keyboardType = UIKeyboardType.numberPad
               self.textField4 = textField
               textField.placeholder = "user Age"
           }

           //SAVE BUTTON
           let save = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { saveAction -> Void in
               let textField = alert.textFields![0] as UITextField
               let textField2 = alert.textFields![1]
               let textField3 = alert.textFields![2]
               self.presenter.UpdateUserDate(name: textField.text ?? "", age: textField3.text ?? "" , email: textField2.text ?? "")
           
           })
           //CANCEL BUTTON
           let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
               (action : UIAlertAction!) -> Void in })


           alert.addAction(save)
           alert.addAction(cancel)

           return alert
       }()
           return alertEmailAddEditView
       }

}
//MARK:- presenter delegate
extension ProfileVC: ProfileVCProtcol{
    func GoToSignInVC() {
        self.delegate?.showAuthState()
    }
    
    func showloader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func PresentError(errorMassage: String) {
        self.showAlert(title: "sorry", massage: "\(errorMassage)")
    }
    
    func setUpUserData(name: String, email: String, age: Int, id: String) {
        self.id = id
        self.ageLbL.text = "\(age)"
        self.nameLBL.text = "\(name)"
        self.emaiLBL.text = "\(email)"

    }
    
    func setUpUserImage(userImage: Data) {
        let image = UIImage(data: userImage)
        self.userImage.image = image
    }
    
    func setDefaultUserimage() {
        self.userImage.setImageForName(self.nameLBL.text ?? "" , backgroundColor: nil, circular: true, textAttributes: nil)
    }
    
    
}
