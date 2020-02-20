//
//  LoginProtocols.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 24/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit


protocol LoginViewProtocol : class {
    
    var presenter : LoginPresenterProtocol? { get set }
    
    func render()
    func logInMap(value: Bool)
}

protocol  LoginInputInteractorProtocol : class {
    
    var output : LoginOutputProtocol? { get set }
    
    func DealDataLogIn(email: String, password: String)
}

protocol LoginOutputProtocol {
    
    func LogInMap(value: Bool)
}

protocol LoginPresenterProtocol : class {
    
    var view : LoginViewProtocol? { get set }
    var interactor : LoginInputInteractorProtocol? { get set }
    var wireframe : LoginWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func getDataLogIn(email: String, password: String)
}

protocol LoginWireFrameProtocol {
    
    var controller: LoginView? { get set }
    
    static func createModulo(viewRef: LoginView)
    func pushToMainNavigation(viewRef: UINavigationController)
}
