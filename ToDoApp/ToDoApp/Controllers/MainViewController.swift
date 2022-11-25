//
//  ViewController.swift
//  ToDoApp
//
//  Created by JinSeok Yang on 2022/10/17.
//

import UIKit

class MainViewController: UIViewController {
    
    private let tableView = UITableView()
    
    let toDoManager = CoreDataManager.shared
    
    override func loadView() {
        self.view = tableView
        
    }
    
    var toDoData: ToDoData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        configureNavigationBar()

    }
    
    
    
}

extension MainViewController {
    
    func talbleViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }
    
    func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        // 기본 설정 (standard, compact, scrollEdge)
//        self.navigationController?.navigationBar.standardAppearance = appearance
//        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.backgroundColor = .systemPink
        navigationController?.navigationBar.barTintColor = .clear
        
        self.navigationItem.title = "To Do"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tabBarButtonTapped))
    }
    
    @objc func tabBarButtonTapped() {
        let detailVC = DetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoManager.getToDoListFromCoreData().count
    }
    
    // MARK: - comunication beween VC

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        
        let toDoData = toDoManager.getToDoListFromCoreData()
        cell.todoData = toDoData[indexPath.row]
        //        cell.delegate = self
        cell.contentView.isUserInteractionEnabled = false
        
        cell.updateButtonPressed = { [weak self] (senderCell) in
            print(#function)
            let detailVC = DetailViewController()
            detailVC.toDoData = self!.toDoManager.getToDoListFromCoreData()[indexPath.row]
            detailVC.modalPresentationStyle = .fullScreen
            self?.navigationController?.show(detailVC, sender: indexPath)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - delete

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDoData = toDoManager.getToDoListFromCoreData()[indexPath.row]
            toDoManager.deleteToDo(data: toDoData) {
                tableView.reloadData()
            }
            print(toDoManager.getToDoListFromCoreData())
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        action.backgroundColor = .clear
        action.image = UIImage(systemName: "trash.circle")
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
 
}
// MARK: -  Delegate

//extension MainViewController: ButtonDelegate {
//    func cellBtnTapped() {
//        print(#function)
//    }
//}

