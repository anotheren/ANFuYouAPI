//
//  FYResponse.swift
//  ANFuYouAPI
//
//  Created by 刘栋 on 2019/1/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

protocol FYResponse {
    
    var RESPONSECODE: String { get }
    var RESPONSEMSG: String { get }
    
    var isSuccess: Bool { get }
}

extension FYResponse {
    
    var isSuccess: Bool {
        return RESPONSECODE == "0000"
    }
}
