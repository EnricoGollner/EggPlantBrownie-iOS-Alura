//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 06/03/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Atributos
    var delegate: AdicionaRefeicaoDelegate?
    
    var itens: [Item] = [
        Item(nome: "Molho de tomate", calorias: 40),
        Item(nome: "Queijo", calorias: 40),
        Item(nome: "Manjericão", calorias: 40),
        Item(nome: "Molho de pimenta", calorias: 40)
    ]
    
    var itensSelecionados: [Item] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    
    // MARK: View life cycle:
    
    override func viewDidLoad() {
        let botaoAddItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(adicionarItens))
        
        navigationItem.rightBarButtonItem = botaoAddItem
    }
    
    @objc func adicionarItens() {
        let adicionarItensViewController = AdicionarItensViewController()
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let itemDavez = itens[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = itemDavez.nome
        cell.contentConfiguration = content
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.accessoryType == .none {
            let linhaDaTabela = indexPath.row  // Int
            itensSelecionados.append(itens[linhaDaTabela])
            cell.accessoryType = .checkmark
        } else {
            let itemClicado = itens[indexPath.row]
            if let position = itensSelecionados.firstIndex(of: itemClicado){  // Se encontrou o item clicado nos selecionados, retorna a posição do mesmo
                itensSelecionados.remove(at: position)
            }
            cell.accessoryType = .none
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func adicionar(){
        
        guard let nomeRef = nomeTextField?.text, let felicidadeRef = felicidadeTextField?.text else{
            print("Erro ao tentar criar refeição")
            return
        }
        
        guard let felicidade = Int(felicidadeRef) else { return }
        
        let newRef = Refeicao(nome: nomeRef, felicidade: felicidade, itens: itensSelecionados)
        
        delegate?.add(newRef)
        navigationController?.popViewController(animated: true)
    }
    
}

