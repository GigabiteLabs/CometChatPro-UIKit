//
//  APIResponse.swift
//  
//
//  Created by GigabiteLabs 
//  Copyright © 2019 GigabiteLabs. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PushResponse: Codable {
    public var message: String
    public var statusCode: Int
    public var error: Bool
    public var data: [String: JSON]
    
    init(json: JSON){
        self.message = json["message"].stringValue
        self.statusCode = json["statusCode"].intValue
        self.error = json["error"].boolValue
        self.data = json["data"].dictionaryValue
    }
}
