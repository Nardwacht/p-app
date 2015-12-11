//
//  ViewController.swift
//  navigation
//
//  Created by Nard Broekstra on 03-12-15.
//  Copyright © 2015 P-App. All rights reserved.
//

import UIKit

import MapKit

import CoreLocation

import CoreMotion

class ViewController: UIViewController {
    
    
    let appHandler : AppHandler = AppHandler()

        
    override func viewDidLoad() {

    }
    
    func printPlanes(){
        print(AppHandler.getAllPlanes().count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

