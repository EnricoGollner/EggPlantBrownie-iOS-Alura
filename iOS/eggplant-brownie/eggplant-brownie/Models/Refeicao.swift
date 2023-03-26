//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 08/03/23.
//

import UIKit

class Refeicao: NSObject, NSCoding {
    
    let nome: String
    let felicidade: Int
    var itens: Array<Item> = []
    
    // MARK: - init
    
    init(nome: String, felicidade: Int, itens: [Item] = []){  // Valor default no array de itens
        self.nome = nome
        self.felicidade = felicidade
        self.itens = itens
    }
    
    // MARK: - NSCoding:
    
    
    func encode(with coder: NSCoder) {
        coder.encode(nome, forKey: "nome")
        coder.encode(felicidade, forKey: "felicidade")
        coder.encode(itens, forKey: "itens")
    }
    
    required init?(coder: NSCoder) {
        nome = coder.decodeObject(forKey: "nome") as! String
        felicidade = coder.decodeInteger(forKey: "felicidade")
        itens = coder.decodeObject(forKey: "itens") as! [Item]
    }
    
    // MARK: - métodos
    
    func totalCalorias() -> Double{
        var total = 0.0
        
        for item in itens{
            total += item.calorias
        }
        
        return total
    }
    
    func detalhes() -> String {
        var message = "Felicidade: \(felicidade)"
        
        for item in itens {
            message += "\n\(item.nome) - Calorias: \(item.calorias)"
        }
        
        return message
    }
    
}
