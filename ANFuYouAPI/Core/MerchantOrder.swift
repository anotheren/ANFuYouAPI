//
//  MerchantOrder.swift
//  ANFuYouAPI
//
//  Created by 刘栋 on 2019/1/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public struct MerchantOrder {
    
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
    
    
    /// 商户订单
    ///
    /// 构造一张商户订单
    ///
    /// - Parameters:
    ///   - backURL: 回调地址
    ///   - mchntOrderID: 商户订单号
    ///   - amount: 金额，单位：分
    ///   - idNumber: 用户身份证号
    ///   - userName: 用户姓名
    ///   - bankCard: 用户银行卡号
    ///   - userID: 用户编号
    ///   - mchntCD: 商户号
    ///   - keyMerchant: 商户密钥，用于订单生成接口签名
    ///   - keySMS: 短信密钥，用于短信发送接口签名，官方写死在客户端中，建议直接由服务端一起下发
    ///   - keyPay: 支付密钥，用于用户支付接口签名，官方写死在客户端中，建议直接由服务端一起下发
    public init(backURL: String,
                mchntOrderID: String,
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
        self.mchntOrderID = mchntOrderID
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
