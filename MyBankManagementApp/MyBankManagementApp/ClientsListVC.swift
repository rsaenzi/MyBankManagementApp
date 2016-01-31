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
        
    }
    
    override func viewWillAppear(animated: Bool) { // Called when the view is about to made visible. Default does nothing
        
    }
    
    override func viewDidAppear(animated: Bool) { // Called when the view has been fully transitioned onto the screen. Default does nothing
        
    }
    
    
    // -------------------------
    // UITableViewDelegate
    // -------------------------
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected Row: \(indexPath.row)")
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print("Selected Icon: \(indexPath.row)")
    }
    
    
    // -------------------------
    // UITableViewDataSource
    // -------------------------
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        return cell
    }
    
}