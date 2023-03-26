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
    
    override func viewDidLoad() {
        guard let caminho = recuperaCaminho() else { return }
        
        do {
            let dados = try Data(contentsOf: caminho)
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? [Refeicao] else { return }
            
            refeicoes = refeicoesSalvas
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recuperaCaminho() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let caminho = diretorio.appending(path: "refeicao")
        
        return caminho
    }
    
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
        
        guard let caminho = recuperaCaminho() else { return }
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            
            try dados.write(to: caminho)
        } catch {
            print("Erro: \(error.localizedDescription)")
        }
        
        
    }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let cell = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let refeicaoTouched = refeicoes[indexPath.row]
            
            RemoveRefeicaoViewController(controller: self).exibe(refeicaoTouched, handler: { alert in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
        }
    }
    
    // Dando acesso ao ViewController:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionarRefeicao" {
            if let viewControllerAccessed = segue.destination as? ViewController {
                viewControllerAccessed.delegate = self
            }
        }
    }
    
}
