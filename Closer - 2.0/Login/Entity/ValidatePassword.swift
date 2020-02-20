//
//  ValidatePassword.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 14/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import Foundation


extension Int {
    
    
    
    func validate(array:[Int]) -> Bool {
        for i in array {
            if self == i {
                print("Authenticated Successfully!")
                return true
            } else {
                print("Password Incorrect!, Please try again")
            }
        }
        return false
    }
    
    
    
}
