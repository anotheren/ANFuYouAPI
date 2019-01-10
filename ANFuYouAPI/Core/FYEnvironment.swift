//
//  FYEnvironment.swift
//  ANFuYouAPI
//
//  Created by 刘栋 on 2019/1/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public enum FYEnvironment {
    
    case develop
    case release
    
    var isTest: String {
        switch self {
        case .develop:
            return "1"
        case .release:
            return "0"
        }
    }
    
    public var baseURL: String {
        switch self {
        case .release:
            return "https://mpay.fuiou.com:16128"
        case .develop:
            return "http://www-1.fuiou.com:18670/mobile_pay"
        }
    }
}

extension FYEnvironment: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .release:
            return "RELEASE"
        case .develop:
            return "DEVELOP"
        }
    }
}
