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
    

    
    func getAllPlanes(completionHandler: (JSON?, NSError?) -> ()) {
        
        _GetAllPlanes(completionHandler)
        
    }
    
    func _GetAllPlanes(completionHandler: (JSON?, NSError?) -> ()) {
        //let id = 3
        var json : JSON = JSON("iets")
        
        let url = APIurl + "getAllPlanes.php"
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(JSON(response.result.value!), response.result.error)
        }
    }
    
    func getPlanesFromUser(accountID : Int) -> [Plane]{
        var planes = [Plane]()
    
        return planes
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