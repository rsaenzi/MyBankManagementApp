//
//  ReportSelectClientVC.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class ReportSelectClientVC: UITableViewController {
    
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
        Bank.instance.setSelectedClientId(indexPath.row)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Bank.instance.clients.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        // Cell Color
        cell.backgroundColor = View.clientsColor
        
        // Cell Content
        cell.textLabel?.text = Bank.instance.clients[indexPath.row].name
        
        return cell
    }
    
}