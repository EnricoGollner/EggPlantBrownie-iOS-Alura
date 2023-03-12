//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 08/03/23.
//

import Foundation

class Refeicao{
    let nome: String
    let felicidade: Int
    let itens: Array<Item> = []
    
    init(nome: String, felicidade: Int){
        self.nome = nome
        self.felicidade = felicidade
    }
    
    func totalCalorias() -> Double{
        var total = 0.0
        
        for item in itens{
            total += item.calorias
        }
        
        return total
    }
}
