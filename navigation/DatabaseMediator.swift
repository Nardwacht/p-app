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
    * Function call API "getAllPlanes.php" + user ID
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
    
    /**
    * Function call API "addPaperPlane.php + accID, scoreTotal, title, content, userDisplayName, amountOfThrows, hLat, hLong, hRotation, inAir, active
    * Paramters: accountID
    */
    
    func addPaperPlane(accountID : Int, scoreTotal : Int, title : String, content : String, userDisplayName : String, amountOfThrows : Int, hlat : Float, hlong : Float, hrot : Int, inair : Int, active : Int, completionHandler: (JSON?, NSError?) -> ()) {
        _AddPaperPlane(accountID, scoreTotal: scoreTotal, title: title, content: content, userDisplayName: userDisplayName, amountOfThrows: amountOfThrows, hlat: hlat, hlong: hlong, hrot: hrot, inair: inair, active: active, completionHandler: completionHandler)
    }
    
    func _AddPaperPlane(accountID : Int, scoreTotal : Int, title : String, content : String, userDisplayName : String, amountOfThrows : Int, hlat : Float, hlong : Float, hrot : Int, inair : Int, active : Int, completionHandler: (JSON?, NSError?) -> ()) {
        
        var json : JSON = JSON("empty")
        var escapemsg : String = content
        escapemsg = escapemsg.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url = APIurl + "addPaperPlane.php?accountID=\(accountID)&scoreTotal=\(scoreTotal)&title=\(title)&content=\(escapemsg)&userDisplayName=\(userDisplayName)&amountOfThrows=\(amountOfThrows)&hLat=\(hlat)&hLong=\(hlong)&hRotation=\(hrot)&inAir=\(inair)&active=\(active)"
        print(url) 
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(JSON(response.result.value!), response.result.error)
        }
    }
    
    /**
    * Function call API "updateAccount.php"
    * Paramters: account
    */
    
    
    func updateAccount(account : AccountSession, completionHandler: (JSON?, NSError?) -> ()) {
        _UpdateAccount(account, completionHandler: completionHandler)
    }
    
    func _UpdateAccount(account : AccountSession, completionHandler: (JSON?, NSError?) -> ()) {
        var json : JSON = JSON("empty")
        
        let url = APIurl + "updateAccount.php?id=\(account.getAccountID())&naam=\(account.getDisplayName())&email=\(account.getEmail())&experience=\(account.getExperience())&level=\(account.getLevel())"
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(JSON(response.result.value!), response.result.error)
        }
    }
    
    
    /**
    * Function call API "updatePlane.php"
    * Paramters: plane
    */
    
    func updatePlane(plane: Plane, completionHandler: (JSON?, NSError?) -> ()) {
        _UpdatePlane(plane, completionHandler: completionHandler)
    }
    
    func _UpdatePlane(plane : Plane, completionHandler: (JSON?, NSError?) -> ()) {
        var json : JSON = JSON("empty")
        
        var isfly : Int = 0
        var isactive : Int = 0
        if (plane.isFlying){
            isfly = 1
        }
        if (plane.active){
            isactive = 1
        }
        
        let url = APIurl + "updatePlane.php?id=\(plane.planeID)&userid=\(plane.userID)&titel=\(plane.titel)&message=\(plane.message)&amountofthrows=\(plane.amountOfThrows)&rotation=\(plane.hRotation)&hlong=\(plane.currentPosition.getLong())&hlat=\(plane.currentPosition.getLat())&isflying=\(isfly)&isactive=\(isactive)"
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(JSON(response.result.value!), response.result.error)
        }
    }
    
    /**
    * Function call API "addPreviousLocation.php"
    * Paramters: planeID, previous location
    */
    
    func addPreviousLocation(planeID: Int, prevloc : PreviousLocation, completionHandler: (JSON?, NSError?) -> ()) {
        _AddPreviousLocation(planeID, prevloc: prevloc, completionHandler: completionHandler)
    }
    
    func _AddPreviousLocation(planeID: Int, prevloc : PreviousLocation, completionHandler: (JSON?, NSError?) -> ()) {
        var json : JSON = JSON("empty")
        
        let url = APIurl + "addPreviousLocation?id=\(planeID)&long=\(prevloc.getPosition().getLong())&lat=\(prevloc.getPosition().getLat())&rotation=\(prevloc.getRotation())&date=\(prevloc.getDate())"
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(JSON(response.result.value!), response.result.error)
        }
    }
    
    /**
    * Function call API "registerAccount.php"
    * Paramters: new account (AccountSession)
    */
    
    func registerAccount(newaccount : AccountSession, completionHandler: (JSON?, NSError?) -> ()) {
        _RegisterAccount(newaccount, completionHandler: completionHandler)
    }
    
    func _RegisterAccount(newaccount : AccountSession, completionHandler: (JSON?, NSError?) -> ()) {
        var json : JSON = JSON("empty")
        
        let url = APIurl + "registerAccount?name=\(newaccount.getDisplayName())&email=\(newaccount.getEmail())&password=\(newaccount.getPassword())"
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(JSON(response.result.value!), response.result.error)
        }
    }
    
    /**
    * Function call API "loginAccount.php"
    * Paramters: username, password
    */
    
    func loginAccount(username :  String, password : String, completionHandler: (JSON?, NSError?) -> ()) {
        _LoginAccount(username, password: password, completionHandler: completionHandler)
    }
    
    func _LoginAccount(username : String, password : String, completionHandler: (JSON?, NSError?) -> ()) {
        var json : JSON = JSON("empty")
        
        let url = APIurl + "loginAccount?username=\(username)&password=\(password)"
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(JSON(response.result.value!), response.result.error)
        }
    }
    
    /**
    * Function call API "addPlane.php"
    * Paramters: plane
    */
    
    func addPlane(plane: Plane, completionHandler: (JSON?, NSError?) -> ()) {
        _AddPlane(plane, completionHandler: completionHandler)
    }
    
    func _AddPlane(plane : Plane, completionHandler: (JSON?, NSError?) -> ()) {
        var json : JSON = JSON("empty")
        
        var isfly : Int = 0
        var isactive : Int = 0
        if (plane.isFlying){
            isfly = 1
        }
        if (plane.active){
            isactive = 1
        }
        
        let url = APIurl + "updatePlane.php?userid=\(plane.userID)&username=\(plane.userDisplayName)&titel=\(plane.titel)&message=\(plane.message)&amountofthrows=\(plane.amountOfThrows)&rotation=\(plane.hRotation)&hlong=\(plane.currentPosition.getLong())&hlat=\(plane.currentPosition.getLat())&isflying=\(isfly)&isactive=\(isactive)"
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(JSON(response.result.value!), response.result.error)
        }
    }
    
    /**
    * Function call API "getAllPlanes.php" + location
    * Paramters: position
    */
    
    func getAllNearbyPlanes(position: Position, completionHandler: (JSON?, NSError?) -> ()) {
        _GetAllNearbyPlanes(position, completionHandler: completionHandler)
    }
    
    func _GetAllNearbyPlanes(position  : Position, completionHandler: (JSON?, NSError?) -> ()) {
        var json : JSON = JSON("empty")
        
        let url = APIurl + "getAllPlanes.php?long=\(position.getLong())&lat=\(position.getLat())"
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(JSON(response.result.value!), response.result.error)
        }
    }
    
    /**
    * Function call API "getAllPrevLocations.php" + planeid
    * Paramters: planeID
    */
    
    func GetAllPreviousLocations(planeID : Int, completionHandler: (JSON?, NSError?) -> ()) {
        _GetAllPreviousLocations(planeID, completionHandler: completionHandler)
    }
    
    func _GetAllPreviousLocations(planeID : Int, completionHandler: (JSON?, NSError?) -> ()) {
        var json : JSON = JSON("empty")
        
        let url = APIurl + "getAllPrevLocations.php?planeid=\(planeID)"
        Alamofire.request(.GET, url).responseJSON { response in
            completionHandler(JSON(response.result.value!), response.result.error)
        }
    }
    


    
}