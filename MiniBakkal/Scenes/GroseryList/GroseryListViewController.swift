//
//  GroseryListViewController.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit

class GroseryListViewController: UIViewController, GroseryListViewProtocol {
    
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
    
    let cartBtn = BadgedButtonItem(with: UIImage(systemName: "cart"))
    var totalCounter = 0{
        didSet{
            cartBtn.setBadge(with: totalCounter)
        }
    }
    
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
    
    func handleOutput(_ output: GroseryListPresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            print("loading")
        case .showProducts(let products):
            self.products = products
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .showError(let error):
            print("error")
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
    func productAdded() {
        totalCounter += 1
    }
    
    func productDeleted() {
        totalCounter -= 1
    }
}

extension GroseryListViewController: BadgedButtonProtocol{
    func cartOnPressed() {
        print("basildi")
    }
}
