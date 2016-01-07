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
import Alamofire
import Darwin

class MKVController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    
    var lm:CLLocationManager!
    var mapView:GMSMapView!
    let locationManager = CLLocationManager()
    var currentLat: Double = 0.0
    var currentLon: Double = 0.0
    var firstLoop: Bool = true
    var path: GMSMutablePath = GMSMutablePath()
    var polyline: GMSPolyline = GMSPolyline()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        
        lm = CLLocationManager()
        lm.delegate = self
        lm.startUpdatingHeading()
        
        
        let camera = GMSCameraPosition.cameraWithLatitude(self.currentLat,
            longitude: self.currentLon, zoom: 7)
        mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.mapType = kGMSTypeNormal
        mapView.delegate = self
        
        
        self.view = mapView
        mapView.myLocationEnabled = true
        
        showAllMarkers()
        
        throwPlane()
        
        
        
    }
    
    
    func throwPlane(){
        
        {
        
        AppHandler.throwNewPlane(Position(long: 2.5, lat: 2.5), titel: "swagtitel", message: "/swag message\\. yolo, komma?vraagteken", degrees: 50) } ~> {
    
        print(AppHandler.response)
    }
    
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) ->
            Void in
            
            if error != nil{
                return
            }
            
            if placemarks!.count > 0{
                
                let pm = placemarks![0]
                self.currentLat = Double((pm.location?.coordinate.latitude)!)
                
                self.currentLon = Double((pm.location?.coordinate.longitude)!)
                
                if self.firstLoop == true{
                    
                    self.updateMapCenter()
                    self.firstLoop = false
                    
                }
                
                
            }
            
        })
        
        
    }
    
    
    func updateMapCenter(){
        
        let location = CLLocationCoordinate2D(latitude: self.currentLat, longitude: self.currentLon)
        mapView.animateToLocation(location)
    }
    
    
    func showAllMarkers(){
        
        let url = "http://noijdevelopment.nl/Papp/API/getAllPlanes.php"
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                
                
                
                for index in 0...json["response"]["list"].count - 1 {
                    
                    let planeID = String(json["response"]["list"][index]["planeID"])
                    let accountID = String(json["response"]["list"][index]["accountID"])
                    let userDisplayName = String(json["response"]["list"][index]["userDisplayName"])
                    let title = String(json["response"]["list"][index]["title"])
                    let content = String(json["response"]["list"][index]["content"])
                    let amountOfThrows = String(json["response"]["list"][index]["amountOfThrows"])
                    let hLat = String(json["response"]["list"][index]["hLat"])
                    let hLong = String(json["response"]["list"][index]["hLong"])
                    let degree = String(json["response"]["list"][index]["hRotation"])
                    let status = String(json["response"]["list"][index]["active"])
                    
                    if status == "1"{
                        
                        let iconRotation: CLLocationDegrees = Double(degree)!
                        
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2DMake(Double(hLat)!, Double(hLong)!)
                        marker.title = title
                        marker.snippet = userDisplayName
                        marker.icon = UIImage(named: "markerIcon")
                        marker.rotation = iconRotation
                        marker.flat = true
                        marker.userData = [planeID, accountID, userDisplayName, title, content, amountOfThrows, hLat, hLong, degree, status]
                        marker.map = self.mapView
                        marker.infoWindowAnchor = CGPointMake(0.5, 0.2)
                        
                        
                    }
                    
                }
                
                
                
            case .Failure(let error):
                print("")
            }
        }
        
        ///
        
        
        
        
    }
    
    
    
    
    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
        // 1
        let title = marker.title
        let user = marker.snippet
        let kilometer = "82 KM away"
        // 2
        let customInfoWindow = NSBundle.mainBundle().loadNibNamed("CustomInfoWindow", owner: self, options: nil)[0] as! CustomInfoWindow
        customInfoWindow.architectLbl.text = title
        customInfoWindow.completedYearLbl.text = user
        
        return customInfoWindow
    }
    
    
    
    
    
    
    @IBAction func terugKnop(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    // MARK: GMSMapViewDelegate
    
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        
        if marker.userData.count > 4{
            
            
        }
        
        return false
    }
    
    
    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {
        print(self.mapView.camera.zoom)
        
        updateDashedLine()
        
    }
    
    
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        self.mapView.clear()
        showAllMarkers()
        
    }
    
    
    func drawLine(zoom: Float){
        
        
        
        let firstVar = 1500000 * (2 ** (-1 * (zoom-1)))
        let secondVar = firstVar * 0.4
        
        print(firstVar)
        print(secondVar)
        
        
        self.polyline = GMSPolyline(path: self.path)
        self.polyline.strokeWidth = 5
        self.polyline.strokeColor = UIColor.blackColor()
        self.polyline.geodesic = true
        
        let styles: [AnyObject] = [GMSStrokeStyle.solidColor(UIColor.blackColor()), GMSStrokeStyle.solidColor(UIColor.clearColor())]
        let lengths: [AnyObject] = [firstVar, secondVar]
        
        self.polyline.spans = GMSStyleSpans(polyline.path, styles, lengths, kGMSLengthRhumb)
        
        self.polyline.map = self.mapView
        
    }
    
    func updateDashedLine(){
        
        let zoom = self.mapView.camera.zoom
        
        let firstVar = 1500000 * (2 ** (-1 * (zoom-1)))
        let secondVar = firstVar * 0.4
        
        let styles: [AnyObject] = [GMSStrokeStyle.solidColor(UIColor.blackColor()), GMSStrokeStyle.solidColor(UIColor.clearColor())]
        let lengths: [AnyObject] = [firstVar, secondVar]
        
        self.polyline.spans = GMSStyleSpans(polyline.path, styles, lengths, kGMSLengthRhumb)
        
    }
    
}

infix operator ** {
associativity left
precedence 160
}

func ** (base: Double, power: Double) -> Double {
    return pow(base, power)
}

func ** (base: Float, power: Float) -> Float {
    return powf(base, power)
}

