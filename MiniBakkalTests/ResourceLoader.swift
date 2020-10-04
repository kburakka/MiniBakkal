//
//  ResourceLoader.swift
//  MiniBakkalTests
//
//  Created by Burak KAYA on 4.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
@testable import MiniBakkal

class ResourceLoader {
    static func loadGroseryList() throws -> [Product]?{
        if let path = Bundle.test.path(forResource: "GroseryList", ofType: "json"){
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let products = try decoder.decode([Product].self, from: data)
            return products
        }else{
            return nil
        }
    }
    static func loadCheckoutRes() throws -> CheckoutRes?{
        if let path = Bundle.test.path(forResource: "CheckoutRes", ofType: "json"){
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let checkoutRes = try decoder.decode(CheckoutRes.self, from: data)
            return checkoutRes
        }else{
            return nil
        }
    }
    static func loadSelectedProducts() throws -> [Product]?{
        if let path = Bundle.test.path(forResource: "SelectedProducts", ofType: "json"){
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let selectedProducts = try decoder.decode([Product].self, from: data)
            return selectedProducts
        }else{
            return nil
        }
    }
}

private extension Bundle {
    class Dummy { }
    static let test = Bundle(for: Dummy.self)
}
