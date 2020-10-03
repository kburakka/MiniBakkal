//
//  GroseryListViewController.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

class GroseryListViewController: UIViewController {
    
    fileprivate let collectionView:UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UINib.init(nibName: "GroseryCell", bundle: nil), forCellWithReuseIdentifier: "GroseryCell")
        return cv
    }()
    
    var presenter : GroseryListPresenterProtocol!
    private var products: [Product] = []
    private var selectedProducts: [Product] = []{
        didSet{
            cartBtn.setBadge(with: selectedProducts.count)
        }
    }

    let cartBtn = BadgedButtonItem(with: UIImage(systemName: "cart"))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        presenter.showProducts()
        
        cartBtn.delegate = self
        self.navigationItem.rightBarButtonItem = cartBtn
    }
    
    func setCollectionView(){
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

extension GroseryListViewController:GroseryListViewProtocol{
    func handleOutput(_ output: GroseryListPresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading{
                LoadingView.init(view: view).startAnimation()
            }else{
                LoadingView.init(view: view).stopAnimation()
            }
        case .showProducts(let products):
            self.products = products
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .showError(let error):
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
    }
}

extension GroseryListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroseryCell", for: indexPath) as! GroseryCell
        if products.count > indexPath.item{
            cell.configure(product: products[indexPath.item])
            cell.delegate = self
        }
        return cell
    }
}

extension GroseryListViewController: GroseryCellProtocol{
    func productAdded(product: Product) {
        selectedProducts.append(product)
    }
    
    func productDeleted(product: Product) {
        selectedProducts = selectedProducts.filter { $0.id != product.id }
    }
}

extension GroseryListViewController: BadgedButtonProtocol{
    func cartOnPressed() {
        presenter.checkOut(products: selectedProducts)
    }
}
