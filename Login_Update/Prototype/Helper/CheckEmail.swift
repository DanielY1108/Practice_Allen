//
//  CheckEmail.swift
//  Login
//
//  Created by JinSeok Yang on 2022/10/13.
//

import Foundation

struct CheckEmail {
    
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
}
