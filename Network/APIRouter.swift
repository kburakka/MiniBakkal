//
//  APIRouter.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case checkout
    case groseryList

    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .checkout:
            return .post
        case .groseryList:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .checkout:
            return "checkout"
        case .groseryList:
            return "list"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlString = ProductionServer.baseUrl + path
        print(urlString)
        let url = try urlString.asURL()
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        return urlRequest
    }
}
