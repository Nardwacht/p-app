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
    
    
    init(){
        
    }
    
    func register(name : String, email : String, pass : String) -> Bool{
        
        let session : AccountSession = AccountSession(accountid: 0, displayname: name, email: email, password: pass, experience: 0, level: 1)
    
        return DatabaseMediator.instance.registerAccount(session)
    }
    
    func login(email : String, pass : String) -> Bool{
        AppHandler.accountSession = DatabaseMediator.instance.login(email, password: pass)
        
        return AppHandler.accountSession.getAccountID() != 0
    }
    
    func throwNewPlane(startposition : Position, message : String, degrees : Float, speed : Float) -> Bool{
        
        return false
    }
    
    func getAllMyPlanes() -> [Plane] {
        var allmyPlanes = [Plane]()
        
        return allmyPlanes
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
