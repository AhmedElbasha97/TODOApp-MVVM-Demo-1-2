//
//  SignInPresenterVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/11/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
protocol SignInPresenterProtcol {
    func signingInMethod(email: String, Password: String)
}

import Foundation


class SignInVCPresenter{
    private weak var view: signInProtcol?
      
      // MARK:- Init
      init(view: signInProtcol) {
         self.view = view
      }

  
    }
    

extension SignInVCPresenter{
     // MARK:- Private Func
     // MARK:- API
    private func loggingIn(email: String, Password: String, completion: @escaping () -> Void){
        self.view?.showloader()
        APIManager.LogIn(email: email, password: Password) { (response) in
            switch (response){
            case .failure(let error):
                self.view?.presentError(errorMassage: error.localizedDescription)
                break
            case .success(let result):
                UserDefaultsManager.shared().token = result.token
                completion()
            }
        }
        self.view?.hideLoader()
        
    }
   
}
//MARK:- Validatons
extension SignInVCPresenter{
    //MARK:- Fields Isn't Empty
    private func CheckFieldsIsNotEmpty(email: String, password: String) -> Bool {
        if validation.Shared().fieldIsNotEmpty(field: email){
          if validation.Shared().fieldIsNotEmpty(field: password){
              return true
          }else{
            self.view?.presentError(errorMassage: "please write your password")
          return false
            }
         }else{
            self.view?.presentError(errorMassage: "please write your email")
            return false
         }
     }
    // MARK:- check validation
    private func checkValidation(email: String, password: String) -> Bool{
        if validation.Shared().isValidEmail(candidate:email){
            if validation.Shared().validpassword(mypassword: password){
                 return true
                
            }else{
                self.view?.presentError(errorMassage: "The Password Must Be Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character")
                return false
            }
        }else{
            self.view?.presentError(errorMassage: "Enter Valid E-Mail")
        return false
        }
       
    }
}
extension SignInVCPresenter: SignInPresenterProtcol{
    func signingInMethod(email: String, Password: String){
        if self.CheckFieldsIsNotEmpty(email: email, password: Password){
                  if self.checkValidation(email: email, password: Password){
                      self.loggingIn(email: email, Password: Password){
                          self.view?.switchToMainState()
                      }
                  }
              }
    }
}
