//
//  ReportResultsVC.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class ReportResultsVC: UITableViewController {
    
    var allAccountsAndTransactions: [AnyObject] = []
    
    // -------------------------
    // UIViewController
    // -------------------------
    
    override func viewDidLoad() { // Called when the view is about to made visible. Default does nothing
        createListOfAccountsAndTransactions()
    }
    
    
    // -------------------------
    // UITableViewDataSource
    // -------------------------
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAccountsAndTransactions.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if let account = allAccountsAndTransactions[indexPath.row] as? Account {
            return 80
        }
        
        if let transaction = allAccountsAndTransactions[indexPath.row] as? Transaction {
            return 60
        }
        
        return 0 // Impossible Case
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if let account = allAccountsAndTransactions[indexPath.row] as? Account {
            
            cell = tableView.dequeueReusableCellWithIdentifier("CellAccount")! as UITableViewCell
            
            // Cell Color
            cell.backgroundColor = View.accountsColor
            
            // Cell Content
            for currentView in cell.subviews[0].subviews {
                
                let labelView = currentView as! UILabel
                
                if labelView.tag == 1 { // Name
                    labelView.text = "Account: \(account.name)"
                }
                if labelView.tag == 2 { // Number
                    labelView.text = "Number: \(account.number)"
                }
                if labelView.tag == 3 { // Balance
                    labelView.text = "Balance: $\(String(account.balance))"
                }
            }
        }
        
        if let transaction = allAccountsAndTransactions[indexPath.row] as? Transaction {
            
            cell = tableView.dequeueReusableCellWithIdentifier("CellTransaction")! as UITableViewCell

            // Cell Color
            if transaction.type == TransactionType.Debit {
                cell.backgroundColor = View.transactionColorSoftGreen
            }else{
                cell.backgroundColor = View.transactionColorSoftRed
            }
            
            // Cell Content
            for currentView in cell.subviews[0].subviews {
                
                let labelView = currentView as! UILabel
                
                if labelView.tag == 1 { // Type
                    labelView.text = "Transaction Type: \(transaction.type.rawValue)"
                }
                if labelView.tag == 2 { // Date
                    
                    // Date Formatting
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                    
                    let dateString = formatter.stringFromDate(transaction.date)
                    labelView.text = "Date: \(dateString)"
                }
                if labelView.tag == 3 { // Amount
                    labelView.text = "Amount: $\(transaction.amount)"
                }
            }
        }
        
        return cell
    }
    
    func createListOfAccountsAndTransactions() {
        
        for currentAccount in Bank.instance.getSelectedClient().accounts {
            
            // Add Account to list
            allAccountsAndTransactions.append(currentAccount)
            
            for currentTransaction in currentAccount.transactions {
                
                // Check if transaction is between the two selected dates
                if Bank.instance.selectedStartDateForReport.earlierDate(currentTransaction.date).isEqualToDate(Bank.instance.selectedStartDateForReport) {
                    
                    if Bank.instance.selectedEndDateForReport.laterDate(currentTransaction.date).isEqualToDate(Bank.instance.selectedEndDateForReport) {
                        
                        // Add Transaction to list
                        allAccountsAndTransactions.append(currentTransaction)
                    }
                }
            }
        }
        
    }
}