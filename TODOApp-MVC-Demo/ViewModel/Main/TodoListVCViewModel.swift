//
//  todoListVCPrsenter.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/15/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
protocol TodoListVCPrsenterProtcol {
    func deleteTask(taskID: String)
    func getTadaForTodoTable()
    func getNumberOfRowS() -> Int
    func getTasks(index: Int) -> String
    func getTaskSId(index: Int) -> String

}

class TodoListVCPrsenter{
    
    private var arrOfTask: [String] = []
    private var arrOfTaskId: [String] = []
    private weak var view: TodoListVCProtcol?
         
         // MARK:- Init
         init(view: TodoListVCProtcol) {
           self.view = view
         }

}
 //MARK:- APIS
extension TodoListVCPrsenter{
     //MARK:- getDataOfTodoTable
 private func getTasksData(){
    self.view?.showloader()
     APIManager.getTodos { (response) in
         switch response{
         case .failure(let error):
             print("\(error.localizedDescription)")
             self.view?.PresentError(errorMassage: "\(error.localizedDescription)")
         case.success(let result):
              var tasks: [String] = []
                   var tasksId: [String] = []
                   for todo in result.data{
                   tasks.append(todo.description)
                    tasksId.append(todo.id)
                   }
              self.arrOfTask = tasks
              self.arrOfTaskId = tasksId
              self.view?.reloadData()
            
         }
     }
     self.view?.hideLoader()
     
   }
//MARK:- deleteTAsk
    private func DeleteTask(taskId: String, completion: @escaping () -> Void ){
        APIManager.DelteTaskByid(taaskId: taskId) { (result) in
        switch result{
        case .failure(let error):
            print("\(error.localizedDescription)")
                 self.view?.PresentError(errorMassage: "\(error.localizedDescription)")
        case .success(_ ):
             completion()
        }
    }
       
}

}
extension TodoListVCPrsenter: TodoListVCPrsenterProtcol{
    func getTaskSId(index: Int) -> String {
        return self.arrOfTaskId[index]
    }
    
    func getTasks(index: Int) -> String {
        return self.arrOfTask[index]
    }
    
    func getNumberOfRowS() -> Int {
        return arrOfTask.count
    }
    
    func getTadaForTodoTable(){
        getTasksData()
    }
    
    func deleteTask(taskID: String){
        DeleteTask(taskId: taskID) {
            self.getTasksData()
        }
    }
  
    
    
}
