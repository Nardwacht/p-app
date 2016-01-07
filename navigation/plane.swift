//
//  plane.swift
//  navigation
//
//  Created by Nard Broekstra on 04-12-15.
//  Copyright © 2015 P-App. All rights reserved.
//

import Foundation

class Plane{
    
    var planeID : Int
    var userID : Int
    var message : String
    var userDisplayName : String
    var throwDate : NSDate
    var totalScore : Int
    var amountOfThrows : Int
    var titel :  String
    var active : Bool
    var isFlying :  Bool
    var currentPosition : Position
    var hRotation : Int
    
    init(planeid : Int, userid : Int, message : String, userdisplayname: String, throwdate : NSDate, totalscore : Int, aot  : Int, titel : String, active : Bool, isflying : Bool, rot: Int, currentpos : Position){
        planeID = planeid
        userID = userid
        self.message = message
        userDisplayName = userdisplayname
        throwDate = throwdate
        totalScore = totalscore
        self.titel = titel
        self.active = active
        currentPosition = currentpos
        amountOfThrows = aot
        isFlying = isflying
        hRotation = rot
    }
    
    func addToTotalScore(amount : Int) -> Int {
        totalScore += amount
        return totalScore;
    }
    
    func setCurrentPosition(position: Position){
        currentPosition = position;
    }
    
    func setActive(bool : Bool){
        active = bool;
    }
    
    func increaseThrows() -> Int{
        amountOfThrows++;
        return amountOfThrows;
    }
    
    
}

