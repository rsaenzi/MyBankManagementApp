//
//  View.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class View {
    
    static var alertShownFirstTime: Bool = false

    static var clientsColor =  UIColor(red: 152/255.0, green: 200/255.0, blue: 255/255.0, alpha: 1) // Soft Blue
    static var accountsColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 156/255.0, alpha: 1) // Soft Yellow
    
    static var transactionColorSoftGreen = UIColor(red: 160/255.0, green: 255/255.0, blue: 156/255.0, alpha: 1)
    static var transactionColorSoftRed = UIColor(red: 255/255.0, green: 156/255.0, blue: 156/255.0, alpha: 1)
    
    
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
