//
//  MapProtocols.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 28/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

protocol MapViewProtocol : class {
    
    var presenter : MapPresenterProtocol? { get set }
    var categoriesDefault : [Categorys] { get set }
    
    func render()
    func showMyLocation()
    func saveDefaultCategories()
    func additionalConfiguration()
}

protocol MapInputInteractorProtocol : class {
    
    var output : MapOutputInteractorProtocol? { get set }
    
    func signOut()
    func saveDefaultCategories()
}

protocol MapOutputInteractorProtocol : class {
    
    func backToLogin()
    func searchingDefaultCategories(categoriesDefault : [Categorys])
}

protocol MapPresenterProtocol : class {
    
    var view : MapViewProtocol? { get set }
    var interactor : MapInputInteractorProtocol? { get set }
    var wireframe : MapWireframeProtocol? { get set }
    
    func viewDidLoad()
    func signOut()
    func saveDefaultCategories()
    func pushToRegistrationMarkerView()
}

protocol MapWireframeProtocol : class {
    
    var controller : MapView? { get set }
    static func createModulo(viewRef: MapView)
    
    func backToLogin()
    func pushToRegistrationMarkerView()
    
}
