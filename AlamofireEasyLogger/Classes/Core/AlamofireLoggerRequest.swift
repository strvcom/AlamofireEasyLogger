//
//  AlamofireLoggerRequest.swift
//  AlamofireEasyLogger
//
//  Created by Jan Kaltoun on 01/12/2018.
//  Copyright © 2018 Jan Kaltoun. All rights reserved.
//

import Foundation

public struct AlamofireLoggerRequest {
    
    let urlRequest: URLRequest
    let method: String
    let url: URL
    let headers: [String: String]?
    let body: String?
}
