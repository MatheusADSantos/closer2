//
//  CollectionViewCellInMap.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 03/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit
import SnapKit

class CollectionViewCellInMap: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    var pan: UIPanGestureRecognizer!
    
    let buttonCategorias : UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.layer.cornerRadius = (CGFloat.heigthComponent)/2
        image.layer.masksToBounds = true
        return image
    }()
    
    let buttonTrash: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "trash"), for: .normal)
        button.layer.cornerRadius = (CGFloat.heigthComponent*1.3)/2
        button.setShadow(alpha: 1, offSetX: 3, offSetY: 3, shadowOpacity: 1, shadowRadius: 3, boolean: true)
        button.backgroundColor = .clear
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(buttonCategorias)
        buttonCategorias.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(CGFloat.heigthComponent)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
