//
//  RegistrationCategoriesView.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 06/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class RegistrationCategoriesView: UIViewController, RegistrationCategoriesViewProtocol {
    
    var presenter: RegistrationCategoriesPresenterProtocol?
    var heightScreen = UIScreen.main.bounds.height
    var categories = [Categorys]()
    
    
    let imageView : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor().hexaToColor(hex: "fff").cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = CGFloat.Constants.sizeImagePhoto/2
        view.setShadow(alpha: 1, offSetX: 2, offSetY: 2, shadowOpacity: 1, shadowRadius: 2, boolean: true)
        return view
    }()
    let textFieldDescription : UITextField = {
        let tx = UITextField()
        let raio = CGFloat.heigthComponent/2
        tx.setTextField(raio, raio, .white, "Descrição da Categoria", .black, 20, 0)
        return tx
    }()
    lazy var collectionViewCategory : UICollectionView = {
        let left = CGFloat.calculateLeftToCollectionView()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = CGFloat.heigthComponent
        layout.minimumInteritemSpacing = CGFloat.heigthComponent
        layout.sectionInset = UIEdgeInsets(top: 10, left: left, bottom: 10, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.layer.cornerRadius = CGFloat.heigthComponent/2
        
        return cv
    }()
    let button : UIButton = {
        let edgesInsetSides = CGFloat.calculateEdgesInsetSides()
        
        let bt = UIButton()
        bt.backgroundColor = .white
        bt.layer.cornerRadius = CGFloat.heigthComponent/2
        bt.setImage(UIImage(named: "save"), for: .normal)
        bt.imageEdgeInsets = UIEdgeInsets(top: 5, left: edgesInsetSides, bottom: 5, right: edgesInsetSides)
        return bt
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        RegistrationCategoriesWireFrame.createModule(viewRef: self)
        presenter?.viewDidLoad()
        print(categories)
    }
    
    func render() {
        view.backgroundColor = UIColor.backgroundColorGray
        
        view.addSubviews(viewsToAdd: imageView, textFieldDescription, collectionViewCategory, button)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(CGFloat.Constants.sizeImagePhoto)
            make.top.equalToSuperview().offset(CGFloat.margin*7)
        }
        textFieldDescription.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(CGFloat.margin)
            make.left.equalToSuperview().offset(CGFloat.margin)
            make.right.equalToSuperview().offset(-CGFloat.margin)
            make.height.equalTo(CGFloat.heigthComponent)
        }
        collectionViewCategory.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldDescription.snp.bottom).offset(CGFloat.margin)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(button.snp.top).offset(-CGFloat.margin)
        }
        button.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-CGFloat.margin*2)
            make.left.equalToSuperview().offset(CGFloat.margin)
            make.right.equalToSuperview().offset(-CGFloat.margin)
            make.height.equalTo(CGFloat.heigthComponent)
        }
    }
    
    func additionalConfiguration() {
        navigationItem.title = "Cadastro Categoria"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cadatro", style: .plain, target: self, action: #selector(backToRegistrationMarker(sender:)))
        hideKeyboardTapped()
    }
    @objc func backToRegistrationMarker(sender: UIButton) {
        print("foi")
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
}
