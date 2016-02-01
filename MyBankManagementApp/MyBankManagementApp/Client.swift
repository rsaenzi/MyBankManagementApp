//
//  Client.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import Foundation

class Client {
    
    var databaseId: Int64
    var name: String
    var address: String
    var phone: String
    var accounts: [Account]
    
    init(newName: String, newAddress: String, newPhone: String){
        databaseId = 0
        name = newName
        address = newAddress
        phone = newPhone
        accounts = []
    }
    
}