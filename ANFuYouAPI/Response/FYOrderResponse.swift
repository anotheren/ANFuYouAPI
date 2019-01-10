//
//  FYOrderResponse.swift
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
 <RESPONSECODE>0000</RESPONSECODE>
 <RESPONSEMSG>成功</RESPONSEMSG>
 <MCHNTCD>0002900F0096235</MCHNTCD>
 <MCHNTORDERID>APPZD201812190953041123</MCHNTORDERID>
 <USERID>123</USERID>
 <ORDERID>000037830206</ORDERID>
 <CTP>01</CTP>
 <CNM>招商银行</CNM>
 <INSCD>0803080000</INSCD>
 <REM1>1.5</REM1>
 <REM2></REM2>
 <REM3></REM3>
 <SIGNTP>MD5</SIGNTP>
 <SIGN>840d81b6be9d4265e9942a5d2677aa1c</SIGN>
 <TYPE>02</TYPE>
 </RESPONSE>
 */
public struct FYOrderResponse: FYResponse {
    
    public let VERSION: String
    public let RESPONSECODE: String
    public let RESPONSEMSG: String
    public let MCHNTCD: String
    public let MCHNTORDERID: String
    public let USERID: String
    public let ORDERID: String
    public let CTP: String
    public let CNM: String
    public let INSCD: String
    public let REM1: String
    public let REM2: String
    public let REM3: String
    public let SIGNTP: String
    public let SIGN: String
    public let TYPE: String
    
    public init(VERSION: String,
                RESPONSECODE: String,
                RESPONSEMSG: String,
                MCHNTCD: String,
                MCHNTORDERID: String,
                USERID: String,
                ORDERID: String,
                CTP: String,
                CNM: String,
                INSCD: String,
                REM1: String,
                REM2: String,
                REM3: String,
                SIGNTP: String,
                SIGN: String,
                TYPE: String) {
        self.VERSION = VERSION
        self.RESPONSECODE = RESPONSECODE
        self.RESPONSEMSG = RESPONSEMSG
        self.MCHNTCD = MCHNTCD
        self.MCHNTORDERID = MCHNTORDERID
        self.USERID = USERID
        self.ORDERID = ORDERID
        self.CTP = CTP
        self.CNM = CNM
        self.INSCD = INSCD
        self.REM1 = REM1
        self.REM2 = REM2
        self.REM3 = REM3
        self.SIGNTP = SIGNTP
        self.SIGN = SIGN
        self.TYPE = TYPE
    }
}

extension FYOrderResponse {
    
    init?(xml: XMLIndexer) {
        guard
            let VERSION = xml["VERSION"].element?.text,
            let RESPONSECODE = xml["RESPONSECODE"].element?.text,
            let RESPONSEMSG = xml["RESPONSEMSG"].element?.text,
            let MCHNTCD = xml["MCHNTCD"].element?.text,
            let MCHNTORDERID = xml["MCHNTORDERID"].element?.text,
            let USERID = xml["USERID"].element?.text,
            let ORDERID = xml["ORDERID"].element?.text,
            let CTP = xml["CTP"].element?.text,
            let CNM = xml["CNM"].element?.text,
            let INSCD = xml["INSCD"].element?.text,
            let REM1 = xml["REM1"].element?.text,
            let REM2 = xml["REM2"].element?.text,
            let REM3 = xml["REM3"].element?.text,
            let SIGNTP = xml["SIGNTP"].element?.text,
            let SIGN = xml["SIGN"].element?.text,
            let TYPE = xml["TYPE"].element?.text
            else {
                return nil
        }
        self.init(VERSION: VERSION,
                  RESPONSECODE: RESPONSECODE,
                  RESPONSEMSG: RESPONSEMSG,
                  MCHNTCD: MCHNTCD,
                  MCHNTORDERID: MCHNTORDERID,
                  USERID: USERID,
                  ORDERID: ORDERID,
                  CTP: CTP,
                  CNM: CNM,
                  INSCD: INSCD,
                  REM1: REM1,
                  REM2: REM2,
                  REM3: REM3,
                  SIGNTP: SIGNTP,
                  SIGN: SIGN,
                  TYPE: TYPE)
    }
}
