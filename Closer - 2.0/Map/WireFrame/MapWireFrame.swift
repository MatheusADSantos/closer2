//
//  MapWireFrame.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 31/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class MapWireFrame : MapWireframeProtocol {
    
    
    var controller: MapView?
    
    init(controller : MapView) {
        self.controller = controller
    }
    
    static func createModulo(viewRef: MapView) {
        let presenter : MapPresenterProtocol & MapOutputInteractorProtocol = MapPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.interactor = MapInteractor()
        viewRef.presenter?.interactor?.output = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.wireframe = MapWireFrame(controller: viewRef)
    }
    
    
    func backToLogin() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else {return}
        mainNavigationController.viewControllers = [LoginView()]
    }
    
    func pushToRegistrationMarkerView() {
//        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
//        guard let mainNavigationController = rootViewController as? MainNavigationController else {return}
//        mainNavigationController.viewControllers = [RegistrationMarkerView()]
        
        controller?.navigationController?.pushViewController(RegistrationMarkerView(), animated: true)
    }
    
}
