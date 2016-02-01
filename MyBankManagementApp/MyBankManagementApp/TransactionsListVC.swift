//
//  TransactionsListVC.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class TransactionsListVC: UITableViewController {
    
    // -------------------------
    // UIViewController
    // -------------------------
    
    override func viewWillAppear(animated: Bool) { // Called when the view is about to made visible. Default does nothing
        self.tableView.reloadData()
    }
    
    
    
    // -------------------------
    // UITableViewController
    // -------------------------
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        Bank.instance.setSelectedTransactionId(indexPath.row)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bank.instance.getSelectedAccount().transactions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        // Cell Color
        if Bank.instance.getSelectedAccount().transactions[indexPath.row].type == TransactionType.Debit {
            cell.backgroundColor = View.transactionColorSoftGreen
        }else{
            cell.backgroundColor = View.transactionColorSoftRed
        }
        
        // Cell Content
        for currentView in cell.subviews[0].subviews {
            
            let labelView = currentView as! UILabel
            
            if labelView.tag == 1 { // Type
                labelView.text = Bank.instance.getSelectedAccount().transactions[indexPath.row].type.rawValue
            }
            if labelView.tag == 2 { // Date
                
                // Date Formatting
                let formatter = NSDateFormatter()
                formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                
                let dateString = formatter.stringFromDate(Bank.instance.getSelectedAccount().transactions[indexPath.row].date)
                labelView.text = "Date: \(dateString)"
            }
            if labelView.tag == 3 { // Amount
                labelView.text = "Amount: $\(Bank.instance.getSelectedAccount().transactions[indexPath.row].amount)"
            }
        }
        return cell
    }
    
}