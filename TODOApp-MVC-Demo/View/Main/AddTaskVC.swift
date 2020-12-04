//
//  AddTaskVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
protocol AddToDoTaskVCProtcol: class {
    func PresentError(errorMassage: String)
    func Dismiss()
}
protocol refreshDataDelegate: AnyObject {
    func refreshData()
}
class AddTaskVC: UIViewController {
   //MARK:- Outlets
    @IBOutlet weak var addTaskView: AddTaskView!
    //MARK:- variables
   weak var delegate: refreshDataDelegate?
    var presenter: AddToDoTaskVCViewModelProtocol!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar(disappear: true)
        self.addTaskView.setUp()
    }
//MARK:- Buttons
    //MARK:- Exit Buuton
    @IBAction func exitBTN(_ sender: Any) {
     Dismiss()
    }
    //MARK:- Add Task Button
    @IBAction func AddTaskBtn(_ sender: Any) {
        presenter.senddata(task: self.addTaskView.addTaskTextField.text ?? "") {
            self.delegate?.refreshData()
        }
    }
    //Mark:- puplic Method
    class func create() -> AddTaskVC {
        let addToDoVC: AddTaskVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.addToDoVC)
         addToDoVC.presenter = AddToDoTaskVCViewModel(view: addToDoVC)
        return addToDoVC
    }
    private func setUpNavBar(disappear:Bool, titleOfNavBar: String = ""){
          self.navigationController?.isNavigationBarHidden = disappear
          self.navigationItem.title = titleOfNavBar
    }
}
extension AddTaskVC: AddToDoTaskVCProtcol{
    func PresentError(errorMassage: String) {
        self.showAlert(title: "sorry", massage: "\(errorMassage)")
    }
    
    func Dismiss() {
          self.dismiss(animated: true, completion: nil)
    }
}

