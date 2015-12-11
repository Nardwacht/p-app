//
//  AppHandler.swift
//  P-app
//
//  Created by Mick Wonnink on 12/3/15.
//  Copyright © 2015 p'app development. All rights reserved.
//

import Foundation

class AppHandler{
    
    static var accountSession : AccountSession = AccountSession(displayname: "none", email: "none", password: "none")
    static var allPlanes = [Plane]()
    static var allMyPlanes = [Plane]()
    
    init(){
        
    }
    
    static func getAllPlanes() -> [Plane] {
        return self.allPlanes
    }
    
    static func getAllMyPlanes() -> [Plane] {
        return self.allMyPlanes
    }
    
    func register(name : String, email : String, pass : String) -> Bool{
        
        let session : AccountSession = AccountSession(accountid: 1, displayname: name, email: email, password: pass, experience: 0, level: 1)
    
        return DatabaseMediator.instance.registerAccount(session)
    }
    
    func login(email : String, pass : String) -> Bool{
        AppHandler.accountSession = DatabaseMediator.instance.login(email, password: pass)
        
        return AppHandler.accountSession.getAccountID() != 0
    }
    
    func throwNewPlane(startposition : Position, message : String, degrees : Float, speed : Float) -> Bool{
        
        return false
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
