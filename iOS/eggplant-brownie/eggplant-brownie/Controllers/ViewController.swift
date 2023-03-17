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
    
    var itens = [
        "Molho de tomate",
        "Queijo",
        "Molho apimentado",
        "Manjericão"
    ]
    
    
    // MARK: - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let itemDaVez = itens[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = itemDaVez
        cell.contentConfiguration = content
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if cell.accessoryType == .none{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func adicionar(){
        
//        if let nomeRef = nomeTextField?.text, let felicidadeRef = felicidadeTextField?.text{
//            let nome = nomeRef
//            if let felicidade = Int(felicidadeRef){
//                let refeicao = Refeicao(nome: nome, felicidade: felicidade)
//
//                print("Comi \(nomeRef) e fiquei com felicidade: \(felicidade)")
//            }
//        } else{
//            print("Erro ao tentar criar a refeição.")
//        }
        
        guard let nomeRef = nomeTextField?.text, let felicidadeRef = felicidadeTextField?.text else{
            print("Erro ao tentar criar refeição")
            return
        }
        
        if let felicidade = Int(felicidadeRef){
            let newRef = Refeicao(nome: nomeRef, felicidade: felicidade)
            
            delegate?.add(newRef)
            
            navigationController?.popViewController(animated: true)  // Volta à tela anterior
        }
    }
    
}

