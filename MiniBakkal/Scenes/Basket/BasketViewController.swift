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
    var selectedProductsdelegate: SelectedProductsProtocol?
    private var basket: ChekoutReq = ChekoutReq(products: [])

    var checkoutRes: CheckoutRes?{
        didSet{
            showAlert(title: "UYARI", message: checkoutRes?.message, completionHandler: { (bool) -> Void in
                self.selectedProducts.removeAll()
                self.selectedProductsdelegate?.passSelectedProducts(products: self.selectedProducts)
                self.presenter.closeBasket()
            })
        }
    }
    
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
                    showEmptyMessage()
                }
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!{
        didSet{
            updateTotalPrice()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupedItems = Dictionary(grouping: selectedProducts, by: {$0.id!})
        tableView.accessibilityIdentifier = "TableView"
        setNavigationItems()
    }

    func showEmptyMessage(){
        if selectedProducts.count == 0{
            tableView.showMessage(message: "Sepetinizde ürün bulunmamaktadır. ", containerView: tableView)
        }else{
            tableView.hideMessage()
        }
    }

    func setNavigationItems(){
        
        let deleteBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        deleteBtn.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 16)
        deleteBtn.setTitle("Sil", for: .normal)
        deleteBtn.titleLabel?.textAlignment = .center
        deleteBtn.setTitleColor(.red, for: .normal)
        deleteBtn.backgroundColor = .clear
        deleteBtn.accessibilityIdentifier = "DeleteAll"
        deleteBtn.addTarget(self, action: #selector(deleteAllProducts), for: .touchUpInside)
        let barDeleteBtn = UIBarButtonItem(customView: deleteBtn)
        
        self.navigationItem.leftBarButtonItem = barDeleteBtn
        
        let closeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        closeBtn.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 16)
        closeBtn.setTitle("Kapat", for: .normal)
        closeBtn.titleLabel?.textAlignment = .center
        closeBtn.setTitleColor(.systemBlue, for: .normal)
        closeBtn.backgroundColor = .clear
        closeBtn.accessibilityIdentifier = "Close"
        closeBtn.addTarget(self, action: #selector(closeBasket), for: .touchUpInside)
        let barCloseBtn = UIBarButtonItem(customView: closeBtn)
        
        self.navigationItem.rightBarButtonItem = barCloseBtn
    }
    
    @objc func deleteAllProducts(){
        showDeleteAlert(title: "UYARI", message: "Sepetinizi boşaltmak istediğinize emin misiniz?", completionHandler: { (bool) -> Void in
            if bool{
                self.selectedProducts.removeAll()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Sepet"
        showEmptyMessage()
    }
    
    
    @objc func closeBasket(){
        selectedProductsdelegate?.passSelectedProducts(products: selectedProducts)
        presenter.closeBasket()
    }
    
    func updateTotalPrice(){
        if totalPrice != nil{
            totalPrice.text = "\(selectedProducts.first?.currency ?? "")\(selectedProducts.map({$0.price ?? 0.0}).reduce(0.0, +))"
        }
    }
    
    func updateGroupedItems(){
        groupedItems = Dictionary(grouping: selectedProducts, by: {$0.id!})
    }
    
    
    @IBAction func confirmCard(_ sender: Any) {
        presenter.confirmCard(products: selectedProducts)
    }
}

extension BasketViewController : SelectedProductsProtocol{
    func passSelectedProducts(products: [Product]) {
        self.selectedProducts = products
    }
}

extension BasketViewController: BasketViewProtocol{
    func handleOutput(_ output: BasketPresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading{
                LoadingView.init(view: view).startAnimation()
            }else{
                LoadingView.init(view: view).stopAnimation()
            }
        case .showError(let error):
            self.showAlert(title: "Hata", message: error.localizedDescription, completionHandler: nil)
        case .confirmCard(let response):
            self.checkoutRes = response
        }
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
        return 90
    }
}
