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
            updateGroupedItems()
        }
    }
    var groupedItems : [String : [Product]?] = [:]{
        didSet{
            if Array(oldValue.keys).count != Array(groupedItems.keys).count{
                if tableView != nil{
                    tableView.reloadData()
                }
            }
        }
    }

    @IBOutlet weak var totalPrice: UILabel!{
        didSet{
            updateTotalPrice()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupedItems = Dictionary(grouping: selectedProducts, by: {$0.id!})
        
        setNavigationItems()
    }
    
    func setNavigationItems(){
    
        let deleteBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        deleteBtn.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 16)
        deleteBtn.setTitle("Sil", for: .normal)
        deleteBtn.titleLabel?.textAlignment = .center
        deleteBtn.setTitleColor(.red, for: .normal)
        deleteBtn.backgroundColor = .clear
        deleteBtn.addTarget(self, action: #selector(deleteAllProducts), for: .touchUpInside)
        let barDeleteBtn = UIBarButtonItem(customView: deleteBtn)

        self.navigationItem.leftBarButtonItem = barDeleteBtn
        
        let closeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        closeBtn.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 16)
        closeBtn.setTitle("Kapat", for: .normal)
        closeBtn.titleLabel?.textAlignment = .center
        closeBtn.setTitleColor(.systemBlue, for: .normal)
        closeBtn.backgroundColor = .clear
        closeBtn.addTarget(self, action: #selector(closeBasket), for: .touchUpInside)
        let barCloseBtn = UIBarButtonItem(customView: closeBtn)

        self.navigationItem.rightBarButtonItem = barCloseBtn
    }
    
    @objc func deleteAllProducts(){
        selectedProducts.removeAll()
    }
    
    @objc func closeBasket(){
        presenter.closeBasket(products: selectedProducts)
    }
    
    func updateTotalPrice(){
        if totalPrice != nil{
            totalPrice.text = "\(selectedProducts.map({$0.price ?? 0.0}).reduce(0.0, +))"
        }
    }
    
    func updateGroupedItems(){
        groupedItems = Dictionary(grouping: selectedProducts, by: {$0.id!})
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
        updateGroupedItems()
    }
    
    func productDeleted(product: Product) {
        if let index = selectedProducts.firstIndex(where: {$0.id == product.id}){
            selectedProducts.remove(at: index)
        }
        updateGroupedItems()
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
