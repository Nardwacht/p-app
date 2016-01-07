//
//  AppHandler.swift
//  P-app
//
//  Created by Mick Wonnink on 12/3/15.
//  Copyright © 2015 p'app development. All rights reserved.
//

import Foundation

class AppHandler{
    
    static var accountSession : AccountSession = AccountSession(accountid: 1, displayname: "johnsnow", email: "john@snow.snow", password: "none", experience: 1337, level: 12)
    static var allPlanes = [Plane]()
    static var allMyPlanes = [Plane]()
    static var prevLocOfPlanes = [PreviousLocation]()
    static var succesRegister = false
    static var response : String = "none"
    
    init(){
        
    }
    
    
    
    static func tryRegister(name : String, email : String, pass : String) {
        
        var doneBool : Bool = false
        var newAccount : AccountSession = AccountSession(accountid: 0, displayname: name, email: email, password: pass, experience: 0, level: 0)
        
        DatabaseMediator.instance.registerAccount(newAccount) { responseObject, error in
            
            let json : JSON = responseObject!
            var accountFound : AccountSession = self.accountSession
            
            for index in 0...json["response"]["list"].count - 1 {
                
                let check : Int? = Int(String(json["response"]["list"][index]["succes"]))
                
                if (check == 1){
                    succesRegister = true;
                }
                
                
            }
            
            doneBool = true
            return
        }
        
        while(!doneBool){
            
        }
    }
    
     static func tryLogin(email : String, pass : String){
        var doneBool : Bool = false
        
        DatabaseMediator.instance.loginAccount(email, password: pass) { responseObject, error in
            print(responseObject)
            
            let json : JSON = responseObject!
            var accountFound : AccountSession = self.accountSession
            
            for index in 0...json["response"]["list"].count - 1 {
                
                let accountid : Int? = Int(String(json["response"]["list"][index]["accountID"]))
                let displayname : String = String(json["response"]["list"][index]["displayName"])
                let email : String = String(json["response"]["list"][index]["email"])
                let password : String = String(json["response"]["list"][index]["password"])
                let experience : Int64? = Int64(String(json["response"]["list"][index]["experience"]))
                let level : Int? = Int(String(json["response"]["list"][index]["level"]))
                
                
                self.accountSession = AccountSession(accountid: accountid!, displayname: displayname, email: email, password: password, experience: experience!, level: level!)
                
                
            }
            
            doneBool = true
            return
        }
        
        while(!doneBool){
            
        }
    }
    
    
    static func throwNewPlane(startposition : Position, titel : String, message : String, degrees : Int) {
        var doneBool : Bool = false;
        
        DatabaseMediator.instance.addPaperPlane(self.accountSession.getAccountID(), scoreTotal: 0, title: titel, content: message, userDisplayName: self.accountSession.getDisplayName(), amountOfThrows: 1, hlat: startposition.getLat(), hlong: startposition.getLong(), hrot: degrees, inair: 1, active: 1) { responseObject, error in
            print(responseObject)
            
            let json : JSON = responseObject!
                
                let workedMessage : String? = String(json["response"]["check"])
            self.response = workedMessage!
            
            doneBool = true
            return
        }
        
        while(!doneBool){
            
        }

    }
    
    static func loadAllPreviousLocations(planeID : Int){
        var doneBool : Bool = false
        
        DatabaseMediator.instance.GetAllPreviousLocations(planeID) { responseObject, error in
            print(responseObject)
            
            let json : JSON = responseObject!
            
            for index in 0...json["response"]["list"].count - 1 {
                
                let locID : Int? = Int(String(json["response"]["list"][index]["locID"]))
                let planeID : Int? = Int(String(json["response"]["list"][index]["planeID"]))
                let long : Float? = Float(String(json["response"]["list"][index]["long"]))
                let lat : Float? = Float(String(json["response"]["list"][index]["lat"]))
                let rotation : Int? = Int(String(json["response"]["list"][index]["rotation"]))
                let throwDate : String = String(json["response"]["list"][index]["date"])

                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let nsthrowDate : NSDate? = dateFormatter.dateFromString( throwDate )
                

                let position : Position = Position(long: long!, lat: lat!)
                
                
                self.prevLocOfPlanes.append(PreviousLocation(locid: locID!, planeid: planeID!, date: nsthrowDate!, pos: position, rotation: rotation!))
                
                
            }
            
            doneBool = true
            return
        }
        
        while(!doneBool){
            
        }

    }
    
    static func loadAllUserPlanes(accountID : Int) {
        
        var doneBool : Bool = false
        
        DatabaseMediator.instance.getPlanesFromUser(accountID) { responseObject, error in
            print(responseObject)
            
            let json : JSON = responseObject!
            
            for index in 0...json["response"]["list"].count - 1 {
                
                let planeID : Int? = Int(String(json["response"]["list"][index]["planeID"]))
                let accountID : Int? = Int(String(json["response"]["list"][index]["accountID"]))
                let userDisplayName : String = String(json["response"]["list"][index]["userDisplayName"])
                let title : String = String(json["response"]["list"][index]["title"])
                let content : String = String(json["response"]["list"][index]["content"])
                let amountOfThrows : Int? = Int(String(json["response"]["list"][index]["amountOfThrows"]))
                let scoreTotal : Int? = Int(String(json["response"]["list"][index]["scoreTotal"]))
                let throwDate : String = String(json["response"]["list"][index]["throwDate"])
                let hLat : Float? = Float(String(json["response"]["list"][index]["hLat"]))
                let hLong : Float? = Float(String(json["response"]["list"][index]["hLong"]))
                let hRotation : Int? = Int(String(json["response"]["list"][index]["hRotation"]))
                let active : Int? = Int(String(json["response"]["list"][index]["active"]))
                let isflying : Int? = Int(String(json["response"]["list"][index]["inAir"]))
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let nsthrowDate : NSDate? = dateFormatter.dateFromString( throwDate )
                
                let boolactive : Bool = active == 1
                let boolisflying : Bool = isflying == 1
                let position : Position = Position(long: hLat!, lat: hLong!)
                
                
                self.allMyPlanes.append(Plane(planeid: planeID!, userid: accountID!, message: content, userdisplayname: userDisplayName, throwdate: nsthrowDate!, totalscore: scoreTotal!, aot: amountOfThrows!, titel: title, active: boolactive, isflying: boolisflying, rot: hRotation!, currentpos: position))
                
                
            }
            
            doneBool = true
            return
        }
        
        while(!doneBool){
            
        }
        
    }

    
    static func loadAllPlanes() {
        
        var doneBool : Bool = false

        DatabaseMediator.instance.getAllPlanes() { responseObject, error in
            print(responseObject)
            
            let json : JSON = responseObject!
            
            for index in 0...json["response"]["list"].count - 1 {
                
                let planeID : Int? = Int(String(json["response"]["list"][index]["planeID"]))
                let accountID : Int? = Int(String(json["response"]["list"][index]["accountID"]))
                let userDisplayName : String = String(json["response"]["list"][index]["userDisplayName"])
                let title : String = String(json["response"]["list"][index]["title"])
                let content : String = String(json["response"]["list"][index]["content"])
                let amountOfThrows : Int? = Int(String(json["response"]["list"][index]["amountOfThrows"]))
                let scoreTotal : Int? = Int(String(json["response"]["list"][index]["scoreTotal"]))
                let throwDate : String = String(json["response"]["list"][index]["throwDate"])
                let hLat : Float? = Float(String(json["response"]["list"][index]["hLat"]))
                let hLong : Float? = Float(String(json["response"]["list"][index]["hLong"]))
                let hRotation : Int? = Int(String(json["response"]["list"][index]["hRotation"]))
                let active : Int? = Int(String(json["response"]["list"][index]["active"]))
                let isflying : Int? = Int(String(json["response"]["list"][index]["inAir"]))
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let nsthrowDate : NSDate? = dateFormatter.dateFromString( throwDate )
                
                let boolactive : Bool = active == 1
                let boolisflying : Bool = isflying == 1
                let position : Position = Position(long: hLat!, lat: hLong!)
                
                
                self.allPlanes.append(Plane(planeid: planeID!, userid: accountID!, message: content, userdisplayname: userDisplayName, throwdate: nsthrowDate!, totalscore: scoreTotal!, aot: amountOfThrows!, titel: title, active: boolactive, isflying: boolisflying, rot: hRotation!, currentpos: position))
                
                
            }

            doneBool = true
            return
        }
        
        while(!doneBool){
            
        }

    }
    
    func getAllNearbyPlanes(currentposition : Position) -> [Plane] {
        var allmyPlanes = [Plane]()
        
        return allmyPlanes
    }
    
    func getCurrentUserPosition() -> Position{
        var currentUserPosition = Position(long: 0,lat: 0)
        
        return currentUserPosition
    }
    
    func ratePlane(rating : Int, plane : Plane) -> Bool{
        
        return false
    }
    
    func retrievePlane(plane : Plane) -> Bool{
        
        return false
    }
    
    func reThrowExistingPlane(startposition : Position, message : String, degrees : Float) -> PreviousLocation {
        var prevloc : PreviousLocation = PreviousLocation(locid: 0, planeid: 0, date: NSDate(), pos: Position(long: 0, lat: 0), rotation: 0)
        
        return prevloc
    }
    
    
    
}
