//
//  BasketBuilder.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 3.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

final class BasketBuilder {
    static func make(with products : [Product]) -> BasketViewController {
        let storyboard = UIStoryboard(name: "Basket", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "BasketViewController") as! BasketViewController
        view.products = products
        let router = BasketRouter(view: view)
        let interactor = BasketInteractor(service: app.service)
        let presenter = BasketPresenter(view: view,
                                           interactor: interactor,
                                           router: router)
        view.presenter = presenter
        return view
    }
}
