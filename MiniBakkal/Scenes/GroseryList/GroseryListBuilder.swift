//
//  GroseryListBuilder.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

final class GroseryListBuilder {
    static func make() -> GroseryListViewController {
        let storyboard = UIStoryboard(name: "GroseryList", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "GroseryListViewController") as! GroseryListViewController
        let router = GroseryListRouter(view: view)
        let interactor = GroseryListInteractor(service: app.service)
        let presenter = GroseryListPresenter(view: view,
                                           interactor: interactor,
                                           router: router)
        view.presenter = presenter
        return view
    }
}
