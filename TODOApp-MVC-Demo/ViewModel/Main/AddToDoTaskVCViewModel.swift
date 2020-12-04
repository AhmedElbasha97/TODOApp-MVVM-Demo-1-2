//
//  AddToDoTaskVCPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/15/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
protocol AddToDoTaskVCViewModelProtocol {
    func senddata(task: String, completion: @escaping () -> Void)
}
class AddToDoTaskVCViewModel{
      private weak var view: AddToDoTaskVCProtcol?
         
         // MARK:- Init
         init(view: AddToDoTaskVCProtcol) {
            self.view = view
            
         }

}
//MARK:- APIS
extension AddToDoTaskVCViewModel{
     //MARK:- APIS
    //MARK:- send task data
    private func SendTaskData(task: String){
     APIManager.addTask(task: task) { (response) in
         switch response{
         case .failure(let error):
             print("\(error.localizedDescription)")
 self.view?.PresentError(errorMassage: "\(error.localizedDescription)")
         case .success( _): break
            
         }
     }
        }
}
extension AddToDoTaskVCViewModel: AddToDoTaskVCViewModelProtocol{
        //MARK:- PUBLIC FUNC
        func senddata(task: String, completion: @escaping () -> Void){
            if validation.Shared().fieldIsNotEmpty(field:task){
               SendTaskData(task: task)
                completion()
                self.view?.Dismiss()
              
            }else{
                self.view?.PresentError(errorMassage: "please input your task")
            
        }
    }
}
