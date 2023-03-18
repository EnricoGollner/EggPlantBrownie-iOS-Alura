//
//  Item.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 08/03/23.
//

import Foundation

class Item: NSObject {
    let nome: String
    let calorias: Double
    
    init(nome: String, calorias: Double){
        self.nome = nome
        self.calorias = calorias
    }
}
