//
//  GroseryListViewController.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

class GroseryListViewController: UIViewController, GroseryListViewProtocol {

    

    var presenter : GroseryListPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showProducts()
        // Do any additional setup after loading the view.
    }
    
    func handleOutput(_ output: GroseryListPresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            print("loading")
        case .showProducts(let product):
            print(product)
        case .showError(let error):
            print("error")
        }
    }
}
