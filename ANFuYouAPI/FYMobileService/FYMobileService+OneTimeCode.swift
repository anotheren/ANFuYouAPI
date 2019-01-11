//
//  FYMobileService+OneTimeCode.swift
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
    
    public struct OneTimeCode: FYXMLRequestAPI {
        
        public typealias ResultType = FYOneTimeCodeResponse
        
        /*
        VERSION : orderConfirm.version,
        TYPE : orderConfirm.paytype,
        MCHNTORDERID : orderConfirm.mchntOrderId,
        MCHNTCD : orderConfirm.mchntCd,
        USERID : orderConfirm.userId,
        BANKCARD : orderConfirm.cardno,
        ORDERID : orderConfirm.orderNo,
        MOBILE : mobileNo,
        REM1 : "1.5",
        REM2 : "",
        REM3 : "",
        MISRELEASE:orderConfirm.misRelease,
        VERCD:"0000",
        VER:"sdk2.0",
        SIGNTP : 'MD5',
        SIGN : hex_md5(sig).toUpperCase()
        */
        private let TYPE: String = "02"
        private let MCHNTORDERID: String
        private let REM1: String = "1.5"
        private let SIGNTP: String = "MD5"
        private let VERSION: String = "2.0"
        private let VERCD: String = "0000"
        private let MCHNTCD: String
        private let VER: String = "sdk2.1"
        private let MOBILE: String
        private let ORDERID: String
        private let USERID: String
        private let BANKCARD: String
        private let CVN: String = ""
        private let KEY: String
        
        public let environment: FYEnvironment
        
        public init(mobile: String,
                    order: MerchantOrder,
                    orderResponse: FYOrderResponse,
                    environment: FYEnvironment) {
            self.MCHNTORDERID = orderResponse.MCHNTORDERID
            self.MCHNTCD = orderResponse.MCHNTCD
            self.MOBILE = mobile
            self.ORDERID = orderResponse.ORDERID
            self.USERID = orderResponse.USERID
            self.BANKCARD = order.bankCard
            self.KEY = order.keySMS
            self.environment = environment
        }
        
        /// TYPE+"|"+VERSION+"|"+MCHNTCD+"|"+ORDERID+"|"+MCHNTORDERID+"|"+USERID+"|"+BANKCARD+"|"+VERCD+"|"+MOBILE+"|"+CVN+"|"+KEY
        private var SIGN: String {
            #if DEBUG
            print("SIGN FYMobileService.OneTimeCode Use KEY=\(KEY)")
            #endif
            let signString = [TYPE, VERSION, MCHNTCD, ORDERID, MCHNTORDERID, USERID, BANKCARD, VERCD, MOBILE, CVN, KEY].joined(separator: "|")
            return signString.md5()
        }
        
        /*
         <REQUEST>
         <TYPE>02</TYPE>
         <MCHNTORDERID>APPZD201812190953041123</MCHNTORDERID>
         <REM1>1.5</REM1>
         <SIGNTP>MD5</SIGNTP>
         <VERSION>2.0</VERSION>
         <VERCD>0000</VERCD>
         <SIGN>1130e050e55ee5048639e3a2df09723a</SIGN>
         <MCHNTCD>0002900F0096235</MCHNTCD>
         <VER>sdk2.1</VER>
         <MOBILE>15858194522</MOBILE>
         <ORDERID>000037830206</ORDERID>
         <USERID>123</USERID>
         <BANKCARD>6225885865354116</BANKCARD>
         <CVN></CVN>
         </REQUEST>
         */
        private var FMS: String {
            var items = [(String, String)]()
            items.append(("TYPE", TYPE))
            items.append(("MCHNTORDERID", MCHNTORDERID))
            items.append(("REM1", REM1))
            items.append(("SIGNTP", SIGNTP))
            items.append(("VERSION", VERSION))
            items.append(("VERCD", VERCD))
            items.append(("SIGN", SIGN))
            items.append(("MCHNTCD", MCHNTCD))
            items.append(("VER", VER))
            items.append(("MOBILE", MOBILE))
            items.append(("ORDERID", ORDERID))
            items.append(("USERID", USERID))
            items.append(("BANKCARD", BANKCARD))
            items.append(("CVN", CVN))
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
            return "/sdkpay/messageSdkAction.pay"
        }
        
        public var method: HTTPMethod {
            return .post
        }
        
        public var parameters: Parameters {
            var parameters = [String: Any]()
            parameters["FMS"] = FMS
            #if DEBUG
            print(parameters)
            #endif
            return parameters
        }
        
        public func handle(xml: XMLIndexer) -> Result<FYOneTimeCodeResponse> {
            guard let response = FYOneTimeCodeResponse(xml: xml["RESPONSE"]) else {
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
