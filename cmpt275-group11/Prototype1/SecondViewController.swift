//
//  ContactTableViewController.swift
//  Prototype2
//  Team Hjack
//  Worked on by: Kelvin Law, Adam Gabriel, Hesam Fatahi, Jessica Poon, Chun-wei Chen
//  Created by Kelvin Law on 2015-11-05.
//  Copyright © 2015 Kelvin Law. All rights reserved.
//

import UIKit
import CoreTelephony
import Contacts
import ContactsUI
import AVFoundation

class SecondViewController: UITableViewController {
    var callCenter = CTCallCenter()
    var contacts = [CNContact]()
    
    @IBAction func FallSafeButton(sender: AnyObject) {
        let contactsCurrent = ["7788771068", "7788771068", "7788771068"]
        //overide func viewDidLoad() {
        //  super.viewDidLoad()
        callCenter.callEventHandler = { (call:CTCall!) in
            for var i = 1; i < 3; i++ { //i <= self.contacts.count;
                if (call.callState == CTCallStateDisconnected) {
                    let url:NSURL = NSURL(string: "tel:\(contactsCurrent[i])")! //contacts[i].phoneNumbers
                    UIApplication.sharedApplication().openURL(url)
                }
            }
        }
    }
    
    @IBAction func FlashlightButton(sender: UISwitch) {
        
        let flashlight = SOSFlashlight()
        //in this case I get the state from Switch
        if sender.on{
            flashlight.turnFlashlight(on: true)
        } else {
            flashlight.turnFlashlight(on: false)
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class SOSFlashlight {
    // SOS sequence = Short Short Short Long Long Long Short Short Short
    private static let shortInterval = 0.4 // Short signal duration
    private static let longInterval = 0.8 // Long signal duration
    private static let pauseInterval = 0.2 // Pause between the whole SOS sequences
    private static let sequencePauseInterval = 4.0
    private let sequenceInterval = [shortInterval, pauseInterval, shortInterval, pauseInterval, shortInterval, pauseInterval, longInterval, pauseInterval, longInterval, pauseInterval, longInterval, pauseInterval, shortInterval, pauseInterval, shortInterval, pauseInterval, shortInterval, pauseInterval, sequencePauseInterval]
    private var index : Int = 0 //current index in the SOS sequence
    private var timer : NSTimer? // Non repeatable timer
    private func turnFlashlight (on on : Bool) {
        if on == true {
            if let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo) {
                if device.hasFlash {
                    do {
                        try device.lockForConfiguration()
                        device.flashMode = AVCaptureFlashMode.On
                        device.unlockForConfiguration()
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
        else {
            if let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo) {
                if device.hasFlash {
                    do {
                        try device.lockForConfiguration()
                        device.flashMode = AVCaptureFlashMode.Off
                        device.unlockForConfiguration()
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    }
    private func scheduleTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(sequenceInterval[index], target: self, selector: "timerTick", userInfo: nil, repeats: false)
    }
    @objc private func timerTick() {
        if ++index == sequenceInterval.count {
            index = 0
        }
        scheduleTimer()
    }
    func start() {
        index = 0
        turnFlashlight(on: true)
        scheduleTimer()
    }
    func stop() {
        timer?.invalidate()
        turnFlashlight(on: false)
    }
    deinit {
        timer?.invalidate()
    }
}