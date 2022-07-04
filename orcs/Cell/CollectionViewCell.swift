//
//  CollectionViewCell.swift
//  orcs
//
//  Created by Mykyta Havrylenko on 02.07.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "CollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()


    }
    
    public func configure(with information: Equipment) {
        
        amountLabel.text = information.stringAmount
        titleLabel.text = information.title
        imageView.image = UIImage(named: information.image)
        backgroundImageView.image = UIImage(named: information.image)
        
        
    }
    
    static func nib() -> UINib {
         return UINib(nibName: "CollectionViewCell", bundle: nil)
    }

}

