//
//  CheckoutReq.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation

// MARK: - ChekoutReq
public struct ChekoutReq: Encodable {
    let products: [Prod]
}

// MARK: - Product
struct Prod: Codable {
    let id: String
    let amount: Int
}
