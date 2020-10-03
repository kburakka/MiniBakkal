//
//  GroseryCell.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import UIKit
import SDWebImage

protocol GroseryCellProtocol: class {
    func productAdded()
    func productDeleted()
}

class GroseryCell: UICollectionViewCell {

    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    var delegate: GroseryCellProtocol?
    var stock : Int?
    
    var counter = 0{
        didSet{
            if counter == 0{
                count.isHidden = true
                deleteBtn.isHidden = true
            }else{
                count.isHidden = false
                deleteBtn.isHidden = false
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
    
    @IBAction func addProduct(_ sender: Any) {
        counter += 1
        delegate?.productAdded()
    }
    
    @IBAction func deleteProduct(_ sender: Any) {
        counter -= 1
        delegate?.productDeleted()
    }
    
    func configure(product : Product){
        name.text = product.name
        stock = product.stock
        
        if let priceStr = product.price{
            price.text = "\(priceStr)"
        }
        
        if let thumbnailUrl = product.imageUrl{
            let url = URL(string: thumbnailUrl)
            imageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "apploogist"), options: SDWebImageOptions.highPriority, completed: nil)

        }
    }
}
