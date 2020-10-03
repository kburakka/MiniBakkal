//
//  GroseryListRouter.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Foundation
import UIKit

final class GroseryListRouter : GroseryListRouterProtocol{
    unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: EGroseryListRouter) {
        switch route {
        case .checkOut(let products):
            let commentsView = BasketBuilder.make(with: products)
            commentsView.selectedProductsdelegate = view.self as? GroseryListViewController
            view.show(commentsView, sender: nil)
        }
    }
}
