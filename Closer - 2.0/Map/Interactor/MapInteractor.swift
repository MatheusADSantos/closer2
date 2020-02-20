//
//  MapInteractor.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 31/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class MapInteractor : MapInputInteractorProtocol {
    
    var output: MapOutputInteractorProtocol?
    private let key = "categoriesDefault"
    
    func signOut() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        output?.backToLogin()
    }
    
    func saveDefaultCategories() {
        print("Salvando Categorias Padrão no CACHE ...")
        var categoriesDefault = [Categorys]()
        let names = ["Mercado","Dentista","Shopping","Rodoviária","Cinema"]
        let imageNames = ["carinho","teeth","shopping-cart","bus","film"]
        var i = 0

        //Populando os dados categoriesDefault, que é um array do tipo da struct CategoryDefault ...
        repeat {
            let name = names[i]
            let imageName = imageNames[i]
            let category = Categorys.init(name: name, image: imageName)
            categoriesDefault.append(category)
            i = i + 1
        } while(i < 5)
        
        encodando(categoriesDefault: categoriesDefault)
    }
    
    //MARK: - Metodos auxiliar
    private func encodando(categoriesDefault: [Categorys]) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let dataEncode = try encoder.encode(categoriesDefault)
            UserDefaults.standard.set(dataEncode, forKey: key)
            print(String(data: dataEncode, encoding: .utf8)!)
            decodando()
        } catch {
            print("DEU RUIM ......", error.localizedDescription)
        }
    }
    private func decodando() {
        let decoder = JSONDecoder()
        
        do {
            if let data = UserDefaults.standard.data(forKey: key) {
                let dataDecode = try decoder.decode([Categorys].self, from: data)
                print(dataDecode)
                output?.searchingDefaultCategories(categoriesDefault: dataDecode)
            } else {
                print("Não tem dados nesta chave ...")
            }
        } catch {
            print("DEU RUIM .....", error.localizedDescription)
        }
        
    }
    
    
}
