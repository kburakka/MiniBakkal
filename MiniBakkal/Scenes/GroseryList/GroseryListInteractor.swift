//
//  GroseryListInteractor.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import UIKit

final class GroseryListInteractor : GroseryListInteractorProtocol{

    var delegate: GroseryListInteractorDelegate?
    private var products: [Product] = []
    private let service: APIClientProtocol
    
    init(service: APIClientProtocol) {
        self.service = service
    }
    
    func showGroseryList() {
        delegate?.handleOutput(.setLoading(true))
        service.fetchGroserylist { (result) in
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let products):
                self.products = products
                self.delegate?.handleOutput(.showGroseryList(products))
            case .failure(let error):
                self.delegate?.handleOutput(.showError(error))
            }
        }
    }
}
