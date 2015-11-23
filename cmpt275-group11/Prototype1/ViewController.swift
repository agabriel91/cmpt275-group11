//
//  ViewController.swift
//  Health-Care
//
//  Created by Hesam on 11/4/15.
//  Copyright © 2015 Hesam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        var notification:UILocalNotification=UILocalNotification()
        notification.category="First_Category"
        notification.alertBody = "Yo Oldman ! Do you need help?"
        notification.fireDate=NSDate(timeIntervalSinceNow: 15)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    
    }
    
    
   
    @IBAction func myNotify(sender: AnyObject) {
        var refreshAlert = UIAlertController(title: "Health-Care", message: "Did You Droped Oldman ?!", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yup! Call 911", style: .Default, handler: nil))
        
        refreshAlert.addAction(UIAlertAction(title: "No Goto Hell", style: .Default, handler: nil))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

