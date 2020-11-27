//
//  BodyStringRepresentable.swift
//  AlamofireEasyLogger
//
//  Created by Jan Kaltoun on 27.11.2020.
//  Copyright © 2020 AlamofireEasyLogger. All rights reserved.
//

import Foundation

protocol BodyStringRepresentable {
    
    var bodyData: Data? { get }
}

extension BodyStringRepresentable {
    
    var body: String? {
        var body: String?
        
        if let data = bodyData {
            body = String(data: data, encoding: .utf8)
        }
        
        return body
    }
    
    var prettyPrintedBody: String? {
        guard
            let data = bodyData,
            let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let prettyPrintedData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedBody = String(data: prettyPrintedData, encoding: .utf8)
        else {
            return nil
        }

        return prettyPrintedBody
    }
}
