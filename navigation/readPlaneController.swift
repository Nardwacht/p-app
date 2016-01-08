//
//  readPlaneController.swift
//  pa
//
//  Created by Marco Lemmens on 08-01-16.
//  Copyright © 2016 P-App. All rights reserved.
//

import UIKit

class readPlaneController: UIViewController {
    
    var planeTitle: String = ""
    var message: String = ""
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var messageField: UITextView!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var dropButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = self.planeTitle
        self.messageField.text = self.message
        
        
        self.containerView.layer.cornerRadius = 8
        self.containerView.clipsToBounds = true
        
        self.dropButton.layer.cornerRadius = 8
        self.dropButton.clipsToBounds = true
        
        self.continueButton.layer.cornerRadius = 8
        self.continueButton.clipsToBounds = true


        
    
        
    }
    
    
    @IBAction func dropAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
