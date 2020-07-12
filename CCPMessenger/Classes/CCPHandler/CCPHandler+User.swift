// CCPHandler+User.swift
//
// Created by GigabiteLabs on 7/11/20
// Swift Version: 5.0
// Copyright © 2020 GigabiteLabs. All rights reserved.
//

import Foundation

public extension CCPHandler {
    func createUser(_ user: CCPUser, immediateLogin: Bool?, completion: @escaping (Bool)->Void){
        // setup the URLSession
        let urlSessionConfig = URLSessionConfiguration.default
        urlSessionConfig.httpAdditionalHeaders = [
            "Accept" : "application/json",
            "Content-Type" : "application/x-www-form-urlencoded",
            "appid" : CCPConfig.shared.appId,
            "apikey" : CCPConfig.shared.apiKey
        ]
        let session = URLSession(configuration: urlSessionConfig)
        var request = URLRequest(url: URL(string:  CCPConfig.shared.url)!)
        request.encodeParameters(parameters: ["uid" : user.uid, "name" : "\(user.firstname) \(user.lastname)"])
        // create URLSession task
        let task = session.dataTask(with: request) { data, response, error in
            // handle any error response
            if let error = error {
                print("error attempting creating new CometChat user: \(error)")
                if let response = response {
                    print("CometChat response: \(response)")
                }
                completion(false)
                return
            }
            // unwrap response to check outcome
            if let data = data {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    do {
                      let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSMutableDictionary
                        print("\nnew CometChat user successfully created, response:\n\(json)\n")
                        // check if immediate login option was true
                        guard let immediateLogin = immediateLogin, immediateLogin == true else {
                            print("attempting to login new CometChat user")
                            completion(true)
                            return
                        }
                        print("attempting immediate login of new CometChat user")
                        // if immediate login selected, proceed
                        self.login(user: user) { (success) in
                            completion(success)
                        }
                    } catch {
                        print("error decoding response JSON: \(error)")
                        completion(false)
                    }
                } else {
                    print("error: \(String(describing: error))")
                    completion(false)
                }
            } else {
                print("error: no data returned from CometChat")
                completion(false)
            }
        }
        task.resume()
    }
}
