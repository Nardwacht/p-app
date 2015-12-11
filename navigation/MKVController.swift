//
//  MKVController.swift
//  navigation
//
//  Created by Nard Broekstra on 03-12-15.
//  Copyright © 2015 P-App. All rights reserved.
//

import UIKit

import MapKit

import CoreLocation

import CoreMotion

import Alamofire

class MKVController: UIViewController {
        let apphandler : AppHandler = AppHandler()
    var allPlanes = [Plane]()
 
    @IBOutlet weak var MapOutlet: MKMapView!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func terugKnop(sender: AnyObject) {
        { AppHandler.loadAllMyPlanes() } ~> {
            var cc : Int = AppHandler.getAllPlanes().count - 1
            for index in 0...cc {
                print("VLIEGTUIG \(index + 1): naam \(AppHandler.getAllPlanes()[index].userDisplayName), titel \(AppHandler.getAllPlanes()[index].titel)")
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
