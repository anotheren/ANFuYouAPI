//
//  FYCommonResponse.swift
//  ANFuYouAPI
//
//  Created by 刘栋 on 2019/1/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation
import SWXMLHash

struct FYCommonResponse: FYResponse {
    
    let RESPONSECODE: String
    let RESPONSEMSG: String
    
    init(RESPONSECODE: String, RESPONSEMSG: String) {
        self.RESPONSECODE = RESPONSECODE
        self.RESPONSEMSG = RESPONSEMSG
    }
}

extension FYCommonResponse {
    
    init?(xml: XMLIndexer) {
        guard
            let RESPONSECODE = xml["RESPONSECODE"].element?.text,
            let RESPONSEMSG = xml["RESPONSEMSG"].element?.text
            else {
                return nil
        }
        self.init(RESPONSECODE: RESPONSECODE, RESPONSEMSG: RESPONSEMSG)
    }
}
