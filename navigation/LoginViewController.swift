//
//  LoginViewController.swift
//  navigation
//
//  Created by Mick Wonnink on 12/11/15.
//  Copyright © 2015 P-App. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBAction func ClickLoginBtn(sender: AnyObject) {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ComposeMessageScreen") as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
