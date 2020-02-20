//
//  LoginInteractor.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 24/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class LoginInteractor : LoginInputInteractorProtocol {

    var output: LoginOutputProtocol?
    
//    func DealDataLogIn(email: String, password: String) {
//        print("LoginInteractor ----> DealDataLogIn", email, password)
//
//        if email == "Matheus" && password == "123" {
//
//            setandoValue(value: true)
//
//        } else if (email != "" && password != "") && (email != "Matheus" || password != "123") {
//
//            setandoValue(value: false)
//
//            return
//        }
//    }
    
//    func DealDataLogIn(email: String, password: String) {
//        print("LoginInteractor ----> DealDataLogIn", email, password)
//        let passwordInt = Int(password)
//        let validate = passwordInt?.validate()
//
//        if email == "Matheus" && password == "123" {
//
//            setandoValue(value: true)
//
//        } else if (email != "" && password != "") && (email != "Matheus" || password != "123") {
//
//            setandoValue(value: false)
//
//            return
//        }
//    }
    let logins = ["matheus","marcela","jaum"]
    let passwords = [111,222,333]
    
    func DealDataLogIn(email: String, password: String) {
        print("LoginInteractor ----> DealDataLogIn", email, password)
        
        let passwordInt = Int(password)
        
        for _ in 0..<logins.count {
            if passwordInt!.validate(array: passwords) {
                
            }
        }

        if email == "Matheus" && password == "123" {

            setandoValue(value: true)

        } else if (email != "" && password != "") && (email != "Matheus" || password != "123") {

            setandoValue(value: false)

            return
        }
    }
    
    
    
    func setandoValue(value: Bool) {
        print("Value: True/False", value)
        UserDefaults.standard.setIsLoggedIn(value: value)
        output?.LogInMap(value: value)
    }
    
    
    
    
}
