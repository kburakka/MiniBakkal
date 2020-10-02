//
//  Product.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation

public struct Product:Decodable, Equatable {
    
    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case currency = "currency"
        case imageUrl = "imageUrl"
        case stock = "stock"
    }
    
    public let id: String?
    public let name: String?
    public let price: Double?
    public let currency: String?
    public let imageUrl: String?
    public let stock: Int?
}
