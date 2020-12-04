//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
import UIKit

protocol signUpProtcol: class {
    func presentError(errorMassage: String)
    func switchToMainState()
    func showloader()
    func hideLoader()
    func goToSignIn()
}
class SignUPVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var signUpView: SignUpView!
    //MARK:- delegate
    var  presenter: SignUpPresenterProtcol!
   weak var  delegate: AuthNavigationDelegate?
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.SetUp(view: self.signUpView)
        setUpNavBar(disappear: true)
    }
   //MARK:- buttons
   //MARK:- goToSignInScreen
    @IBAction func goToSignInBTN(_ sender: Any) {
        presenter.SigningIn()
    }
    //MARK:- signUp
    @IBAction func signUpBTN(_ sender: Any) {
        presenter.regestier(name: self.signUpView.nameTextField.text ?? "", email: self.signUpView.emailTextField.text ?? "", password: self.signUpView.passwordTextField.text ?? "", age: self.signUpView.ageTextField.text ?? "")
        
    }
    // MARK:- Public Methods
    class func create() -> SignUPVC {
        let signUpVC: SignUPVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        signUpVC.presenter = SignUpVCPresenter(view: signUpVC)
        return signUpVC
    }
    private func setUpNavBar(disappear:Bool, titleOfNavBar: String = ""){
          self.navigationController?.isNavigationBarHidden = disappear
          self.navigationItem.title = titleOfNavBar
    }

}

//MARK:- ShowAlertForError
extension SignUPVC: signUpProtcol{
    
    func presentError(errorMassage: String) {
          showAlert(title: "sorry", massage: "\(errorMassage)")
    }
    
    func switchToMainState() {
        
        self.delegate?.showMainState()
        
    }
    
    func showloader() {
             self.view.showLoader()
         }
         
    func hideLoader() {
             self.view.hideLoader()
         }
    func goToSignIn(){
              self.navigationController!.pushViewController(SignInVC.create(), animated: true)
    }
}
