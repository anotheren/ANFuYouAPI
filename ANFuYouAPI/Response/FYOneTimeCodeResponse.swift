//
//  FYOneTimeCodeResponse.swift
//  ANFuYouAPI
//
//  Created by 刘栋 on 2019/1/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation
import SWXMLHash

/*
 <RESPONSE>
 <RESPONSECODE>0000</RESPONSECODE>
 <RESPONSEMSG>成功</RESPONSEMSG>
 <SIGN>fe538c2944e687b506d4ead1672e6704</SIGN>
 <SIGNPAY>8b385949897d73e94fe244af28472211,9,3806</SIGNPAY>
 <VER></VER>
 </RESPONSE>
 */
public struct FYOneTimeCodeResponse: FYResponse {
    
    public let RESPONSECODE: String
    public let RESPONSEMSG: String
    public let SIGN: String
    public let SIGNPAY: String
    public let VER: String
    
    public init(RESPONSECODE: String,
                RESPONSEMSG: String,
                SIGN: String,
                SIGNPAY: String,
                VER: String) {
        self.RESPONSECODE = RESPONSECODE
        self.RESPONSEMSG = RESPONSEMSG
        self.SIGN = SIGN
        self.SIGNPAY = SIGNPAY
        self.VER = VER
    }
}

extension FYOneTimeCodeResponse {
    
    init?(xml: XMLIndexer) {
        guard
            let RESPONSECODE = xml["RESPONSECODE"].element?.text,
            let RESPONSEMSG = xml["RESPONSEMSG"].element?.text,
            let SIGN = xml["SIGN"].element?.text,
            let SIGNPAY = xml["SIGNPAY"].element?.text,
            let VER = xml["VER"].element?.text
            else {
                return nil
        }
        self.init(RESPONSECODE: RESPONSECODE,
                  RESPONSEMSG: RESPONSEMSG,
                  SIGN: SIGN,
                  SIGNPAY: SIGNPAY,
                  VER: VER)
    }
}
