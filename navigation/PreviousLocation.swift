//
//  PreviousLocation.swift
//  P-app
//
//  Created by Mick Wonnink on 12/3/15.
//  Copyright © 2015 p'app development. All rights reserved.
//

import Foundation

class PreviousLocation{
    
    var locID :  Int
    var planeID : Int
    var date :  NSDate
    var rotation : Int
    var position : Position
    
    init(locid : Int, planeid : Int, date : NSDate, pos : Position, rotation : Int){
        locID = locid
        planeID = planeid
        self.date = date
        self.rotation = rotation
        self.position = pos
        
    }
    
    func getLocID() -> Int{
        return locID
    }
    
    func getPlaneID() -> Int{
        return planeID
    }
    
    func getDate() -> NSDate {
        return self.date
    }
    
    func getRotation() -> Int{
        return self.rotation
    }
    
    func getPosition() -> Position{
        return self.position
    }
    
}