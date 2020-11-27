//
//  AlamofireLoggerResponse.swift
//  AlamofireEasyLogger
//
//  Created by Jan Kaltoun on 01/12/2018.
//  Copyright © 2018 Jan Kaltoun. All rights reserved.
//

import Foundation

public struct AlamofireLoggerResponse {
    
    public let httpURLResponse: HTTPURLResponse
    public let statusCode: Int
    public let headers: [String: String]
    public let bodyData: Data?
}

extension AlamofireLoggerResponse: BodyStringRepresentable {}
