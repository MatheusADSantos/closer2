//
//  LoginWireFrame.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 24/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class LoginWireFrame : LoginWireFrameProtocol {
    
    var controller: LoginView? 
    
    init(_ controller : LoginView) {
        self.controller = controller
    }
    
    static func createModulo(viewRef: LoginView) {
        let presenter : LoginPresenterProtocol & LoginOutputProtocol = LoginPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.wireframe = LoginWireFrame(viewRef)
        viewRef.presenter?.interactor = LoginInteractor()
        viewRef.presenter?.interactor?.output = presenter 
    }
    
    func pushToMainNavigation(viewRef: UINavigationController) {
        print("LoginWireFrame -----> pushToMainNavigation() ",viewRef)
        
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else {return}
        mainNavigationController.viewControllers = [MapView()]
    }
    
    
    
}
