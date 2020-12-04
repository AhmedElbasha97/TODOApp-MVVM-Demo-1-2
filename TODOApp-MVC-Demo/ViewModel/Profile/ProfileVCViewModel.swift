//
//  ProfileVCPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/13/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//



import Foundation
protocol ProfileVCViewModelProtocol {
    //MARK:- get user image from VC
    func getUserImageFromVC(image: Data, id: String)
    //MARK:- get all user data
    func getUserData()
    //MARK:- UpdateUserData
    func UpdateUserDate(name: String?, age: String?, email:String?)
    //MARK:- logOutTheUser
    func LoggingOut()
}
class ProfileVCViewModel{
    private weak var view: ProfileVCProtcol?
       
       // MARK:- Init
       init(view: ProfileVCProtcol) {
          self.view = view
          
       }

}

extension ProfileVCViewModel{
    //MARK:- privateFunc
    //MARK:- APIs
    //MARK:- get user data
       private func getDataOfTheUser() {
        self.view?.showloader()
           APIManager.getUserData { (response) in
               switch response{
               case .failure(let error):
                   print("\(error.localizedDescription)")
                 self.view?.PresentError(errorMassage: "\(error.localizedDescription)")
               case .success(let UserData):
                self.view?.setUpUserData(name: UserData.name, email: UserData.email, age: UserData.age, id: UserData.id)
                self.GetUserImage(id: UserData.id)
               }
        }
        self.view?.hideLoader()
    }
    //MARK:- send user image
    private func sendUserImage(image: Data, id:String){
       
        APIManager.uploadImage(userimage: image ) { (result) in
            if result{
                self.GetUserImage(id: id)
            }else{
                self.view?.PresentError(errorMassage: "your image will not be uploaded please try again later")
              
            }
        }
    }
     //MARK:- log out user
    private func LogOut() {
     APIManager.logOutTheUser { (response) in
         switch response{
         case .failure(let error):
             print("\(error.localizedDescription)")
            self.view?.PresentError(errorMassage: "\(error.localizedDescription)")
         case .success(_ ):
            self.view?.GoToSignInVC()
              UserDefaultsManager.shared().token = nil
         }
     }
    }
        //MARK:- get User Image
        func GetUserImage(id: String){
            APIManager.getUserImage(with: id) { (response) in
                switch response{
                case.failure(let error):
                    
                   self.view?.PresentError(errorMassage: "\(error.localizedDescription)")
                    self.view?.setDefaultUserimage()
                case.success(let data):
                 
                    self.view?.setUpUserImage(userImage: data)
                 
                    }
            }
        }
    //MARK:- edit user profile
    private func editUserProfile(name: String = "", age: String = "", email:String = ""){
        self.view?.showloader()
        APIManager.updteDataOfTheUser(name: name, email: email, Age: age) { (response) in
              switch response{
              case .failure(let error):
                  print("\(error.localizedDescription)")
                  self.view?.PresentError(errorMassage: "\(error.localizedDescription)")
                case .success(let UserData):
                    self.view?.setUpUserData(name: UserData.userData.name, email: UserData.userData.email, age: UserData.userData.age, id: UserData.userData.id)
                  
              }
          }
        self.view?.hideLoader()
      }
}
//MARK:- validation
extension ProfileVCViewModel{
    //MARK:- check validation
    private func checkVedlition(name: String = "", age: String = "", email:String = "") -> Bool {
        if validation.Shared().fieldIsNotEmpty(field: name){
            return true
        }else if validation.Shared().fieldIsNotEmpty(field: email){
            if validation.Shared().isValidEmail(candidate: email){
             return true
            }else{
                self.view?.PresentError(errorMassage: "please enter valid email")
                }
            }else if validation.Shared().fieldIsNotEmpty(field: age){
        return true
        }else{
            self.view?.PresentError(errorMassage: "please enter anything to edit your profile.")
           
        }
    
    return false
        
    }
}
extension ProfileVCViewModel: ProfileVCViewModelProtocol{

    
    //MARK:- get user image from VC
    func getUserImageFromVC(image: Data, id: String){
       sendUserImage(image: image, id: id)
    }
    //MARK:- get all user data
    func getUserData(){
        getDataOfTheUser()
    }
    //MARK:- UpdateUserData
     func UpdateUserDate(name: String?, age: String?, email: String?) {
        if checkVedlition(name: name ?? "", age: age  ?? "", email: email  ?? ""){
                 editUserProfile(name: name  ?? "", age: age  ?? "", email: email  ?? "")
            }
    }
    
    //MARK:- logOutTheUser
    func LoggingOut(){
        LogOut()
       
    }
}
