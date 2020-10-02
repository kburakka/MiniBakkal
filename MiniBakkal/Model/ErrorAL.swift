//
//  ErrorAL.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation

public struct ErrorAL:Decodable {
    
    public enum CodingKeys: String, CodingKey {
        case error = "error"
    }
    
    public let error: String?
}
