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
    
    private var editionMode: ScreensInfoEditionMode = .Creation
    
    override func viewWillAppear(animated: Bool) {
        
        if editionMode == .Creation {
            self.navigationItem.title = "Add Account"
            
        } else if editionMode == .Edition {
            self.navigationItem.title = "Edit Account"
            
            // Fill screen with client info
            textfieldName.text = Bank.instance.getSelectedAccount().name
            textfieldNumber.text = Bank.instance.getSelectedAccount().number
        }
    }
    
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
        
        // Account processing
        if editionMode == .Creation {
            
            // Account creation
            let newAccount = Account(newName: textfieldName.text!, newNumber: textfieldNumber.text!)
            Bank.instance.createAccount(newAccount)
            
        } else if editionMode == .Edition {
            
            // Account edition
            Bank.instance.getSelectedAccount().name = textfieldName.text!
            Bank.instance.getSelectedAccount().number = textfieldNumber.text!
        }
        
        // Pop current screen
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func enableEditionMode(accountId: Int){
        editionMode = .Edition
    }
    
}