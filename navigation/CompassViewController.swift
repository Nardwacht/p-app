//
//  ViewController.swift
//  papp
//
//  Created by Marco Lemmens on 26-11-15.
//  Copyright © 2015 Fontys. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Foundation

class CompassViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var compassImage: UIImageView!
    @IBOutlet weak var planeImage: UIImageView!
    @IBOutlet weak var lockImage: UIImageView!
    
    // force images
    
    @IBOutlet weak var force1: UIImageView!
    @IBOutlet weak var force2: UIImageView!
    @IBOutlet weak var force3: UIImageView!
    @IBOutlet weak var force4: UIImageView!
    @IBOutlet weak var force5: UIImageView!
    @IBOutlet weak var force6: UIImageView!
    @IBOutlet weak var force7: UIImageView!
    
    
    //
    
    var lm:CLLocationManager!
    let locationManager = CLLocationManager()
    var currentLat: Double = 0.0
    var currentLon: Double = 0.0
    var previousDegrees: Double = 0.0
    var locked: Bool = false
    var forceTimer: NSTimer!
    var currentForce: Int = 0
    var forceUp: Bool = true
    var planeLocation: CGPoint = CGPoint(x: 0, y: 0)
    var initY: CGFloat = 0
    var startTime: CFAbsoluteTime = 0
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if locked == true {
            
            forceTimer.invalidate()
            
            startTime = CFAbsoluteTimeGetCurrent()
            
            let touch = touches.first
            
            planeLocation = (touch?.locationInView(self.view))!
            
            planeImage.center.y = planeLocation.y
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if locked == true {
            
            let touch = touches.first
            
            planeLocation = (touch?.locationInView(self.view))!
            
            planeImage.center.y = planeLocation.y
            
        }
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if locked == true {
            
            let speed = (CFAbsoluteTimeGetCurrent() - startTime) * 2.5
            
            print(speed)
            
            if speed < 0.5 {
                
                UIView.animateWithDuration(speed, delay: 0, options: .CurveLinear, animations: {
                    
                    self.planeImage.center.y = -120
                    
                    }, completion: { finished in
                        
                        
                        
                        print("klaar is kees")
                        let refreshAlert = UIAlertController(title: "Verstuurd!", message: "Je vliegtuigje is verstuurd", preferredStyle: UIAlertControllerStyle.ActionSheet)
                        
                        refreshAlert.addAction(UIAlertAction(title: "Doorgaan", style: .Default, handler: { (action: UIAlertAction!) in
                            
                            
                            self.unlocked()
                            
                            
                        }))
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewControllerWithIdentifier("startScherm") as! UIViewController
                        self.presentViewController(vc, animated: true, completion: nil)

                        
                        
                })
                
                print("Voert einde uit")
                
            }
                
            else {
                
                unlocked()
                
            }
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(planeImage.center.y)
        
        initY = planeImage.center.y
        
        force1.alpha = 0
        force2.alpha = 0
        force3.alpha = 0
        force4.alpha = 0
        force5.alpha = 0
        force6.alpha = 0
        force7.alpha = 0
        
        
        planeImage.userInteractionEnabled = true
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "singleTapping:")
        singleTap.numberOfTapsRequired = 1
        planeImage.addGestureRecognizer(singleTap)
        
        
        
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        lm = CLLocationManager()
        lm.delegate = self
        lm.startUpdatingHeading()
        
        
        let camera = GMSCameraPosition.cameraWithLatitude(self.currentLat,
            longitude: self.currentLon, zoom: 7, bearing: 30, viewingAngle: 0)
        
        mapView.camera = camera
        mapView.mapType = kGMSTypeNormal
        mapView.myLocationEnabled = true
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) ->
            Void in
            
            if error != nil{
                print("Error: " + (error!.localizedDescription))
                return
            }
            
            if placemarks!.count > 0{
                
                let pm = placemarks![0]
                self.currentLat = Double((pm.location?.coordinate.latitude)!)
                
                self.currentLon = Double((pm.location?.coordinate.longitude)!)
                
                self.updateMapCenter()
                
            }
            
        })
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        if self.locked == false{
            
            let degrees = newHeading.magneticHeading
            
            let newDegrees = CGFloat(degrees) / 180.0 * CGFloat(M_PI)
            
            self.mapView.animateToBearing(degrees)
            
            UIView.animateWithDuration(0.3, delay: 0.1, options: .CurveEaseOut, animations: {
                
                self.compassImage.transform = CGAffineTransformMakeRotation(CGFloat(newDegrees * -1))
                
                
                }, completion: { finished in
            })
            
            
        }
        
    }
    
    
    func updateMapCenter(){
        
        let location = CLLocationCoordinate2D(latitude: self.currentLat, longitude: self.currentLon)
        mapView.animateToLocation(location)
    }
    
    func singleTapping(recognizer: UIGestureRecognizer) {
        if self.locked == false{
            self.locked = true
            self.lockImage.image = UIImage(named: "locked.png")
            self.mapView.userInteractionEnabled = false
            self.mapView.myLocationEnabled = false
            
            self.forceTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("animateForce"), userInfo: nil, repeats: true)
            
        }
            
        else{
            
            unlocked()
            
            
        }
    }
    
    
    func unlocked(){
        
        self.locked = false
        self.lockImage.image = UIImage(named: "unlocked.png")
        self.lm.startUpdatingHeading()
        self.forceTimer.invalidate()
        self.currentForce = 0
        self.forceUp = true
        appendForceImages(0)
        self.mapView.userInteractionEnabled = true
        self.mapView.myLocationEnabled = true
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: {
            
            self.planeImage.center.y = self.initY + 140
            
            }, completion: { finished in
        })
        
    }
    
    func animateForce(){
        
        if self.currentForce == 1{
            
            self.forceUp = true
        }
        
        if self.currentForce == 7 {
            
            self.forceUp = false
            
        }
        
        if self.forceUp == true{
            
            self.currentForce++
            
        }
        else{
            self.currentForce--
        }
        
        
        appendForceImages(self.currentForce)
        
    }
    
    
    func appendForceImages(forceAmount: Int){
        
        
        switch forceAmount
        {
        case 1:
            self.force1.alpha = 1
            self.force2.alpha = 0
            self.force3.alpha = 0
            self.force4.alpha = 0
            self.force5.alpha = 0
            self.force6.alpha = 0
            self.force7.alpha = 0
        case 2:
            self.force1.alpha = 1
            self.force2.alpha = 1
            self.force3.alpha = 0
            self.force4.alpha = 0
            self.force5.alpha = 0
            self.force6.alpha = 0
            self.force7.alpha = 0
        case 3:
            self.force1.alpha = 1
            self.force2.alpha = 1
            self.force3.alpha = 1
            self.force4.alpha = 0
            self.force5.alpha = 0
            self.force6.alpha = 0
            self.force7.alpha = 0
        case 4:
            self.force1.alpha = 1
            self.force2.alpha = 1
            self.force3.alpha = 1
            self.force4.alpha = 1
            self.force5.alpha = 0
            self.force6.alpha = 0
            self.force7.alpha = 0
        case 5:
            self.force1.alpha = 1
            self.force2.alpha = 1
            self.force3.alpha = 1
            self.force4.alpha = 1
            self.force5.alpha = 1
            self.force6.alpha = 0
            self.force7.alpha = 0
        case 6:
            self.force1.alpha = 1
            self.force2.alpha = 1
            self.force3.alpha = 1
            self.force4.alpha = 1
            self.force5.alpha = 1
            self.force6.alpha = 1
            self.force7.alpha = 0
        case 7:
            self.force1.alpha = 1
            self.force2.alpha = 1
            self.force3.alpha = 1
            self.force4.alpha = 1
            self.force5.alpha = 1
            self.force6.alpha = 1
            self.force7.alpha = 1
        default:
            self.force1.alpha = 0
            self.force2.alpha = 0
            self.force3.alpha = 0
            self.force4.alpha = 0
            self.force5.alpha = 0
            self.force6.alpha = 0
            self.force7.alpha = 0
            
        }
        
    }
    
}

