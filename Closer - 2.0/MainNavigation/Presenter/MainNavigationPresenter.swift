//
//  MainNavigationPresenter.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 28/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class MainNavigationPresenter : MainNavigationPresenterProtocol {
    
    var view: MainNavigationViewProtocol?
    
    var interactor: MainNAvigationInputInteractorProtocol?
    
    var wireframe: MainNavigationWireframeProtocol?
    
    func viewDidLoad() {
        view?.verifyLogInView()
    }
    
}

extension MainNavigationPresenter : MainNAvigationOutputInteractorProtocol {
    
    func log(in viewRef: UIViewController) {
        //
    }
    
    
}
