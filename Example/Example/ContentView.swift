//
//  ContentView.swift
//  Example
//
//  Created by Jan Kaltoun on 02/05/2020.
//  Copyright © 2020 Jan Kaltoun. All rights reserved.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    var body: some View {
        Text("AlamofireEasyLogger example")
            .onAppear {
                self.request()
            }
    }
    
    func request() {
        AF.request(
            "https://httpbin.org/post",
            method: .post,
            parameters: ["some": "parameter"],
            encoder: JSONParameterEncoder.default
        ).response { _ in
            print("Done!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
