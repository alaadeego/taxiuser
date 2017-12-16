//
//  user.swift
//  Mashy
//
//  Created by Amal Khaled on 11/3/17.
//  Copyright © 2017 amany. All rights reserved.
//

import Foundation

class User {
    var email : String
    var pass : String
    var name : String
    var phone : String
    var ID : String = ""


    
    init(email : String , pass : String) {
        self.email = email
        self.pass = pass
        self.name = ""
        self.phone = ""
    }
    init(email : String , pass : String , name : String , phone : String) {
        self.email = email
        self.pass = pass
        self.name = name
        self.phone = phone
    }
    init() {
        self.email = ""
        self.pass = ""
        self.name = ""
        self.phone = ""
    }
}
