//
//  RegistrationMarkerProtocols.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 04/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

protocol RegistrationMarkerViewProtocol : class {
    
    var presenter : RegistrationMarkerPresenterProtocol? { get set }
    
    func render()
    func additionalConfiguration()
}

protocol RegistrationMarkerInputInteractorProtocol : class {
    
    var output : RegistrationMarkerOutputProtocol? { get set }
}

protocol RegistrationMarkerOutputProtocol : class {
    //
}

protocol RegistrationMarkerPresenterProtocol : class {
    
    var view : RegistrationMarkerViewProtocol? { get set }
    var interactor : RegistrationMarkerInputInteractorProtocol? { get set }
    var wireframe : RegistrationMarkerWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func backToMap()
}


protocol RegistrationMarkerWireFrameProtocol : class {
    
    var controller : RegistrationMarkerView? { get set }
    static func createModule(viewRef : RegistrationMarkerView)
    
    func backToMap()
    func goToRegistrationCategories(categories: [Categorys])
}
