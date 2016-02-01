//
//  ClientsListVC.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class ClientsListVC: UITableViewController {
    
    // -------------------------
    // UIViewController
    // -------------------------

    override func viewDidLoad() { // Called after the view has been loaded. For view controllers created in code, this is after -loadView. For view controllers unarchived from a nib, this is after the view is set.
     
        //View.showAlert(self, messageToShow: "On a Client entry, press icon (i) to Edit, swipe left to Delete and tap to View its accounts.\n\nSame controls apply for Accounts.\n\nTransactions can not be edited or deleted.")
    }
    
    override func viewWillAppear(animated: Bool) { // Called when the view is about to made visible. Default does nothing
        self.tableView.reloadData()
    }
    
    
    
    // -------------------------
    // UITableViewController
    // -------------------------
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print("Client \(indexPath.row)")
        Bank.instance.setSelectedClientId(indexPath.row)
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
            Bank.instance.deleteClient(indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print("Icon: \(indexPath.row)")
        
        // Create ClientInfo screen
        let clientInfoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ClientInfo") as! ClientInfoVC
        
        // Configure screen to edit selected client
        clientInfoVC.editionMode = ScreensInfoEditionMode.Edition
        
        // Add screen to navigation controller
        self.navigationController?.pushViewController(clientInfoVC, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (View.alertShownFirstTime == false) && (Bank.instance.clients.count == 1) {
            
            // Instruction dialog
            View.alertShownFirstTime = true
            
            View.showAlert(self, messageToShow: "On a Client entry, press icon (i) to Edit, swipe left to Delete and tap to View its accounts.\n\nSame controls apply for Accounts.\n\nTransactions can not be edited or deleted.")
        }
        return Bank.instance.clients.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        for currentView in cell.subviews[0].subviews {
            
            let labelView = currentView as! UILabel
            
            if labelView.tag == 1 { // Name
                labelView.text = Bank.instance.clients[indexPath.row].name
            }
            if labelView.tag == 2 { // Address
                labelView.text = "Address: \(Bank.instance.clients[indexPath.row].address)"
            }
            if labelView.tag == 3 { // Phone
                labelView.text = "Phone: \(Bank.instance.clients[indexPath.row].phone)"
            }
        }
        return cell
    }
    
}