//
//  ReportSelectDateRangeVC.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

class ReportSelectDateRangeVC: UIViewController {
    
    @IBOutlet weak var datePickerStart: UIDatePicker!
    @IBOutlet weak var datePickerEnd: UIDatePicker!
    
    private var startDate = NSDate()
    private var endDate = NSDate()
    
    override func viewWillAppear(animated: Bool) { // Called when the view is about to made visible. Default does nothing
        
        datePickerStart.date = NSDate()
        datePickerEnd.date = datePickerStart.date
    }
    
    @IBAction func onClickGenerate(sender: UIButton, forEvent event: UIEvent) {
        
        // Get dates from pickers
        startDate = datePickerStart.date
        endDate = datePickerEnd.date
        
        // Validate if endDate is after startDate
        if startDate.earlierDate(endDate).isEqualToDate(startDate) {
            // StartDate is earlier than EndDate
        }else {
            View.showAlert(self, messageToShow: "The start date cannot be after end date.")
            return
        }
        
        // Save selected dates
        Bank.instance.selectedStartDateForReport = startDate
        Bank.instance.selectedEndDateForReport = endDate
    }
    
}