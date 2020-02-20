//
//  MainNavigationProtocols.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 28/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

protocol MainNavigationViewProtocol : class {
    
    var presenter : MainNavigationPresenterProtocol? { get set }
    
    func verifyLogInView()
}

protocol MainNAvigationInputInteractorProtocol {
    
    var output : MainNAvigationOutputInteractorProtocol? { get set }
    
    func verifyLogIn(value: Bool)
}

protocol MainNAvigationOutputInteractorProtocol {
    
    func log(in viewRef: UIViewController)
}


protocol MainNavigationPresenterProtocol : class {
    
    var view : MainNavigationViewProtocol? { get set }
    var interactor : MainNAvigationInputInteractorProtocol? { get set }
    var wireframe : MainNavigationWireframeProtocol? { get set }
    
    func viewDidLoad()
}

protocol MainNavigationWireframeProtocol : class {
    
    var controller : MainNavigationController? { get set }
    
    static func createModulo(viewRef: MainNavigationController)
    func pushToMapView(viewRef: UIViewController)
    
    
}
