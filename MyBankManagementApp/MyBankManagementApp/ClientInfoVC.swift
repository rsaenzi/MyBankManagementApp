//
//  ClientInfoVC.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class ClientInfoVC: UIViewController {
    
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var textfieldAddress: UITextField!
    @IBOutlet weak var textfieldPhone: UITextField!
    
    @IBAction func onClickSave(sender: UIBarButtonItem) {
        
        // Input validation
        if textfieldName.text == "" {
            View.showAlert(self, messageToShow: "Name can not be empty")
            return
        }
        if textfieldAddress.text == "" {
            View.showAlert(self, messageToShow: "Address can not be empty")
            return
        }
        if textfieldPhone.text == "" {
            View.showAlert(self, messageToShow: "Phone can not be empty")
            return
        }
        if let number = Int(textfieldPhone.text!) {

            if number <= 0 {
                View.showAlert(self, messageToShow: "Phone can not be negative or zero")
                return
            }
        }else {
            View.showAlert(self, messageToShow: "Phone can not have letters and spaces")
            return
        }
        
        // Client creation
        let newClient = Client(newName: textfieldName.text!, newAddress: textfieldAddress.text!, newPhone: textfieldPhone.text!)
        Bank.instance.createClient(newClient)
        
        // Pop current screen
        self.navigationController?.popViewControllerAnimated(true)
    }

}