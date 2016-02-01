//
//  View.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class View {
    
    class func showAlert(currentViewController: UIViewController, messageToShow: String){
        
        // Create an alert
        let alert: UIAlertController = UIAlertController(title: "MyBankManagementApp", message: messageToShow, preferredStyle: UIAlertControllerStyle.Alert)
        
        // Create OK button
        let alertActionOK: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        
        // Add OK button to alert
        alert.addAction(alertActionOK)
        
        // Show alert
        currentViewController.presentViewController(alert, animated: true, completion: nil)
    }
}
