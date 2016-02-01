//
//  AccountsListVC.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class AccountsListVC: UITableViewController {
    
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
        Bank.instance.setSelectedAccountId(indexPath.row)
    }
    
    // Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Hit delete button for selected row
        if editingStyle == UITableViewCellEditingStyle.Delete {
            Bank.instance.deleteAccount(indexPath.row, accountToDelete: Bank.instance.getSelectedClient().accounts[indexPath.row])
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        Bank.instance.setSelectedAccountId(indexPath.row)
        
        // Create ClientInfo screen
        let accountInfoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AccountInfo") as! AccountInfoVC
        
        // Configure screen to edit selected account
        accountInfoVC.enableEditionMode(indexPath.row)
        
        // Add screen to navigation controller
        self.navigationController?.pushViewController(accountInfoVC, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bank.instance.getSelectedClient().accounts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        // Cell Color
        cell.backgroundColor = View.accountsColor
        
        // Cell Content
        for currentView in cell.subviews[0].subviews {
            
            let labelView = currentView as! UILabel
            
            if labelView.tag == 1 { // Name
                labelView.text = Bank.instance.getSelectedClient().accounts[indexPath.row].name
            }
            if labelView.tag == 2 { // Number
                labelView.text = "Number: \(Bank.instance.getSelectedClient().accounts[indexPath.row].number)"
            }
            if labelView.tag == 3 { // Balance
                labelView.text = "Balance: $\(String(Bank.instance.getSelectedClient().accounts[indexPath.row].balance))"
            }
        }
        return cell
    }
    
}