//
//  FYOrder.swift
//  ANFuYouAPI
//
//  Created by 刘栋 on 2019/1/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public struct FYOrder {
    
    public let backURL: String
    public let mchntOrderID: String
    public let amount: String
    public let idNumber: String
    public let userName: String
    public let bankCard: String
    public let userID: String
    public let mchntCD: String
    public let keyMerchant: String
    public let keySMS: String
    public let keyPay: String
    
    public init(backURL: String,
                orderID: String,
                amount: String,
                idNumber: String,
                userName: String,
                bankCard: String,
                userID: String,
                mchntCD: String,
                keyMerchant: String,
                keySMS: String = "f13bdadb0bbe29966e9e4c4e01677bc0",
                keyPay: String = "f13bdadb0bbe29966e9e4c4e01677bc0") {
        self.backURL = backURL
        self.mchntOrderID = orderID
        self.amount = amount
        self.idNumber = idNumber
        self.userName = userName
        self.bankCard = bankCard
        self.userID = userID
        self.mchntCD = mchntCD
        self.keyMerchant = keyMerchant
        self.keySMS = keySMS
        self.keyPay = keyPay
    }
}
