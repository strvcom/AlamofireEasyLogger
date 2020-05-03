//
//  FancyAppAlamofireLogger.swift
//  AlamofireEasyLogger
//
//  Created by Jan Kaltoun on 01/12/2018.
//  Copyright © 2018 Jan Kaltoun. All rights reserved.
//

open class FancyAppAlamofireLogger: AlamofireLoggerDelegate {
    
    public typealias LogFunction = (String) -> Void
    
    let alamofireLogger = AlamofireLogger()
    let logFunction: LogFunction
    
    public init(logFunction: @escaping LogFunction) {
        self.logFunction = logFunction
        
        alamofireLogger.delegate = self
        alamofireLogger.startLogging()
    }
    
    open func networkRequestDidStart(request: AlamofireLoggerRequest) {
        var message = [String]()
        
        let divider = "🚀🚀🚀 REQUEST 🚀🚀🚀"
        
        message.append(divider)
        message.append("🔈 \(request.method) \(request.url.absoluteString)")
        
        request.headers?
            .map({ "💡 \($0): \($1)" })
            .forEach { message.append($0) }
        
        if let body = request.body {
            message.append(body)
        }
        
        message.append(divider)
        
        logFunction(message.joined(separator: "\n"))
    }
    
    open func networkRequestDidComplete(request: AlamofireLoggerRequest, result: AlamofireLoggerResult) {
        var message = [String]()
        
        if case let .failure(error) = result {
            let divider = "🛑🛑🛑 REQUEST ERROR 🛑🛑🛑"
            
            message.append(divider)
            message.append("🔈 \(request.method) \(request.url.absoluteString)")
            message.append("\(error)")
            message.append(divider)
        }
        
        if case let .success(response) = result {
            let divider = 200...299 ~= response.statusCode ?
                "✅✅✅ SUCCESS RESPONSE ✅✅✅" :
                "❌❌❌ ERROR RESPONSE ❌❌❌"
            
            message.append(divider)
            message.append("🔈 \(request.method) \(request.url.absoluteString)")
            message.append("🔈 Status code: \(response.statusCode)")
            
            response.headers
                .map({ "💡 \($0): \($1)" })
                .forEach { message.append($0) }
            
            if let body = response.body {
                message.append(body)
            }
            
            message.append(divider)
        }
        
        logFunction(message.joined(separator: "\n"))
    }
    
    open func loggingFailed(error: AlamofireLoggingError) {
        logFunction("\(error)")
    }
}
