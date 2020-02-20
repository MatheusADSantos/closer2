//
//  RegistrationCategoriesProtocols.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 06/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import Foundation

protocol RegistrationCategoriesViewProtocol : class {
    
    var presenter : RegistrationCategoriesPresenterProtocol? { get set }
    
    func render()
    func additionalConfiguration()
}

protocol RegistrationCategoriesInputInteractorProtocol : class {
    
    var output : RegistrationCategoriesOutputInteractorProtocol? { get set }
}

protocol RegistrationCategoriesOutputInteractorProtocol : class {
    
    //implementar ainda ...
}

protocol  RegistrationCategoriesPresenterProtocol : class {
    
    var view : RegistrationCategoriesViewProtocol? { get set }
    var interactor : RegistrationCategoriesInputInteractorProtocol? { get set }
    var wireframe : RegistrationCategoriesWireFrameProtocol? { get set }
    
    
    func viewDidLoad()
}

protocol RegistrationCategoriesWireFrameProtocol : class {
    
    var controller : RegistrationCategoriesView? { get set }
    
    static func createModule(viewRef: RegistrationCategoriesView) 
}
