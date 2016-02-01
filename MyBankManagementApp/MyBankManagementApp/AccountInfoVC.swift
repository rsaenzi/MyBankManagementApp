//
//  AccountInfoVC.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class AccountInfoVC: UIViewController {
    
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var textfieldNumber: UITextField!
    
    
    @IBAction func onClickSave(sender: UIBarButtonItem) {
        
        // Input validation
        if textfieldName.text == "" {
            View.showAlert(self, messageToShow: "Name can not be empty")
            return
        }
        if textfieldNumber.text == "" {
            View.showAlert(self, messageToShow: "Number can not be empty")
            return
        }
        if let number = Int(textfieldNumber.text!) {

            if number <= 0 {
                View.showAlert(self, messageToShow: "Number can not be negative or zero")
                return
            }
        }else {
            View.showAlert(self, messageToShow: "Number can not have letters and spaces")
            return
        }
        
        // Account creation
        let newAccount = Account(newName: textfieldName.text!, newNumber: textfieldNumber.text!)
        Bank.instance.createAccount(newAccount)
        
        // Pop current screen
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}