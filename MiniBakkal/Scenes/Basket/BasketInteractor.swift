//
//  BasketInteractor.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 3.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation

final class BasketInteractor : BasketInteractorProtocol{
    var delegate: BasketInteractorDelegate?
    private var basket: ChekoutReq = ChekoutReq(products: [])
    private let service: APIClientProtocol
    
    init(service: APIClientProtocol) {
        self.service = service
    }
    
    func showBasket() {
    }
}
