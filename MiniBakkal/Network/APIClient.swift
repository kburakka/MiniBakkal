//
//  APIClient.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import Alamofire

public protocol APIClientProtocol {
    func fetchGroserylist(completion:@escaping (Result<[Product], AFError>)->Void)
    func checkout(chekoutReq: ChekoutReq,completion:@escaping (Result<CheckoutRes, AFError>)->Void)
}

class APIClient: APIClientProtocol {
    func fetchGroserylist(completion: @escaping (Result<[Product], AFError>) -> Void) {
        APIClient.performRequest(route: APIRouter.groseryList) { (result) in
            completion(result)
        }
    }
    
    func checkout(chekoutReq: ChekoutReq, completion: @escaping (Result<CheckoutRes, AFError>) -> Void) {
        APIClient.performRequest(route: APIRouter.checkout(checkoutReq: chekoutReq)) { (result) in
            completion(result)
        }
    }
    
    @discardableResult
    public static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
            completion(response.result)
        }
    }
}
