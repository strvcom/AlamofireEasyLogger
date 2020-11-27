//
//  AlamofireLoggerRequest.swift
//  AlamofireEasyLogger
//
//  Created by Jan Kaltoun on 01/12/2018.
//  Copyright © 2018 Jan Kaltoun. All rights reserved.
//

import Foundation

public struct AlamofireLoggerRequest {
    
    public let urlRequest: URLRequest
    public let method: String
    public let url: URL
    public let headers: [String: String]?
    public let bodyData: Data?
}

extension AlamofireLoggerRequest: BodyStringRepresentable {}
