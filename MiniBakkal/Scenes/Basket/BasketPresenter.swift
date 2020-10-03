//
//  BasketPresenter.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 3.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

final class BasketPresenter:BasketPresenterProtocol{
    
    private unowned let view: BasketViewProtocol
    private let interactor: BasketInteractorProtocol
    private let router: BasketRouterProtocol

    init(view: BasketViewProtocol,
          interactor: BasketInteractorProtocol,
          router: BasketRouterProtocol) {
         self.view = view
         self.interactor = interactor
         self.router = router
         self.interactor.delegate = self
    }
    
    func showBasket() {
        
    }
}

extension BasketPresenter: BasketInteractorDelegate{
    func handleOutput(_ output: BasketInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showBasket(let basket):
            view.handleOutput(.showBasket(basket))
        case .showError(let error):
            view.handleOutput(.showError(error))
        }
    }
}
