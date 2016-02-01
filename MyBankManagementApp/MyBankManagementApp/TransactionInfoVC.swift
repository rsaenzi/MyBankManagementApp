//
//  TransactionInfoVC.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit
import Foundation

class TransactionInfoVC: UIViewController {
    
    @IBOutlet weak var toggleType: UISegmentedControl!
    @IBOutlet weak var textfieldAmount: UITextField!
    
    @IBAction func onClickSave(sender: UIBarButtonItem) {
        
        // Transaction creation
        var selectedType = TransactionType.Debit
        if toggleType.selectedSegmentIndex == 0 { // Debit
            selectedType = TransactionType.Debit
            
        } else if toggleType.selectedSegmentIndex == 1 { // Credit
            selectedType = TransactionType.Credit
        }
        
        // Input validation
        if textfieldAmount.text == "" {
            View.showAlert(self, messageToShow: "Amount can not be empty")
            return
        }
        // Test if amount textfield contains a number
        if let number = Int64(textfieldAmount.text!) {
            
            if number <= 0 {
                View.showAlert(self, messageToShow: "Amount can not be negative or zero")
                return
            }
            
            // Transaction amount validation
            if selectedType == TransactionType.Credit {
                
                // Check if have any cash
                if Bank.instance.getSelectedAccount().balance > 0 {
                    
                    // Check if have enough cash to do this transaction
                    if number > Bank.instance.getSelectedAccount().balance {
                        View.showAlert(self, messageToShow: "Balance is not enough to do this transaction\nBalance: \(Bank.instance.getSelectedAccount().balance)")
                        return
                    }
                }else{
                    View.showAlert(self, messageToShow: "Balance is not enough to do this transaction\nBalance: \(Bank.instance.getSelectedAccount().balance)")
                    return
                }
            }
            
        }else {
            View.showAlert(self, messageToShow: "Amount can not have letters and spaces")
            return
        }

        // Transaction creation
        let newTransaction = Transaction(newType: selectedType, newDate: NSDate(), newAmount: Int64(textfieldAmount.text!)!)
        Bank.instance.addTransactionToAccount(newTransaction)
        
        // Pop current screen
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}