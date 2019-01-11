//
//  FYNetworkError.swift
//  ANFuYouAPI
//
//  Created by 刘栋 on 2019/1/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

/// 网络错误
public enum FYNetworkError: Error, CustomStringConvertible {
    
    case parse
    case response(code: String, message: String)
    case wrongXML
    
    public var localizedDescription: String {
        switch self {
        case .parse:
            return "无法解析服务器响应"
        case .response(_, let message):
            return message
        case .wrongXML:
            return "非法的XML"
        }
    }
    
    public var description: String {
        switch self {
        case .parse:
            return "无法解析服务器响应"
        case .response(let code, let message):
            return "错误的响应：\(code),\(message)"
        case .wrongXML:
            return "非法的XML"
        }
    }
}
