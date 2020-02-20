//
//  MapPresenter.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 31/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class MapPresenter : MapPresenterProtocol {
    
    var view: MapViewProtocol?
    
    var interactor: MapInputInteractorProtocol?
    
    var wireframe: MapWireframeProtocol?
    
    
    func viewDidLoad() {
        view?.saveDefaultCategories()
        view?.render()
        view?.showMyLocation()
        view?.additionalConfiguration()
    }
    
    func signOut() {
        interactor?.signOut()
    }
    
    func saveDefaultCategories() {
        interactor?.saveDefaultCategories()
    }
    
    func pushToRegistrationMarkerView() {
        wireframe?.pushToRegistrationMarkerView()
    }
    
}



extension MapPresenter : MapOutputInteractorProtocol {
    
    func backToLogin() {
        wireframe?.backToLogin()
    }
    
    func searchingDefaultCategories(categoriesDefault: [Categorys]) {
        print(categoriesDefault)
        view?.categoriesDefault = categoriesDefault
    }
    
//    func searchingDefaultCategories() {
//        let keys : [String] = ["Mercado","Dentista","Shopping","Rodoviária","Cinema"]
//        var imagesCategory = [String]()
//        
//        for key in keys {
//            let decoder = JSONDecoder()
//            let data = try! decoder.decode(CategorysDefault.self, from: UserDefaults.standard.data(forKey: key)!)
//            imagesCategory.append(data.image)
//        }
//        print(imagesCategory)
//        view?.searchingDefaultCategories(arrayImagesCategory: imagesCategory)
//    }
    
    
}
