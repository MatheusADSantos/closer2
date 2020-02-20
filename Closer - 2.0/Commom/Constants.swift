//
//  Constants.swift
//  Closer
//
//  Created by macbook-estagio on 25/09/19.
//  Copyright © 2019 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    static let typeDevice = UIDevice.current.userInterfaceIdiom
    static let widthScreen = UIScreen.main.bounds.width
    
    static let heigthComponent = CGFloat.typeDevice == .phone ? CGFloat(40) : CGFloat(50)
    static let margin = UIDevice.current.userInterfaceIdiom == .phone ? CGFloat(10) : CGFloat(15)
    
    static let fontSizeTitle = UIScreen.main.bounds.height * 0.036 // 0.036 é uma constante apropriada
    static let fontSize = UIScreen.main.bounds.height * 0.021 // 0.021 é uma constante apropriada
    
    static let bottomPageControl = UIDevice.current.name == "iPhone 5 Fulltime 2" ? 10 : CGFloat.margin
    
    static var teste = UIDevice.current.name == String("iPhone 11 Pro Max") ?  CGFloat(35) : CGFloat(20)
    
    static var marginTopImageTutorial = UIDevice.current.userInterfaceIdiom == .phone ? CGFloat(35) : CGFloat(40)
    
    
    
    struct Constants {
        static let screen = UIScreen.main.bounds
        static let screenHeight = screen.height
        static let screenWidth = screen.width
        static let sizeImagePhoto = (screenHeight*1/3)*3/4
    }
    
    static func calculateLeftToCollectionView() -> CGFloat {
        print(widthScreen)
//        if widthScreen < 450 {
//            
//        }
        let heigthComponent = CGFloat.heigthComponent
        let left = (widthScreen - (9*heigthComponent))/2 // como diam. e espaco entre as cell são =, uso o "9"
        print("widthScreen", widthScreen, "heigthComponent", heigthComponent, "left", left)
        return left
    }
    
    static func calculateEdgesInsetSides() -> CGFloat {
        let widthButton = widthScreen - margin * 2
        let radiousImage = (CGFloat.heigthComponent - 10)/2
        let insetEdgesSides = (widthButton / 2) - radiousImage
        
        return insetEdgesSides
    }
    
    
    
    
//    static var myDefaultFontSize: CGFloat = {
//        let x = CGFloat()
//        switch UIDevice().Type {
//        case .iPhoneSE, .iPhone5, .iPhone5S:
//            print("default value")
//            case .iPhone6, .iPhone7, .iPhone8, .iPhone6S, .iPhoneX:
//            x += 4
//        default:
//            break
//        }
//        return x
//    }
    
}


extension UIColor {
    
    static let backgroundColorGray7 = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1)
    static let backgroundColorGray6 = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
    static let backgroundColorGray5 = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
    static let backgroundColorGray4 = UIColor(red: 58/255, green: 58/255, blue: 60/255, alpha: 1)
    static let backgroundColorGray3 = UIColor(red: 72/255, green: 72/255, blue: 74/255, alpha: 1)
    static let backgroundColorGray2 = UIColor(red: 99/255, green: 99/255, blue: 102/255, alpha: 1)
    static let backgroundColorGray = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
    
}


public extension UIDevice {
    
    
//    var deviceType = UIDevice.current.model
//
//
//
//    static var myDefaultFontSize: CGFloat = {
//        let x = CGFloat()
//        switch deviceType {
//        case .iPhoneSE, .iPhone5, .iPhone5S:
//            print("default value")
//            case .iPhone6, .iPhone7, .iPhone8, .iPhone6S, .iPhoneX:
//            x += 4
//        default:
//            break
//        }
//        return x
//    }
    
}
