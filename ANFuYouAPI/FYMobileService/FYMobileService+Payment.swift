//
//  FYMobileService+Payment.swift
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
    
    /// 用户支付接口
    public struct Payment: FYXMLRequestAPI {
        
        public typealias ResultType = FYPaymentResponse
        
        private let TYPE: String = "02"
        private let MCHNTORDERID: String
        private let REM1: String = "1.5"
        private let SIGNTP: String = "MD5"
        private let VERSION: String = "2.0"
        private let VERCD: String
        private let MCHNTCD: String
        private let VER: String = "sdk2.0"
        private let MOBILE: String
        private let ORDERID: String
        private let USERID: String
        private let BANKCARD: String
        private let CVN: String = ""
        private let SIGNPAY: String
        private let KEY: String
        
        public let environment: FYEnvironment
        
        /// 用户支付接口
        ///
        /// - Parameters:
        ///   - mobile: 手机号
        ///   - oneTimeCode: 验证码
        ///   - order: 商户订单
        ///   - orderRespone: 订单生成接口响应
        ///   - oneTimeCodeResponse: 验证码接口响应
        ///   - environment: 接口环境
        public init(mobile: String,
                    oneTimeCode: String,
                    order: MerchantOrder,
                    orderRespone: FYOrderResponse,
                    oneTimeCodeResponse: FYOneTimeCodeResponse,
                    environment: FYEnvironment) {
            self.MCHNTORDERID = order.mchntOrderID
            self.VERCD = oneTimeCode
            self.MCHNTCD = order.mchntCD
            self.MOBILE = mobile
            self.ORDERID = orderRespone.ORDERID
            self.USERID = order.userID
            self.BANKCARD = order.bankCard
            self.SIGNPAY = oneTimeCodeResponse.SIGNPAY
            self.KEY = order.keyPay
            self.environment = environment
        }
        
        /// TYPE+"|"+VERSION+"|"+MCHNTCD+"|"+ORDERID+"|"+MCHNTORDERID+"|"+USERID+"|"+BANKCARD+"|"+"VERCD"+"|"+MOBILE+"|"+CVN+"|"+KEY
        private var SIGN: String {
            #if DEBUG
            print("SIGN FYMobileService.Payment Use KEY=\(KEY)")
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
         <VERCD>111111</VERCD> //验证码
         <SIGN>c39632d0c9ec9c15f5d909764f89f613</SIGN>
         <MCHNTCD>0002900F0096235</MCHNTCD>
         <VER>sdk2.1</VER>
         <MOBILE>15858194522</MOBILE>
         <ORDERID>000037830206</ORDERID>
         <USERID>123</USERID>
         <BANKCARD>6225885865354116</BANKCARD>
         <CVN></CVN>
         <SIGNPAY>8b385949897d73e94fe244af28472211,9,3806</SIGNPAY>
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
            items.append(("SIGNPAY", SIGNPAY))
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
            return "/sdkpay/payAction.pay"
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
        
        public func handle(xml: XMLIndexer) -> Result<FYPaymentResponse, Error> {
            guard let response = FYPaymentResponse(xml: xml["RESPONSE"]) else {
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
