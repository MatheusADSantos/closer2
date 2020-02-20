//
//  MainNavigationWireframe.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 28/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class MainNavigationWireframe : MainNavigationWireframeProtocol {
    
    func pushToMapView(viewRef: UIViewController) {
        print("MainNavigationWireframe -----> pushToMapView")
    }
    
    
    var controller: MainNavigationController?
    
    init(controller : MainNavigationController) {
        self.controller = controller
    }
    
    static func createModulo(viewRef: MainNavigationController) {
        let presenter : MainNavigationPresenterProtocol & MainNAvigationOutputInteractorProtocol = MainNavigationPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.wireframe = MainNavigationWireframe(controller: viewRef)
        viewRef.presenter?.interactor = MainNavigationInteractor()
        viewRef.presenter?.interactor?.output = presenter
    }
    
    
    
    
}
