//
//  ViewController.swift
//  Table-dinâmica
//
//  Created by Enrico Sousa Gollner on 09/03/23.
//

import UIKit

class ViewController: UITableViewController {
    
    let refeicoes = ["Churros", "Macarrão", "Pizza"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TableViewController carregou!")
    }
    
    // Número de linhas da tabela:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        refeicoes.count
    }
    
    // Conteúdo da tabela:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let refDaVez = refeicoes[indexPath.row]
        
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.text = refDaVez
        
        cell.contentConfiguration = content
        
        return cell
    }
    
}

