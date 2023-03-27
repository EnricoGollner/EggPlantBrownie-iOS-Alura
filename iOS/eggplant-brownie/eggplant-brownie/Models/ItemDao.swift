//
//  ItemDao.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 27/03/23.
//

import Foundation

class ItemDao {
    func recuperaCaminho() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let caminho = diretorio.appending(path: "itens")
        
        return caminho
    }
    
    func save(_ itens: [Item]) {
        do {
            guard let caminho = recuperaCaminho() else { return }
            
            let dados = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recupera() -> [Item] {
        do {
            guard let caminho = recuperaCaminho() else { return [] }
            let dados = try Data(contentsOf: caminho)
            guard let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? [Item] else { return [] }
            
            return itensSalvos
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
