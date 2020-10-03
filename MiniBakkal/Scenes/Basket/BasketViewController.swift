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
    public var selectedProducts : [Product] = []{
        didSet{
            updateTotalPrice()
        }
    }
    var groupedItems : [String : [Product]?] = [:]

    @IBOutlet weak var totalPrice: UILabel!{
        didSet{
            updateTotalPrice()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupedItems = Dictionary(grouping: selectedProducts, by: {$0.id!})
    }
    
    func updateTotalPrice(){
        if totalPrice != nil{
            totalPrice.text = "\(selectedProducts.map({$0.price ?? 0.0}).reduce(0.0, +))"
        }
    }
    @IBAction func confirmCart(_ sender: Any) {
    }
}

extension BasketViewController: BasketViewProtocol{
    func handleOutput(_ output: BasketPresenterOutput) {
        
    }
}

extension BasketViewController: BasketCellProtocol{
    func productAdded(product: Product) {
        selectedProducts.append(product)
        groupedItems = Dictionary(grouping: selectedProducts, by: {$0.id!})
    }
    
    func productDeleted(product: Product) {
        selectedProducts = selectedProducts.filter { $0.id != product.id }
        groupedItems = Dictionary(grouping: selectedProducts, by: {$0.id!})
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("BasketCell", owner: self, options: nil)?.first as! BasketCell

        cell.delegate = self
        
        if let products = Array(groupedItems.values)[indexPath.row]{
            if let product = products.first{
                cell.configure(product: product, amount: products.count)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
