//
//  Data+PrettyPrint.swift
//  AlamofireEasyLogger
//
//  Created by Daniel Cech on 12/11/2020.
//  Copyright © 2020 AlamofireEasyLogger. All rights reserved.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: String? {
        guard
            let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = String(data: data, encoding: .utf8)
        else {
            return nil
        }

        return prettyPrintedString
    }
}
