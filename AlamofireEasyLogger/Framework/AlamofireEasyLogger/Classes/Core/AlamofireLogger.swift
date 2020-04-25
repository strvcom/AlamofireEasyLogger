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
    
    public func startLogging() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(AlamofireLogger.networkRequestDidStart(notification:)),
            name: Notification.Name.Task.DidResume,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(AlamofireLogger.networkRequestDidComplete(notification:)),
            name: Notification.Name.Task.DidComplete,
            object: nil
        )
    }
    
    @objc private func networkRequestDidStart(notification: Notification) {
        guard
            let task = notification.userInfo?[Notification.Key.Task] as? URLSessionTask,
            let loggerRequest = task.originalRequest?.alamofireLoggerRequest
        else {
            delegate?.loggingFailed(error: .requestParsingFailed)
            
            return
        }
        
        delegate?.networkRequestDidStart(
            request: loggerRequest
        )
    }
    
    @objc private func networkRequestDidComplete(notification: Notification) {
        guard
            let sessionDelegate = notification.object as? SessionDelegate,
            let task = notification.userInfo?[Notification.Key.Task] as? URLSessionTask
        else {
            delegate?.loggingFailed(error: .responseParsingFailed)
            
            return
        }
        
        guard let loggerRequest = task.originalRequest?.alamofireLoggerRequest else {
            delegate?.loggingFailed(error: .requestParsingFailed)
            
            return
        }
        
        if let error = task.error {
            delegate?.networkRequestDidComplete(
                request: loggerRequest,
                result: .failure(error)
            )
            
            return
        }
        
        guard
            let response = task.response as? HTTPURLResponse,
            let responseHeaders = response.allHeaderFields as? [String: String]
        else {
            delegate?.loggingFailed(error: .responseParsingFailed)
            
            return
        }
        
        var body: String?
        
        if let httpBody = sessionDelegate[task]?.delegate.data {
            body = String(data: httpBody, encoding: .utf8)
        }
        
        delegate?.networkRequestDidComplete(
            request: loggerRequest,
            result: .success(
                AlamofireLoggerResponse(
                    httpURLResponse: response,
                    statusCode: response.statusCode,
                    headers: responseHeaders,
                    body: body
                )
            )
        )
    }
}
