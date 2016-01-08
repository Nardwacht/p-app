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

import QuartzCore

import Darwin

class ViewController: UIViewController {
        
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var messageBox: UITextView!
    @IBOutlet weak var leftCloud: UIImageView!
    @IBOutlet weak var rightCloud: UIImageView!
    @IBOutlet weak var redArrow: UIImageView!
    @IBOutlet var messageField: UITextView!
    @IBOutlet var titleField: UITextField!
    var up: Bool = false
    
    override func viewDidLoad() {
        
        
        get_gps_distance(51.316699, long1: 5.619299, d: 1, angle: 90)
        

        titleField.addTarget(self, action: "textFieldDidReturn:", forControlEvents: .EditingDidEndOnExit)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)

        
        self.rightCloud.center.x = 0
        self.leftCloud.center.x = 500
        
        UIView.animateWithDuration(180, delay: 0.1, options: .CurveLinear, animations: {
            
            self.rightCloud.center.x = 500
            
            }, completion: { finished in
        })
        
        UIView.animateWithDuration(50, delay: 0.1, options: .CurveLinear, animations: {
            
            self.leftCloud.center.x = 0
            
            }, completion: { finished in
        })
        

        leftButton.setTitle("2", forState: .Normal)
        rightButton.setTitle("4", forState: .Normal)
        
        leftButton.layer.cornerRadius = 5
        rightButton.layer.cornerRadius = 5
        messageBox.layer.cornerRadius = 5
        
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor(netHex:0xd6f1f1).CGColor, UIColor(netHex:0x8ad5d6).CGColor]

        
        self.view.layer.insertSublayer(gradient, atIndex: 0)
        
        
    }
    
    
    
    func get_gps_distance(lat1: Double,long1: Double,d: Double,angle: Double)
    {
        
        let R = 6378.14
        
        //# Degree to Radian
        let latitude1 = lat1 * (M_PI/180)
        let longitude1 = long1 * (M_PI/180)
        let brng = angle * (M_PI/180)
        
        var latitude2 = asin(sin(latitude1)*cos(d/R) + cos(latitude1)*sin(d/R)*cos(brng))
        var longitude2 = longitude1 + atan2(sin(brng)*sin(d/R)*cos(latitude1),cos(d/R)-sin(latitude1)*sin(latitude2))
        
        //# back to degrees
        latitude2 = latitude2 * (180/M_PI)
        longitude2 = longitude2 * (180/M_PI)
        
        //# 6 decimal for Leaflet and other system compatibility
        let lat2 = Double(round(1000000*latitude2)/1000000)
        let long2 = Double(round(1000000*longitude2)/1000000)
        
        //print(lat2)
        //print(long2)

    }
    
    
    
    
    
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    
    func textFieldDidReturn(textField: UITextField!) {
        textField.resignFirstResponder()
        switchToCompass()
        
        
    }
    
    
    func switchToCompass() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("compassView") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }

    
    

    
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            
            if self.up == false{
                
            self.view.frame.origin.y -= keyboardSize.height
            
            self.up = true
            }

        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
            self.up = false
        }
    }

}



extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}