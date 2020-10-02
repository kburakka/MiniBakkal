//
//  CheckoutRes.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation

public struct CheckoutRes:Decodable, Equatable {
    
    public enum CodingKeys: String, CodingKey {
        case orderID = "orderID"
        case message = "message"
    }
    
    public let orderID: String?
    public let message: String?
}
