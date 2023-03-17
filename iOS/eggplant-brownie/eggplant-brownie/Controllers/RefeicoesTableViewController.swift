//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 12/03/23.
//

import UIKit

protocol AdicionaRefeicaoDelegate{
    func add(_ refeicao: Refeicao)
}

class RefeicoesTableViewController: UITableViewController, AdicionaRefeicaoDelegate {
    
    var refeicoes = [
        Refeicao(nome: "Macarrão", felicidade: 4),
        Refeicao(nome: "Pizza", felicidade: 5),
        Refeicao(nome: "Burguers", felicidade: 5)
    ]
    
    // Retornando número de linhas para a tabela:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    // Definindo o conteúdo:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let refDaVez = refeicoes[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = refDaVez.nome
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
    }
    
    // Dando acesso ao ViewController:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionar" {
            if let viewControllerClassAccessed = segue.destination as? ViewController{
                viewControllerClassAccessed.delegate? = self
            }
        }
    }
    
}
