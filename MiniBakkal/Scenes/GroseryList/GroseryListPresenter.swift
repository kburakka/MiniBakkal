//
//  GroseryListPresenter.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

final class GroseryListPresenter:GroseryListPresenterProtocol{

    private unowned let view: GroseryListViewProtocol
    private let interactor: GroseryListInteractorProtocol
    private let router: GroseryListRouterProtocol

    init(view: GroseryListViewProtocol,
          interactor: GroseryListInteractorProtocol,
          router: GroseryListRouterProtocol) {
         self.view = view
         self.interactor = interactor
         self.router = router
         
         self.interactor.delegate = self
    }
    
    func showProducts() {
        interactor.showGroseryList()
    }
}

extension GroseryListPresenter: GroseryListInteractorDelegate{
    func handleOutput(_ output: GroseryListInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showGroseryList(let products):
            view.handleOutput(.showProducts(products))
        case .showError(let error):
            view.handleOutput(.showError(error))
        }
    }
}
