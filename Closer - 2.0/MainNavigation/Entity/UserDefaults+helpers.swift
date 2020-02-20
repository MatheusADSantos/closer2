//
//  MainNavigationEntity.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 28/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import Foundation

extension UserDefaults {


    enum UserDefaultsKeys: String {
        case caseIsLoggingIn
    }

    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.caseIsLoggingIn.rawValue)
        synchronize()
    }

    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.caseIsLoggingIn.rawValue)
    }


}


