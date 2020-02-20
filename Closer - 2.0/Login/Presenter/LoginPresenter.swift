//
//  LoginPresenter.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 24/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class LoginPresenter : LoginPresenterProtocol {
    
    var view: LoginViewProtocol?
    
    var interactor: LoginInputInteractorProtocol?
    
    var wireframe: LoginWireFrameProtocol?
    
//    var output: LoginOutputProtocol?
    
    func viewDidLoad() {
        view?.render()
    }
    
    func getDataLogIn(email: String, password: String) {
        print("LoginPresenter ---> getDataLogIn() ", email, password)
        interactor?.DealDataLogIn(email: email, password: password)
    }
    
    
}

extension LoginPresenter : LoginOutputProtocol {
    
    func LogInMap(value: Bool) {
        print("LoginPresenter : LoginOutputProtocol ------> LogInMap() ---------> ", value)
        if value == true {
            print("Logando ....")
            view?.logInMap(value: value)
            wireframe?.pushToMainNavigation(viewRef: MainNavigationController())
        } else {
            view?.logInMap(value: value)
        }
//        view?.logInMap(value: value)
//        wireframe?.pushToMainNavigation(viewRef: MainNavigationController())
    }
    
    
    
}
