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
    let emojiCount: Int
    
    public init(logFunction: @escaping LogFunction, emojiCount: Int = 3) {
        self.logFunction = logFunction
        self.emojiCount = emojiCount
        
        alamofireLogger.delegate = self
        alamofireLogger.startLogging()
    }
    
    open func networkRequestDidStart(request: AlamofireLoggerRequest) {
        var message = [String]()
        
        let divider = emojionalText("REQUEST", symbol: "🚀")
        
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
            let divider = emojionalText("REQUEST ERROR", symbol: "🛑")
            
            message.append(divider)
            message.append("🔈 \(request.method) \(request.url.absoluteString)")
            message.append("\(error)")
            message.append(divider)
        }
        
        if case let .success(response) = result {
            let divider = 200...299 ~= response.statusCode ?
                emojionalText("SUCCESS RESPONSE", symbol: "✅") :
                emojionalText("ERROR RESPONSE", symbol: "❌")
            
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

private extension FancyAppAlamofireLogger {
    func emoji(_ symbol: String) -> String {
        [String].init(repeating: symbol, count: emojiCount).reduce("", +)
    }
    
    func emojionalText(_ text: String, symbol: String) -> String {
        "\(emoji(symbol)) \(text) \(emoji(symbol))"
    }
}
