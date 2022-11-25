//
//  ViewController.swift
//  MemberList
//
//  Created by JinSeok Yang on 2022/10/04.
//

import UIKit


final class ViewController: UIViewController {
    
    private var tableView = UITableView()
    
    let memberListManager = MemberListMananger()
    
    lazy var tabBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tabBarButtonTapped))
        return button
    }()
    
    //커스텀으로 만들면 필요없을 것 같다
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        tableView.reloadData()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupTableView()
        setupNavBar()
        setupTableViewConstraints()
    
    }
    
    
    func setupData() {
        memberListManager.makeMembersListDatas()
    }
    
    func setupNavBar() {
        
        title = "회원 목록"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.rightBarButtonItem = self.tabBarButton
        
    }
    
    @objc func tabBarButtonTapped() {
        print(#function)
        
        let infoVC = InfoViewController()
        
        navigationController?.pushViewController(infoVC, animated: true)
        
        infoVC.delegate = self
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 70
        
        view.addSubview(tableView)
        
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MemberCell")
        
    }
    
    func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMembersList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MyTableViewCell
        
        //        var member = memberListManager.getMembersList()[indexPath.row]
        
        //        cell.memberImageView.image = member.memberImage
        //        cell.memberNameLabel.text = member.name
        //        cell.memberAdressLabel.text = member.address
        
        // 속성 감시자(member)로 값을 받아온다
        cell.member = memberListManager[indexPath.row]
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let infoVC = InfoViewController()
        
        let array = memberListManager.getMembersList()
        infoVC.member = array[indexPath.row]
        
        infoVC.delegate = self
        
        
        // infoVC 직접 데이터 접근
//        infoVC.infoView.member = infoVC.member
        
        navigationController?.pushViewController(infoVC, animated: true)
        
    }
    
    
}

extension ViewController: MemeberDelegate {
    func addNewMember(_ member: Member) {
        memberListManager.makeNewMember(member)
        tableView.reloadData()
    }
    
    func update(index: Int, _ member: Member) {
        memberListManager.updateMemberInfo(index: index, member)
        tableView.reloadData()
    }
    
    
}
