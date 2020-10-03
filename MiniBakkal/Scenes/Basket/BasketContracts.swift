//
//  BasketContracts.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 3.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

// MARK: - Interactor
protocol BasketInteractorProtocol: class {
    var delegate: BasketInteractorDelegate? { get set }
    func showBasket()
}

enum BasketInteractorOutput {
    case setLoading(Bool)
    case showBasket(ChekoutReq)
    case showError(Error)
}

protocol BasketInteractorDelegate: class {
    func handleOutput(_ output: BasketInteractorOutput)
}


// MARK: - Presenter
protocol BasketPresenterProtocol: class {
    func showBasket()
}

enum BasketPresenterOutput {
    case setLoading(Bool)
    case showBasket(ChekoutReq)
    case showError(Error)
}


// MARK: - View
protocol BasketViewProtocol: class {
    func handleOutput(_ output: BasketPresenterOutput)
}


// MARK: - Router
enum EBasketRouter{
}

protocol BasketRouterProtocol: class {
    func navigate(to route: EBasketRouter)
}
