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
    
    override func viewWillAppear(animated: Bool) { // Called when the view is about to made visible. Default does nothing
        self.tableView.reloadData()
    }

    
    
    // -------------------------
    // UITableViewDelegate
    // -------------------------
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print("Client \(indexPath.row)")
        Bank.instance.setSelectedClientId(indexPath.row)
    }
    
    
    
    // -------------------------
    // UITableViewDataSource
    // -------------------------
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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