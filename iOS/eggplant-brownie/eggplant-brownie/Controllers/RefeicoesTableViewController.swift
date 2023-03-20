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
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_ :)))
        cell.addGestureRecognizer(longPress)
        
        return cell
    }
    
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
    }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let cell = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let refeicaoClicada = refeicoes[indexPath.row]
            
            let alertController = UIAlertController(title: refeicaoClicada.nome, message: refeicaoClicada.detalhes(), preferredStyle: .alert)
            
            let botaoCancelar = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(botaoCancelar)
            
            present(alertController, animated: true)
            
        }
    }
    
    // Dando acesso ao ViewController:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionar" {
            if let viewControllerAccessed = segue.destination as? ViewController{
                viewControllerAccessed.delegate = self
            }
        }
    }
    
}
