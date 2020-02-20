//
//  RegistrationMarkerPresenter.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 04/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import Foundation

class RegistrationMarkerPresenter : RegistrationMarkerPresenterProtocol {
    
    var view: RegistrationMarkerViewProtocol?
    
    var interactor: RegistrationMarkerInputInteractorProtocol?
    
    var wireframe: RegistrationMarkerWireFrameProtocol?
    
    func viewDidLoad() {
        view?.render()
        view?.additionalConfiguration()
    }
    
    func backToMap() {
        wireframe?.backToMap()
    }
    
    
}


extension RegistrationMarkerPresenter : RegistrationMarkerOutputProtocol {
    
}
