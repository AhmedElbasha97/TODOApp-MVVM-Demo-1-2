//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
protocol AuthNavigationDelegate: class {
    func showMainState()
}
protocol signInProtcol: class {
    func presentError(errorMassage: String)
    func switchToMainState()
    func showloader()
    func hideLoader()
}
class SignInVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var signInView: SignInView!
    //MARK:- variables
    var  viewModel: SignInPresenterProtcol!
    weak var  delegate: AuthNavigationDelegate?
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar(disappear: true)
        signInView.SetUpUp(view: self.signInView)
    }
    //MARK:- buttons
    //MARK:- gotoSignUpVC
    @IBAction func signUpBTN(_ sender: Any) {
      goToSignUP()
    }
    //MARK:- signIn Button
    @IBAction func signInBTN(_ sender: Any) {
        viewModel.signingInMethod(email: signInView.emailTextField.text ?? "", Password: signInView.passwordTextField.text ?? "")
    }
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        signInVC.viewModel = SignInVCPresenter(view: signInVC)
        return signInVC
    }
    private func setUpNavBar(disappear:Bool, titleOfNavBar: String = ""){
          self.navigationController?.isNavigationBarHidden = disappear
          self.navigationItem.title = titleOfNavBar
    }
    private func goToSignUP(){
             let signUpVC = SignUPVC.create()
             signUpVC.delegate = delegate
              self.navigationController!.pushViewController(signUpVC, animated: true)
    }
}
//MARK:- ShowAlertForError
extension SignInVC: signInProtcol{
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

}
