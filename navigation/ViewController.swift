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