//
//  AccountSession.swift
//  P-app
//
//  Created by Mick Wonnink on 12/3/15.
//  Copyright © 2015 p'app development. All rights reserved.
//

import Foundation

class AccountSession{
    
    var accountID : Int
    var displayName : String
    var email : String
    var password : String
    var experience : Int64
    var level : Int
    
    init(accountid : Int, displayname : String, email : String, password : String, experience : Int64, level : Int){
        self.accountID = accountid
        self.displayName = displayname
        self.email = email
        self.password = password
        self.experience = experience
        self.level = level
    }
    
    init(displayname : String, email : String, password : String){
        self.accountID = 0
        self.displayName = displayname
        self.email = email
        self.password = password
        self.experience = 0
        self.level = 1
    }
    
    func getAccountID() -> Int{
        return self.accountID
    }
    
    func getDisplayName() -> String{
        return self.displayName
    }
    
    func getEmail() -> String{
        return self.email
    }
    
    func getPassword() -> String{
        return self.password
    }
    
    func getExperience() -> Int64{
        return self.experience
    }
    
    func getLevel() -> Int{
        return self.level
    }
}