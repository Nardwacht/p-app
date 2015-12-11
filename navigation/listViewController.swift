//
//  listViewController.swift
//  navigation
//
//  Created by Nard Broekstra on 04-12-15.
//  Copyright © 2015 P-App. All rights reserved.
//

import UIKit

class listViewController: UIViewController {

    @IBAction func backButton(sender: AnyObject) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func LoadPlanes(){
        { AppHandler.loadAllMyPlanes() } ~> {
            var cc : Int = AppHandler.getAllPlanes().count - 1
            for index in 0...cc {
                print("VLIEGTUIG \(index + 1): naam \(AppHandler.getAllPlanes()[index].userDisplayName), titel \(AppHandler.getAllPlanes()[index].titel)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadPlanes()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
