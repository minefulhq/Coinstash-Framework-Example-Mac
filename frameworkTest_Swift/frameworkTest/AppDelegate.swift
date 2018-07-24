//
//  AppDelegate.swift
//  frameworkTest
//
//  Created by Beach Digital Limited on 1/26/18.
//  Copyright © 2018 Beach Digital Limited. All rights reserved.
//

import Cocoa
import Coinstash_XMRSTAK

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, CoinstashDelegate {
    func onStartUsingPickaxe() {
    }
    
    func userDidRegister() {
    }
    
    func userDidLogin() {
    }
    
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var informationLabel: NSTextField!
    @IBOutlet weak var currentStatusLabel: NSTextField!
    
    var timer : Timer? = nil
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        Coinstash.stopMining()
        timer?.invalidate()
        
    }
    
    @IBAction func onStart(_ sender: Any) {
        /*-----------------Set CPU Limit-------------------*/
        Coinstash.setCPULimit(100)
        /*-----------------Start Mining-------------------*/
        //  Coinstash.configure("configure")
        //  Coinstash.showIntroView()
        Coinstash.setApplicationInfo(uid: uid,
                                     secret: secret)
        Coinstash.startMining(port: 3333,
                              password: "x",
                              coreCount: 4,
                              slowMemory: "warn",
                              currency: "monero7",
                              authorization: authCode,
                              gpu: "detect"
        )
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.showInformation(_:)), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func onStop(_ sender: Any) {
        Coinstash.stopMining()
        timer?.invalidate()
        
        currentStatusLabel.stringValue = Coinstash.currentMinerStatus() ? "Running" : "Idle"
    }
    
    @objc func showInformation(_ timer : Timer) {
        informationLabel.stringValue = "Hash Rate : \(Coinstash.getHashRate()) hash/s"
            +  "\nAccepted : \(Coinstash.getAccepted())"
            +  "\nTotals : \(Coinstash.getTotal())"
            +  "\nCPU Status: \(Coinstash.currentCPU())%"
    }
}
