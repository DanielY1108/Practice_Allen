//
//  Member.swift
//  MemberList
//
//  Created by JinSeok Yang on 2022/10/04.
//

import UIKit


protocol MemeberDelegate: AnyObject {
    
    func addNewMember(_ member: Member)
    // 업데이트를 하려면 몇번째가 업데이트가 되는지 알아지 된다(index 필요)
    func update(index: Int, _ member: Member)
}


struct Member {
    
    lazy var memberImage: UIImage? = {
        guard let name = name else {
            return UIImage(systemName: "person")
        }
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    static var memberNumbers: Int = 0
    
    let memberId: Int
    var name: String?
    var age: Int?
    var phone: String?
    var address: String?
    
    init(name: String?, age: Int?, phone: String?, address: String?) {
        
        self.memberId = Member.memberNumbers
        
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        Member.memberNumbers += 1
    }
    
}

