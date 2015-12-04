//
//  position.swift
//  navigation
//
//  Created by Nard Broekstra on 04-12-15.
//  Copyright © 2015 P-App. All rights reserved.
//

import Foundation

class Position{
    
    var longitude : Float
    var latitude : Float
    
    init(long : Float, lat : Float){
        longitude = long;
        latitude = lat;
    }
    
    func getLong() -> Float {
        return longitude;
    }
    
    func getLat() -> Float{
        return latitude;
    }
    
}