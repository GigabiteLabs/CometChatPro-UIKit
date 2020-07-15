//
//  APIEndpointClasses.swift
//  
//
//  Created by GigabiteLabs 
//  Copyright © 2019 GigabiteLabs. All rights reserved.
//

import Foundation
import SwiftyJSON

// Base class for all endpoint classes
public class PushEndpoint {
    internal var serverBaseURL: String
    public init(config: CCPConfig) {
        self.serverBaseURL = config.firebaseURL
    }
    // All API Supported Methods
    enum HTTPMethod: String {
        case POST, GET, DELETE, UPDATE, PATCH
    }
    
    private func sendAPIRequest(request: URLRequest, completion: @escaping (PushResponse?)->Void){
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("APIRequest failed: \(error.debugDescription)")
                completion(nil)
                return
            }
            let json = JSON(data)
            #if DEBUG
            print("response: \(String(describing: response))")
            print("json: \(json.rawString() ?? "")")
            #endif
            completion(PushResponse(json: json))
        }
        task.resume()
    }
    
    func sendRequest(url: String, method: HTTPMethod, body: String?, customHeaders: Dictionary<String,String>?, completion: @escaping (PushResponse?)-> Void){
        #if DEBUG
        print("sending push with url: \(url)")
        #endif
        let escapedString = url.replacingOccurrences(of: " ", with: "%20")
        // Make URL
        guard let url = URL(string: escapedString) else{
            print("URL() could not be created!")
            completion(nil)
            return
        }
        
        // Make URLRequest
        var request = URLRequest(url: url)
        
        // Add the method
        request.httpMethod = method.rawValue
        
        // Add the body if it was passed
        if let bodyContent = body{
            //print("body: \(bodyContent)")
            request.httpBody = bodyContent.data(using: .ascii)
        }
        
        
        // Add any custom headers
        if let headers = customHeaders{
            for field in headers{
                //print("header: \(field)")
                request.setValue(field.value, forHTTPHeaderField: field.key)
            }
            
            //print("\(request)",.info)
            // Send with custom headers
            self.sendAPIRequest(request: request) { (PushResponse) in
                completion(PushResponse)
            }
        }else{
            print("\(request.debugDescription)")
            // Send with custom headers
            self.sendAPIRequest(request: request) { (PushResponse) in
                completion(PushResponse)
            }
        }
    }
}
