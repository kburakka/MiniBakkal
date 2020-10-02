//
//  GroseryListContracts.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

// MARK: - Interactor
protocol GroseryListInteractorProtocol: class {
    var delegate: GroseryListInteractorDelegate? { get set }
    func showGroseryList()
}

enum GroseryListInteractorOutput {
    case setLoading(Bool)
    case showGroseryList([Product])
    case showError(Error)
}

protocol GroseryListInteractorDelegate: class {
    func handleOutput(_ output: GroseryListInteractorOutput)
}


// MARK: - Presenter
protocol GroseryListPresenterProtocol: class {
    func showProducts()
}

enum GroseryListPresenterOutput {
    case setLoading(Bool)
    case showProducts([Product])
    case showError(Error)
}


// MARK: - View
protocol GroseryListViewProtocol: class {
    func handleOutput(_ output: GroseryListPresenterOutput)
}


// MARK: - Router
enum EGroseryListRouter{
    case checkOut([Product])
}

protocol GroseryListRouterProtocol: class {
    func navigate(to route: EGroseryListRouter)
}
