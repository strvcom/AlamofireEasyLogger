//
//  AlamofireLogger.swift
//  AlamofireEasyLogger
//
//  Created by Jan Kaltoun on 07/07/2018.
//  Copyright © 2018 Jan Kaltoun. All rights reserved.
//

import Foundation
import Alamofire

public class AlamofireLogger {
    
    public weak var delegate: AlamofireLoggerDelegate?
    
    public init() {}
    
    public func startLogging() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(AlamofireLogger.networkRequestDidStart(notification:)),
            name: Request.didResumeTaskNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(AlamofireLogger.networkRequestDidComplete(notification:)),
            name: Request.didCompleteTaskNotification,
            object: nil
        )
    }
    
    @objc private func networkRequestDidStart(notification: Notification) {
        guard
            let request = notification.request
        else {
            delegate?.loggingFailed(error: .responseParsingFailed)
            
            return
        }
        
        guard let loggerRequest = request.request?.alamofireLoggerRequest else {
            delegate?.loggingFailed(error: .requestParsingFailed)
            
            return
        }
        
        delegate?.networkRequestDidStart(
            request: loggerRequest
        )
    }
    
    @objc private func networkRequestDidComplete(notification: Notification) {
        guard
            let request = notification.request as? DataRequest
        else {
            delegate?.loggingFailed(error: .responseParsingFailed)
            
            return
        }
        
        guard let loggerRequest = request.request?.alamofireLoggerRequest else {
            delegate?.loggingFailed(error: .requestParsingFailed)
            
            return
        }
        
        if let error = request.error {
            delegate?.networkRequestDidComplete(
                request: loggerRequest,
                result: .failure(error)
            )
            
            return
        }
        
        guard
            let response = request.response,
            let responseHeaders = response.allHeaderFields as? [String: String]
        else {
            delegate?.loggingFailed(error: .responseParsingFailed)
            
            return
        }
        
        delegate?.networkRequestDidComplete(
            request: loggerRequest,
            result: .success(
                AlamofireLoggerResponse(
                    httpURLResponse: response,
                    statusCode: response.statusCode,
                    headers: responseHeaders,
                    bodyData: request.data
                )
            )
        )
    }
}
