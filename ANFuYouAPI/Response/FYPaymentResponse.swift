//
//  FYPaymentResponse.swift
//  ANFuYouAPI
//
//  Created by 刘栋 on 2019/1/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation
import SWXMLHash

/*
 <RESPONSE>
 <VERSION>2.0</VERSION>
 <RESPONSECODE>8143</RESPONSECODE>
 <RESPONSEMSG>验证码失效或错误</RESPONSEMSG>
 <MCHNTORDERID>APPZD201812190953041123</MCHNTORDERID>
 <ORDERID>000037830206</ORDERID>
 <AMT>94915</AMT>
 <BANKCARD>6225885865354116</BANKCARD>
 <REM1>1.5</REM1>
 <REM2/>
 <REM3/>
 <SIGNTP>MD5</SIGNTP>
 <MCHNTCD>0002900F0096235</MCHNTCD>
 <SIGN>42500e3dd37b72efe4d48d05246ad910</SIGN>
 <TYPE>02</TYPE>
 <VER>sdk2.1</VER>
 </RESPONSE>
 */
public struct FYPaymentResponse: FYResponse {
    
    public let VERSION: String
    public let RESPONSECODE: String
    public let RESPONSEMSG: String
    public let MCHNTORDERID: String
    public let ORDERID: String
    public let AMT: String
    public let BANKCARD: String
    public let REM1: String
    public let REM2: String
    public let REM3: String
    public let SIGNTP: String
    public let MCHNTCD: String
    public let SIGN: String
    public let TYPE: String
    public let VER: String
    
    public init(VERSION: String,
                RESPONSECODE: String,
                RESPONSEMSG: String,
                MCHNTORDERID: String,
                ORDERID: String,
                AMT: String,
                BANKCARD: String,
                REM1: String,
                REM2: String,
                REM3: String,
                SIGNTP: String,
                MCHNTCD: String,
                SIGN: String,
                TYPE: String,
                VER: String) {
        self.VERSION = VERSION
        self.RESPONSECODE = RESPONSECODE
        self.RESPONSEMSG = RESPONSEMSG
        self.MCHNTORDERID = MCHNTORDERID
        self.ORDERID = ORDERID
        self.AMT = AMT
        self.BANKCARD = BANKCARD
        self.REM1 = REM1
        self.REM2 = REM2
        self.REM3 = REM3
        self.SIGNTP = SIGNTP
        self.MCHNTCD = MCHNTCD
        self.SIGN = SIGN
        self.TYPE = TYPE
        self.VER = VER
    }
}

extension FYPaymentResponse {
    
    init?(xml: XMLIndexer) {
        guard
            let VERSION = xml["VERSION"].element?.text,
            let RESPONSECODE = xml["RESPONSECODE"].element?.text,
            let RESPONSEMSG = xml["RESPONSEMSG"].element?.text,
            let MCHNTORDERID = xml["MCHNTORDERID"].element?.text,
            let ORDERID = xml["ORDERID"].element?.text,
            let AMT = xml["AMT"].element?.text,
            let BANKCARD = xml["BANKCARD"].element?.text,
            let REM1 = xml["REM1"].element?.text,
            let REM2 = xml["REM2"].element?.text,
            let REM3 = xml["REM3"].element?.text,
            let SIGNTP = xml["SIGNTP"].element?.text,
            let MCHNTCD = xml["MCHNTCD"].element?.text,
            let SIGN = xml["SIGN"].element?.text,
            let TYPE = xml["TYPE"].element?.text,
            let VER = xml["VER"].element?.text
            else {
                return nil
        }
        self.init(VERSION: VERSION,
                  RESPONSECODE: RESPONSECODE,
                  RESPONSEMSG: RESPONSEMSG,
                  MCHNTORDERID: MCHNTORDERID,
                  ORDERID: ORDERID,
                  AMT: AMT,
                  BANKCARD: BANKCARD,
                  REM1: REM1,
                  REM2: REM2,
                  REM3: REM3,
                  SIGNTP: SIGNTP,
                  MCHNTCD: MCHNTCD,
                  SIGN: SIGN,
                  TYPE: TYPE,
                  VER: VER)
    }
}
