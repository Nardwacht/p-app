//
//  DatabaseMediator.swift
//  P-app
//
//  Created by Mick Wonnink on 12/3/15.
//  Copyright © 2015 p'app development. All rights reserved.
//

import Foundation

import Alamofire

class DatabaseMediator{
    
    static var instance = DatabaseMediator();
    var APIurl : String = "http://noijdevelopment.nl/Papp/API/"
    
    init(){
        
    }
    
    /**
    * Function call API "getAllPlanes.php"
    * Paramters:
    */
    
    func getAllPlanes(completionHandler: (JSON?, NSError?) -> ()) {
        _GetAllPlanes(completionHandler)
    }
    
    func _GetAllPlanes(completionHandler: (JSON?, NSError?) -> ()) {
        var json : JSON = JSON("empty")
        
        let url = APIurl + "getAllPlanes.php"
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(JSON(response.result.value!), response.result.error)
        }
    }
    
    /**
    * Function call API "getAllPlanes.php"
    * Paramters: accountID
    */
    
    func getPlanesFromUser(accountID : Int, completionHandler: (JSON?, NSError?) -> ()) {
        _GetPlanesFromUser(accountID, completionHandler: completionHandler)
    }
    
    func _GetPlanesFromUser(accountID : Int, completionHandler: (JSON?, NSError?) -> ()) {
        var json : JSON = JSON("empty")
        
        let url = APIurl + "getAllPlanes.php?accountID=\(accountID)"
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(JSON(response.result.value!), response.result.error)
        }
    }
    
    
    func updateAccount(acccount : AccountSession) -> Bool {
        
        return false
    }
    
    func updatePlane(plane : Plane) -> Bool {
        
        return false
    }
    
    func addPreviousLocation(planeID : Int, prevloc : PreviousLocation) -> Bool {
    
        return false
    }
    
    func registerAccount(newaccount : AccountSession) -> Bool {
        
        return false
    }
    
    func login(username : String, password: String) -> AccountSession{
        var existingSession : AccountSession = AccountSession(displayname: "none", email: "none", password: "none")
        
        return existingSession
    }
    
    func addPlane(plane : Plane) -> Bool{
        
        return false
    }
    
    func getAllNearbyPlanes(position : Position) -> [Plane] {
        var planes = [Plane]()
        
        return planes
    }
    
    func getAllPreviousLocations(planeid : Int) -> [PreviousLocation] {
        var prevlocations = [PreviousLocation]()
        
        return prevlocations
    }

    
}