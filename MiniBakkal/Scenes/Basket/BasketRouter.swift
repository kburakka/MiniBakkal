//
//  BasketRouter.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 3.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

final class BasketRouter : BasketRouterProtocol{
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: EBasketRouter) {
        switch route {
        case .closeBasket:
            if let view = view.navigationController {
                view.popViewController(animated: true)
            }
        }
    }
}
