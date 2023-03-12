//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 12/03/23.
//

import UIKit

class RefeicoesTableViewController: UITableViewController {
    
    var refeicoes = [
        Refeicao(nome: "Macarrão", felicidade: 4),
        Refeicao(nome: "Pizza", felicidade: 5),
        Refeicao(nome: "Burguers", felicidade: 5)
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let refNow = refeicoes[indexPath.row]
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        var content = cell.defaultContentConfiguration()
        content.text = refNow.nome
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
    }
    
    // Dando acesso ao ViewController:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewControllerAccessed = segue.destination as? ViewController{
            viewControllerAccessed.refTableViewController = self  // Preenchemos a instância dessa classe, encontrada no arquivo "ViewController"
        }
    }
    
}
