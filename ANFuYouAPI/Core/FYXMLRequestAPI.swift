//
//  FYXMLRequestAPI.swift
//  ANFuYouAPI
//
//  Created by 刘栋 on 2019/1/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation
import ANBaseNetwork
import SWXMLHash
import Alamofire

public protocol FYXMLRequestAPI: DataRequestAPI {
    
    func handle(xml: XMLIndexer) -> Result<ResultType>
}

extension FYXMLRequestAPI {
    
    public func handle(data: Data) -> Result<ResultType> {
        let xml = SWXMLHash.parse(data)
        return handle(xml: xml)
    }
}
