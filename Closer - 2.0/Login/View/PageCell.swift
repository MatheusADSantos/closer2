//
//  PageCell.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 27/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page : Page? {
        didSet {
            print(UIScreen.main.bounds.height)
            guard let page = page else {return}
            imageView.image = UIImage(named: page.imageName)
            
            let font = UIFont.systemFont(ofSize: CGFloat.fontSizeTitle)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            paragraphStyle.firstLineHeadIndent = 0.0

            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: UIColor.blue,
                .paragraphStyle: paragraphStyle
            ]
            
            
            let font2 = UIFont.systemFont(ofSize: CGFloat.fontSize)
            let paragraphStyle2 = NSMutableParagraphStyle()
            paragraphStyle2.alignment = .justified
            let attributes2: [NSAttributedString.Key: Any] = [
                .font: font2,
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle2
            ]
            
            let attributedTexts = NSMutableAttributedString(string: "\(page.title)", attributes: attributes)
            let attributedTexts2 = NSMutableAttributedString(string: "\n\n      \(page.message)", attributes: attributes2)
            
            attributedTexts.append(attributedTexts2)
            textView.attributedText = attributedTexts
        }
    }
    
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "pag1")
        iv.clipsToBounds = true
        return iv
    }()
    let view : UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    let textView : UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.textAlignment = .justified
        return tv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubviews(viewsToAdd: imageView, view)
        view.addSubview(textView)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(CGFloat.marginTopImageTutorial)
            make.left.right.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height*0.63)
        }
        view.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(CGFloat.margin)
            make.left.right.bottom.equalToSuperview()
        }
        textView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(CGFloat.margin*2)
            make.right.bottom.equalToSuperview().offset(-CGFloat.margin*3)
        }
    }
    
}
