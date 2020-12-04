//
//  SignUpVCPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/13/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
protocol SignUpPresenterProtcol {
    func regestier(name: String, email: String, password: String, age: String)
    func SigningIn()
    
}
import Foundation
class SignUpVCPresenter{
    private weak var view: signUpProtcol?
        
        // MARK:- Init
        init(view: signUpProtcol) {
           self.view = view
        }
      }
      
//MARK:- APIS extension
extension SignUpVCPresenter{
    // MARK:- API
    private func SignUP(name: String, Password:String, Email:String, Age:String, completion: @escaping () -> Void ) {
        
        APIManager.Registier(name: name, email: Email, Age: Age, password: Password) { (response) in
            switch response{
            case .failure(let error):
                self.view?.presentError(errorMassage: "\(error.localizedDescription)")
             
            case .success(let result):
                UserDefaultsManager.shared().token = result.token
                
                              completion()
                
            }
        }
    
    }
}
//MARK:- Validatons
extension SignUpVCPresenter{
     //MARK:- Fields Isn't Empty
    private func CheckFieldsIsNotEmpty(name: String, Password:String, Email:String, Age:String) -> Bool{
        if validation.Shared().fieldIsNotEmpty(field: name){
            if validation.Shared().fieldIsNotEmpty(field: Email){
                if validation.Shared().fieldIsNotEmpty(field: Password){
                    if validation.Shared().fieldIsNotEmpty(field: Age){
                 return true
             }else{
                self.view?.presentError(errorMassage: "please write your age")
     
             }
          }else{
            self.view?.presentError(errorMassage: "please write your password")
        
          }
         }else{
             self.view?.presentError(errorMassage: "please write your E-Mail")
            
         }
     }else{
          self.view?.presentError(errorMassage: "please write your Name")
       
     }
     return false
     }
     // MARK:- check validation
     private func checkValidation(Password:String, Email:String) -> Bool{
        if validation.Shared().isValidEmail(candidate: Email){
             if validation.Shared().validpassword(mypassword: Password){
                 
                 return true
             }else{
                self.view?.presentError(errorMassage: "The Password Must Be Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character")

             }
         }else{
            self.view?.presentError(errorMassage: "please put your valid E-Mail")
            
         }
         return false
     }
}
extension SignUpVCPresenter: SignUpPresenterProtcol{
    func SigningIn() {
        view?.goToSignIn()
    }
    func regestier(name: String, email: String, password: String, age: String) {
             if CheckFieldsIsNotEmpty(name: name, Password: password, Email: email, Age: age){
                   if checkValidation(Password: password, Email: email){
                      SignUP(name:name , Password: password, Email: email , Age: age){
                        self.view?.switchToMainState()
                              }
                          }
                      }
            }
    }
    
    

