//
//  BasketViewController.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 3.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {

    var presenter : BasketPresenterProtocol!
    private var basket: ChekoutReq = ChekoutReq(products: [])
    public var selectedProducts : [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedProducts)
    }
}

extension BasketViewController: BasketViewProtocol{
    func handleOutput(_ output: BasketPresenterOutput) {
        
    }
}
