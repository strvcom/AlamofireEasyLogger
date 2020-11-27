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
    
    let prettyPrint: Bool
    let logFunction: LogFunction
    let emojiCount: Int
    
    public init(prettyPrint: Bool, emojiCount: Int = 3, logFunction: @escaping LogFunction) {
        self.prettyPrint = prettyPrint
        self.emojiCount = emojiCount
        self.logFunction = logFunction
        
        alamofireLogger.delegate = self
        alamofireLogger.startLogging()
    }
    
    open func networkRequestDidStart(request: AlamofireLoggerRequest) {
        var message = [String]()
        
        message.append(
            emojionalText("REQUEST", symbol: "🚀")
        )
        message.append("🔈 \(request.method) \(request.url.absoluteString)")
        
        request.headers?
            .map({ "💡 \($0): \($1)" })
            .forEach { message.append($0) }
        
        let body = prettyPrint ? request.prettyPrintedBody : request.body
        
        if let body = body {
            message.append(body)
        }
        
        message.append(
            emojionalText("END REQUEST", symbol: "🔼")
        )
        
        logFunction(message.joined(separator: "\n"))
    }
    
    open func networkRequestDidComplete(request: AlamofireLoggerRequest, result: AlamofireLoggerResult) {
        var message = [String]()
        
        if case let .failure(error) = result {
            message.append(
                emojionalText("REQUEST ERROR", symbol: "🛑")
            )
            message.append("🔈 \(request.method) \(request.url.absoluteString)")
            message.append("\(error)")
            message.append(
                emojionalText("END REQUEST ERROR", symbol: "🔼")
            )
        }
        
        if case let .success(response) = result {
            let requestSuccessful = 200...299 ~= response.statusCode
            
            message.append(
                requestSuccessful ?
                    emojionalText("SUCCESS RESPONSE", symbol: "✅") :
                    emojionalText("ERROR RESPONSE", symbol: "❌")
            )
            message.append("🔈 \(request.method) \(request.url.absoluteString)")
            message.append("🔈 Status code: \(response.statusCode)")
            
            response.headers
                .map({ "💡 \($0): \($1)" })
                .forEach { message.append($0) }
            
            let body = prettyPrint ? response.prettyPrintedBody : response.body
            
            if let body = body {
                message.append(body)
            }
            
            message.append(
                emojionalText(
                    requestSuccessful ? "END SUCCESS RESPONSE" : "END ERROR RESPONSE",
                    symbol: "🔼"
                )
            )
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
