//
//  FYMobileService+Order.swift
//  ANFuYouAPI
//
//  Created by 刘栋 on 2018/12/20.
//  Copyright © 2018 anotheren.com. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash
import CryptoSwift
import ANBaseNetwork

extension FYMobileService {
    
    /// 订单生成接口
    public struct Order: FYXMLRequestAPI {
        
        public typealias ResultType = FYOrderResponse
        
        private let TYPE: String = "02"
        private let MCHNTORDERID: String
        private let IDTYPE: String = "0"
        private let REM1: String = "1.5"
        private let SIGNTP: String = "MD5"
        private let VERSION: String = "2.0"
        private let TEST: String
        private let NAME: String
        private let AMT: String
        private let MCHNTCD: String
        private let BACKURL: String
        private let IDNO: String
        private let USERID: String
        private let BANKCARD: String
        private let KEY: String
        
        public let environment: FYEnvironment
        
        /// 订单生成接口
        ///
        /// - Parameters:
        ///   - order: 商户订单
        ///   - environment: 接口环境
        public init(order: MerchantOrder,
                    environment: FYEnvironment) {
            self.MCHNTORDERID = order.mchntOrderID
            self.TEST = environment.isTest
            self.NAME = order.userName
            self.AMT = order.amount
            self.MCHNTCD = order.mchntCD
            self.BACKURL = order.backURL
            self.IDNO = order.idNumber
            self.USERID = order.userID
            self.BANKCARD = order.bankCard
            self.KEY = order.keyMerchant
            self.environment = environment
        }
        
        /// TYPE+"|"+VERSION+"|"+MCHNTCD+"|"+MCHNTORDERID+"|"+USERID+"|"+AMT+"|"+BANKCARD+"|"+BACKURL+"|"+NAME+"|"+IDNO+"|"+IDTYPE+"|"+KEY
        private var SIGN: String {
            #if DEBUG
            print("SIGN FYMobileService.Order Use KEY=\(KEY)")
            #endif
            let signString = [TYPE, VERSION, MCHNTCD, MCHNTORDERID, USERID, AMT, BANKCARD, BACKURL, NAME, IDNO, IDTYPE, KEY].joined(separator: "|")
            return signString.md5()
        }
        
        /*
         <REQUEST>
         <TYPE>02</TYPE>
         <MCHNTORDERID>APPZD201812190953041123</MCHNTORDERID>
         <IDTYPE>0</IDTYPE>
         <REM1>1.5</REM1>
         <SIGNTP>MD5</SIGNTP>
         <VERSION>2.0</VERSION>
         <TEST>1</TEST>
         <NAME>李锋兵</NAME>
         <AMT>94915</AMT>
         <MCHNTCD>0002900F0096235</MCHNTCD>
         <SIGN>afc893fa153bebffa03846471e9685f2</SIGN>
         <BACKURL>http://47.99.112.211:8080/repayboot/selfpay/paynotity</BACKURL>
         <IDNO>412701196808071013</IDNO>
         <USERID>123</USERID>
         <BANKCARD>6225885865354116</BANKCARD>
         </REQUEST>
         */
        private var FMS: String {
            var items = [(String, String)]()
            items.append(("TYPE", TYPE))
            items.append(("MCHNTORDERID", MCHNTORDERID))
            items.append(("IDTYPE", IDTYPE))
            items.append(("REM1", REM1))
            items.append(("SIGNTP", SIGNTP))
            items.append(("VERSION", VERSION))
            items.append(("TEST", TEST))
            items.append(("NAME", NAME))
            items.append(("AMT", AMT))
            items.append(("MCHNTCD", MCHNTCD))
            items.append(("SIGN", SIGN))
            items.append(("BACKURL", BACKURL))
            items.append(("IDNO", IDNO))
            items.append(("USERID", USERID))
            items.append(("BANKCARD", BANKCARD))
            var results = ""
            for (key ,value) in items {
                results.append("<\(key)>\(value)</\(key)>")
            }
            return "<REQUEST>\(results)</REQUEST>"
        }
        
        public var baseURL: String {
            return environment.baseURL
        }
        
        public var path: String {
            return "/sdkpay/orderAction.pay"
        }
        
        public var method: HTTPMethod {
            return .post
        }
        
        public var parameters: Parameters {
            var parameters = [String: Any]()
            parameters["sdkversion"] = "1.5"
            parameters["FMS"] = FMS
            #if DEBUG
            print(parameters)
            #endif
            return parameters
        }
        
        public func handle(xml: XMLIndexer) -> Result<FYOrderResponse> {
            guard let response = FYOrderResponse(xml: xml["RESPONSE"]) else {
                guard let _response = FYCommonResponse(xml: xml["RESPONSE"]) else {
                    return .failure(FYNetworkError.wrongXML)
                }
                return .failure(FYNetworkError.response(code: _response.RESPONSECODE, message: _response.RESPONSEMSG))
            }
            #if DEBUG
            print(response)
            #endif
            guard response.isSuccess else {
                return .failure(FYNetworkError.response(code: response.RESPONSECODE, message: response.RESPONSEMSG))
            }
            return .success(response)
        }
    }
}
