//
//  MainNavigationController.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 28/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController, MainNavigationViewProtocol {
    
    var presenter: MainNavigationPresenterProtocol?
    
    func verifyLogInView() {
        //...
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = true
        
        
        if isLoggedIn() {
            //Se estiver logado, me manda para a tela do MAPA
            let mapView = MapView()
            viewControllers = [mapView]
        } else {
            //Se não, me manda para a tela do LOGIN
            perform(#selector(showLoginController), with: nil, afterDelay: 0.5)
        }

    }
    
    fileprivate func isLoggedIn() -> Bool {
        print("Logado? ---> ", UserDefaults.standard.isLoggedIn())
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc func showLoginController() {
        let loginView = LoginView()
//        present(loginView, animated: true)
        viewControllers = [loginView]
    }

}





//
//import UIKit
//
//class MainNavigationController: UINavigationController, MainNavigationViewProtocol {
//    var presenter: MainNavigationPresenterProtocol?
//
//    func verifyLogInView() {
//
//        print("Gerenciando o LOGIN XD")
//
//        if isLoggedIn() {
//            //Se estiver logado, me manda para a tela do MAPA
//            let mapView = MapView()
//            viewControllers = [mapView]
//        } else {
//            //Se não, me manda para a tela do LOGIN
//            perform(#selector(showLoginController), with: nil, afterDelay: 0.5)
//        }
//
//
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .black
//        self.navigationController?.isNavigationBarHidden = true
//
//        presenter?.viewDidLoad()
//    }
//
//
//    fileprivate func isLoggedIn() -> Bool {
//        print("Logado? ---> ", UserDefaults.standard.isLoggedIn())
//        return UserDefaults.standard.isLoggedIn()
//    }
//
//    @objc func showLoginController() {
//        let loginView = LoginView()
////        present(loginView, animated: true)
//        viewControllers = [loginView]
//    }
//
//}
