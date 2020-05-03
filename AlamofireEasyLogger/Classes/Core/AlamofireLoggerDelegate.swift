//
//  AlamofireLoggerDelegate.swift
//  AlamofireEasyLogger
//
//  Created by Jan Kaltoun on 01/12/2018.
//  Copyright © 2018 Jan Kaltoun. All rights reserved.
//

public protocol AlamofireLoggerDelegate: class {
    
    func networkRequestDidStart(request: AlamofireLoggerRequest)
    func networkRequestDidComplete(request: AlamofireLoggerRequest, result: AlamofireLoggerResult)
    func loggingFailed(error: AlamofireLoggingError)
}
