//
//  RegistrationMarkerWireFrame.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 04/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class RegistrationMarkerWireFrame : RegistrationMarkerWireFrameProtocol {
    
    var controller: RegistrationMarkerView?
    
    init(controller : RegistrationMarkerView) {
        self.controller = controller
    }
    
    static func createModule(viewRef: RegistrationMarkerView) {
        let presenter : RegistrationMarkerPresenterProtocol & RegistrationMarkerOutputProtocol =  RegistrationMarkerPresenter()
        viewRef.presenter = presenter
        viewRef.presenter?.interactor?.output = presenter
        viewRef.presenter?.view = viewRef
        viewRef.presenter?.interactor = RegistrationMarkerInputInteractor()
        viewRef.presenter?.wireframe = RegistrationMarkerWireFrame(controller: viewRef)
        
    }
    
    func backToMap() {
        controller?.navigationController?.popViewController(animated: true)
    }
    
    func goToRegistrationCategories(categories: [Categorys]) {
        print(categories)
        RegistrationCategoriesView().categories = categories
        controller?.navigationController?.pushViewController(RegistrationCategoriesView(), animated: true)
    }
    
    
    
}
