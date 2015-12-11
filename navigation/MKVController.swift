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
    
 
    @IBOutlet weak var MapOutlet: MKMapView!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        
        
        
        let id = 3
        
        
        
        let url = "http://noijdevelopment.nl/Papp/API/getPreviousLocation.php"
        Alamofire.request(.GET, url, parameters: ["planeID": id]).responseJSON { response in
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                
                
                
                for index in 0...json["response"]["list"].count - 2 {
                    
                    let planeID = String(json["response"]["list"][index]["planeID"])
                    let hLat = String(json["response"]["list"][index]["locationLat"])
                    let hLong = String(json["response"]["list"][index]["locationLong"])
                    let degree = String(json["response"]["list"][index]["rotation"])
                    
                    
                }
                
                
                
            case .Failure(let error):
                print(error)
            }
        }

        
        
        
        
        
        
        
        
        
        
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func terugKnop(sender: AnyObject) {
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
