# AlamofireEasyLogger

[![Version](https://img.shields.io/cocoapods/v/AlamofireEasyLogger.svg?style=flat)](https://cocoapods.org/pods/AlamofireEasyLogger)
[![License](https://img.shields.io/cocoapods/l/AlamofireEasyLogger.svg?style=flat)](https://cocoapods.org/pods/AlamofireEasyLogger)
[![Platform](https://img.shields.io/cocoapods/p/AlamofireEasyLogger.svg?style=flat)](https://cocoapods.org/pods/AlamofireEasyLogger)

*AlamofireEasyLogger* is an easy drop-in Alamofire request & response logger. No configuration is needed, it just works.

It works for all requests and responses. There is no need to call a function on every request. It provides a full request/response logger out of the box and allows for easy overriding in case you have different requirements for what you want to see.

## Requirements

- iOS 10.0+
- Swift 5.0+

**For Swift 4.2 please use pod version 1.0.0.**
**For Alamofire 4.6 please use pod version 1.1.0.**

## Dependencies

- [Alamofire 5+](https://github.com/Alamofire/Alamofire)

## Installation

### Swift Package Manager

Simply add URL of this repository into your package dependencies:

```
https://github.com/jankaltoun/AlamofireEasyLogger
```

### Cocoapods

To install this library using Cocoapods, simply add the following line to your Podfile

```ruby
pod 'AlamofireEasyLogger'
```

### Carthage

To integrate this library using Carthage, add the following line to your Cartfile.

```ruby
github "jankaltoun/AlamofireEasyLogger"
```

## Usage

Out of the box AlamofireEasyLogger provides the `FancyAppAlamofireLogger` class that logs request and responses with their parameters, headers and bodies as in the example below.

This works for both successful and unsuccessful requests/responses and the output is nicely formatted.

### FancyAppAlamofireLogger log example
```
🚀🚀🚀 REQUEST 🚀🚀🚀
🔈 GET https://api.openweathermap.org/data/2.5/forecast?lat=-26.2041028&lon=28.0473051&APPID=hidden&units=metric
🚀🚀🚀 REQUEST 🚀🚀🚀

✅✅✅ SUCCESS RESPONSE ✅✅✅
🔈 GET https://api.openweathermap.org/data/2.5/weather?lat=-26.2041028&lon=28.0473051&APPID=hidden&units=metric
🔈 Status code: 200
💡 Access-Control-Allow-Methods: GET, POST
💡 X-Cache-Key: /data/2.5/weather?APPID=hidden&lat=-26.2&lon=28.05&units=metric
💡 Server: openresty
💡 Content-Length: 441
💡 Date: Sat, 12 Jan 2019 16:30:50 GMT
💡 Content-Type: application/json; charset=utf-8
💡 Access-Control-Allow-Origin: *
💡 Access-Control-Allow-Credentials: true
💡 Connection: keep-alive
{"coord":{"lon":28.05,"lat":-26.2},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"base":"stations","main":{"temp":29.53,"pressure":1015,"humidity":37,"temp_min":29,"temp_max":30},"wind":{"speed":0.5,"deg":310},"rain":{"3h":0.575},"clouds":{"all":32},"dt":1547308800,"sys":{"type":1,"id":1958,"message":0.0103,"country":"ZA","sunrise":1547263628,"sunset":1547312706},"id":993800,"name":"Johannesburg","cod":200}
✅✅✅ SUCCESS RESPONSE ✅✅✅
```

### Usage in app

You need to hold a reference to your logger instance. The place to do this might be your `AppDelegate` or any other place where the reference will stay alive.

```
import UIKit
import AlamofireEasyLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let alamofireLogger = FancyAppAlamofireLogger(prettyPrint: true) {
        print($0)
    }
    
    ...
}
```

As you can see above the only parameter the logger takes during initialization is `logFunction` closure defined as `public typealias LogFunction = (String) -> Void`.
This function is responsible for logging the requests and responses.
You can use a simple `print` as in the example above or integrate a logging library of your choice.

### Implementing your own logger

If the `FancyAppAlamofireLogger` is too verbose for your taste or you want to implement a completely custom logger you can use the `AlamofireLoggerDelegate` of `AlamofireEasyLogger`.

Your logger should be used exactly like the `FancyAppAlamofireLogger` in the example above and should look similar to following piece of code.

```
class FancyAppAlamofireLogger: AlamofireLoggerDelegate {
    
    let alamofireLogger = AlamofireLogger()
    
    public init() {
        alamofireLogger.delegate = self
        alamofireLogger.startLogging()
    }
    
    open func networkRequestDidStart(request: AlamofireLoggerRequest) {
        ...
    }
    
    open func networkRequestDidComplete(request: AlamofireLoggerRequest, result: AlamofireLoggerResult) {
        ...
    }
    
    open func loggingFailed(error: AlamofireLoggingError) {
        ...
    }
}
```

As you can see on this example `AlamofireEasyLogger` is quite versatile and with the use of `AlamofireLoggerDelegate` you're able to develop a completely custom logger while leveraging the `AlamofireLoggerRequest`, `AlamofireLoggerResult` and `AlamofireLoggingError` entities provided to you.

## Author

Jan Kaltoun, jan.kaltoun@me.com

## License

Please do whatever you want with this code.

If you link to this repository or mention me as the author, it will make me happy!
