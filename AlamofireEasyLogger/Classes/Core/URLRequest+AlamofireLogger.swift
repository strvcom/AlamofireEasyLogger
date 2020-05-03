//
//  URLRequest+AlamofireLogger.swift
//  AlamofireEasyLogger
//
//  Created by Jan Kaltoun on 01/12/2018.
//  Copyright © 2018 Jan Kaltoun. All rights reserved.
//

import Foundation

extension URLRequest {
    
    var alamofireLoggerRequest: AlamofireLoggerRequest? {
        guard
            let url = url,
            let method = httpMethod
        else {
            return nil
        }
        
        var body: String?
        
        if let httpBody = httpBody {
            body = String(data: httpBody, encoding: .utf8)
        }
        
        return AlamofireLoggerRequest(
            urlRequest: self,
            method: method,
            url: url,
            headers: allHTTPHeaderFields,
            body: body
        )
    }
}
