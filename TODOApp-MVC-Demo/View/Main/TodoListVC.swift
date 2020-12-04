//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
protocol TodoListVCProtcol: class {
    func showloader()
    func hideLoader()
    func PresentError(errorMassage: String)
    func GoToProfile()
    func AddToDo()
    func reloadData()
    
}
import UIKit

class TodoListVC: UIViewController {
//MARK:- variables
    var presenter: TodoListVCPrsenterProtcol!
    weak var delegate: MainNavigationDelegate?
//MARK:- Outlets

    @IBOutlet var toDoTableView: ToDoListView!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpNavBar(disappear: false, titleOfNavBar: "ToDo List")
          setupTableView()
          presenter.getTadaForTodoTable()
    }
    //MARK:- Buttons
    //MARK:- GO TO profile button
    @IBAction func profileBTN(_ sender: Any) {
          GoToProfile()
    }
    //MARK:- ADD task button
    @IBAction func addTaskBTN(_ sender: UIBarButtonItem) {
     AddToDo()
    }
    // MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
          todoListVC.presenter = TodoListVCPrsenter(view: todoListVC)
        return todoListVC
    }
    private func setUpNavBar(disappear:Bool, titleOfNavBar: String = ""){
          self.navigationController?.isNavigationBarHidden = disappear
          self.navigationItem.title = titleOfNavBar
    }
}
//MARK:- TableView Delegate
extension TodoListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 125.0
      }
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRowS()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.todoCell, for: indexPath) as? TodoCell else {
               return UITableViewCell()
           }
        cell.configure(todo:presenter.getTasks(index: indexPath.row), idOfToDo: presenter.getTasks(index: indexPath.row))
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.toDoTableView.todoTable.deselectRow(at: indexPath, animated: true)
    }
    
    
}
extension TodoListVC{
 
    //MARK:- Subviews
    //MARK- set up todo table
    private func setupTableView() {
        self.toDoTableView.todoTable.register(UINib.init(nibName: Cells.todoCell, bundle: nil), forCellReuseIdentifier: Cells.todoCell)
        self.toDoTableView.todoTable.dataSource = self
       self.toDoTableView.todoTable.delegate = self
        toDoTableView.setUp()
    }

}
//MARK:- showAlertDelegate
extension TodoListVC: showAlertOfDeletingDelegate{
    func showAlertOfDeleting(customTableViewCell: UITableViewCell, didTapButton button: UIButton, taskId: String) {
     print("protocol of vc")
             let alert = UIAlertController(title: "Sorry", message: "Are You Sure Want to Delete this TODO?", preferredStyle: .alert)
             
             let noAction = UIAlertAction(title: "No", style: .cancel) { (action) in
                 alert.dismiss(animated: true, completion: nil)
             }
             
             let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
                self.presenter.deleteTask(taskID: taskId)
                
             }
             alert.addAction(noAction)
             alert.addAction(yesAction)
             self.present(alert, animated: true, completion: nil)
         }
    }
    //MARK: refreshDatadelegate
extension TodoListVC: refreshDataDelegate{
    func refreshData() {
        presenter.getTadaForTodoTable()
    }
}
extension TodoListVC: TodoListVCProtcol{
    
    func showloader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func PresentError(errorMassage: String) {
         self.showAlert(title: "sorry", massage: "\(errorMassage)")
    }
    

    func GoToProfile() {
        let profileVC = ProfileVC.create()
        profileVC.delegate = delegate
             self.navigationController!.pushViewController(profileVC, animated: true)
    }
    
    func AddToDo() {
        let addTaskVC = AddTaskVC.create()
        addTaskVC.delegate = self
        present(addTaskVC, animated: true)

    }
    
    func reloadData() {
        self.toDoTableView.todoTable.reloadData()
       
    }
    
    
}
