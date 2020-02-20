//
//  CategoriesTableViewCell.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 05/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    
    var imageCategory : UIImageView = {
        let im = UIImageView()
        im.layer.cornerRadius = CGFloat.heigthComponent/2
        im.image = UIImage(named: "?")
        return im
    }()
    let labelCategory : UILabel = {
        let label = UILabel()
        label.setBasicLabel(text: "Categoria", textColor: UIColor.backgroundColorGray4,
                            font: 18, backgroundColor: .clear, textAlignment: .left)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        contentView.addSubviews(viewsToAdd: imageCategory, labelCategory)
        
        imageCategory.snp.makeConstraints { (make) in
            make.height.width.equalTo(CGFloat.heigthComponent)
            make.left.equalToSuperview().offset(CGFloat.margin)
            make.centerY.equalToSuperview()
        }
        labelCategory.snp.makeConstraints { (make) in
            make.left.equalTo(imageCategory.snp.right).offset(20)
            make.centerY.equalTo(imageCategory)
        }
    }

}
