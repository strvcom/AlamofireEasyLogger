//
//  AlamofireLoggerResponse.swift
//  AlamofireEasyLogger
//
//  Created by Jan Kaltoun on 01/12/2018.
//  Copyright © 2018 Jan Kaltoun. All rights reserved.
//

import Foundation

public struct AlamofireLoggerResponse {
    
    let httpURLResponse: HTTPURLResponse
    let statusCode: Int
    let headers: [String: String]
    let body: String?
}
