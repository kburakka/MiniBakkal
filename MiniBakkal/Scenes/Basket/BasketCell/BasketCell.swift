//
//  BasketCell.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 3.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit
import SDWebImage

protocol BasketCellProtocol: class {
    func productAdded(product : Product)
    func productDeleted(product : Product)
}

class BasketCell: UITableViewCell {

    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    var delegate: BasketCellProtocol?
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    var product : Product? = nil
    var stock : Int?

    var counter = 0{
        didSet{
            if counter == 0{
                deleteBtn.isEnabled = false
            }else{
                deleteBtn.isEnabled = true
            }
            if counter == stock{
                addBtn.isEnabled = false
            }else{
                addBtn.isEnabled = true
            }
            count.text = "\(counter)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func productDeleted(_ sender: Any) {
        counter -= 1
        if let product = product{
            delegate?.productDeleted(product: product)
        }
    }
    
    @IBAction func productAdded(_ sender: Any) {
        counter += 1
        if let product = product{
            delegate?.productAdded(product: product)
        }
    }
    
    func configure(product : Product, amount : Int){
        self.product = product
        name.text = product.name
        stock = product.stock
        counter = amount
        
        if let priceStr = product.price{
            price.text = "\(priceStr)"
        }
        
        if let thumbnailUrl = product.imageUrl{
            let url = URL(string: thumbnailUrl)
            productImage?.sd_setImage(with: url, placeholderImage: UIImage(named: "apploogist"), options: SDWebImageOptions.highPriority, completed: nil)
        }
    }
}
