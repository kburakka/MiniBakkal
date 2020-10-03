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
    
    func confirmCard(products: [Product]) {
        let groupedItems = Dictionary(grouping: products, by: {$0.id!})
        var prods : [Prod] = []
        for index in groupedItems{
            prods.append(Prod(id: index.key, amount: index.value.count))
        }
        
        let checkoutReq = ChekoutReq(products: prods)
        delegate?.handleOutput(.setLoading(true))
        service.checkout(chekoutReq: checkoutReq) { (result) in
            self.delegate?.handleOutput(.setLoading(false))
            switch result {
            case .success(let checkoutRes):
                self.delegate?.handleOutput(.confirmCard(checkoutRes))
            case .failure(let error):
                self.delegate?.handleOutput(.showError(error))
            }
        }
    }
}
