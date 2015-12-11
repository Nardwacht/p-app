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
        var planes = [Plane]()
        
        //let id = 3
        var json : JSON = JSON("iets")
        
        let url = APIurl + "getAllPlanes.php"
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(response.result.value as? JSON, response.result.error as? NSError)
        }
    }
    
/*
    witch response.result {
    case .Success(let data):
    json = JSON(data)
    
    for index in 0...data["response"]["list"].count - 1 {
    
    let planeID : Int? = Int(String(data["response"]["list"][index]["planeID"]))
    let accountID : Int? = Int(String(data["response"]["list"][index]["accountID"]))
    let userDisplayName : String = String(data["response"]["list"][index]["userDisplayName"])
    let title : String = String(data["response"]["list"][index]["title"])
    let content : String = String(data["response"]["list"][index]["content"])
    let amountOfThrows : Int? = Int(String(data["response"]["list"][index]["amountOfThrows"]))
    let scoreTotal : Int? = Int(String(data["response"]["list"][index]["scoreTotal"]))
    let throwDate : String = String(data["response"]["list"][index]["throwDate"])
    let hLat : Float? = Float(String(data["response"]["list"][index]["hLat"]))
    let hLong : Float? = Float(String(data["response"]["list"][index]["hLong"]))
    let hRotation : Int? = Int(String(data["response"]["list"][index]["hRotation"]))
    let active : Int? = Int(String(data["response"]["list"][index]["active"]))
    let isflying : Int? = Int(String(data["response"]["list"][index]["inAir"]))
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let nsthrowDate : NSDate? = dateFormatter.dateFromString( throwDate )
    
    let boolactive : Bool = active == 1
    let boolisflying : Bool = isflying == 1
                    let position : Position = Position(long: hLat!, lat: hLong!)
                    
                    
                    planes.append(Plane(planeid: planeID!, userid: accountID!, message: content, userdisplayname: userDisplayName, throwdate: nsthrowDate!, totalscore: scoreTotal!, aot: amountOfThrows!, titel: title, active: boolactive, isflying: boolisflying, rot: hRotation!, currentpos: position))
                    
                    
                }
                
                
            case .Failure(let error):
                print(error)
            }

*/

    
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