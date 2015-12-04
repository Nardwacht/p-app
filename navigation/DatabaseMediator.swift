//
//  DatabaseMediator.swift
//  P-app
//
//  Created by Mick Wonnink on 12/3/15.
//  Copyright © 2015 p'app development. All rights reserved.
//

import Foundation

class DatabaseMediator{
    
    static var instance = DatabaseMediator();
    var APIurl : String = ""
    
    init(){
        
    }
    
    static func loadJsonData(url_:String)
    {
        let url = NSURL(string: url_)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            do // TRY for each json object to parse it into a 'command'
            {
                if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, 	   options: NSJSONReadingOptions.AllowFragments)
                {
                    self.parseJsonData(jsonObject)
                    print(jsonObject)
                }
            }
            catch
            {
                print("Error parsing JSON data")
            }
        }
        dataTask.resume();
    }
    
    static func parseJsonData(jsonObject:AnyObject)
    {
        if let jsonData = jsonObject as? NSArray
        {
            for item in jsonData
            {
                //recognize commands with the key 'commandname'
                print(item)
            }
            print(jsonData.count)
        }
        print("alsohere")
    }
    
    func getAllPlanes() -> [Plane]{
        var planes = [Plane]()
        
        return planes
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