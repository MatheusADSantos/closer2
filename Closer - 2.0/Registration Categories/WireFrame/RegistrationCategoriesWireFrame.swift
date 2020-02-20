//
//  RegistrationCategoriesWireFrame.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 06/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit


class RegistrationCategoriesWireFrame : RegistrationCategoriesWireFrameProtocol {
    
    var controller: RegistrationCategoriesView?
    
    init(controller: RegistrationCategoriesView) {
        self.controller = controller
    }
    
    static func createModule(viewRef: RegistrationCategoriesView) {
        let presenter : RegistrationCategoriesPresenterProtocol & RegistrationCategoriesOutputInteractorProtocol = RegistrationCategoriesPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.interactor?.output = presenter
        viewRef.presenter?.interactor = RegistrationCategoriesInputInteractor()
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.wireframe = RegistrationCategoriesWireFrame(controller: viewRef)
    }
    
    
    
}
