//
//  RegistrationCategoriesPresenter.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 06/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import Foundation


class RegistrationCategoriesPresenter : RegistrationCategoriesPresenterProtocol {
    
    var view: RegistrationCategoriesViewProtocol?
    
    var interactor: RegistrationCategoriesInputInteractorProtocol?
    
    var wireframe: RegistrationCategoriesWireFrameProtocol?
    
    func viewDidLoad() {
        view?.render()
        view?.additionalConfiguration()
    }
    
   
    
    
}


extension RegistrationCategoriesPresenter : RegistrationCategoriesOutputInteractorProtocol {
    
    
    
    
}
