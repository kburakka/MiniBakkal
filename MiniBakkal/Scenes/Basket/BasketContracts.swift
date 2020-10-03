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
    func confirmCard(products : [Product])
}

enum BasketInteractorOutput {
    case setLoading(Bool)
    case confirmCard(CheckoutRes)
    case showError(Error)
}

protocol BasketInteractorDelegate: class {
    func handleOutput(_ output: BasketInteractorOutput)
}


// MARK: - Presenter
protocol BasketPresenterProtocol: class {
    func closeBasket()
    func confirmCard(products : [Product])
}

enum BasketPresenterOutput {
    case setLoading(Bool)
    case confirmCard(CheckoutRes)
    case showError(Error)
}


// MARK: - View
protocol BasketViewProtocol: class {
    func handleOutput(_ output: BasketPresenterOutput)
}


// MARK: - Router
enum EBasketRouter{
    case closeBasket
}

protocol BasketRouterProtocol: class {
    func navigate(to route: EBasketRouter)
}
