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
    // UITableViewDelegate
    // -------------------------
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print("Account \(indexPath.row)")
        Bank.instance.setSelectedAccountId(indexPath.row)
    }
    
    
    
    // -------------------------
    // UITableViewDataSource
    // -------------------------
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bank.instance.getSelectedClient().accounts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        for currentView in cell.subviews[0].subviews {
            
            let labelView = currentView as! UILabel
            
            if labelView.tag == 1 { // Name
                labelView.text = Bank.instance.getSelectedClient().accounts[indexPath.row].name
            }
            if labelView.tag == 2 { // Number
                labelView.text = "Number: \(Bank.instance.getSelectedClient().accounts[indexPath.row].number)"
            }
            if labelView.tag == 3 { // Balance
                labelView.text = "Balance: \(String(Bank.instance.getSelectedClient().accounts[indexPath.row].balance))"
            }
        }
        return cell
    }
    
}