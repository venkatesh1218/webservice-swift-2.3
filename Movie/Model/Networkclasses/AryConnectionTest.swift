//
//  AryConnectionTest.swift
//  EventFlipApp
//
//  Created by Apple on 03/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit

class AryConnectionTest: NSObject {
    
    
    // MARK: Check Internet Connections
    
    func TestmyInternet() -> Bool {
       
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            
            return true

        } else {
            print("Internet connection FAILED")
//            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
//            alert.show()
            
            return false

            
        }

        
    }
    
}


