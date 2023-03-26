//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 06/03/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionarItemDelegate {
    
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
    
    @IBOutlet weak var itensTableView: UITableView?
    
    // MARK: View life cycle:
    
    override func viewDidLoad() {
        let botaoAddItem = UIBarButtonItem(title: "Adicionar", style: .plain, target: self, action: #selector(adicionarItens))
        
        navigationItem.rightBarButtonItem = botaoAddItem
        
        do {
            guard let diretorio = recuperaDiretorio() else { return }
            
            let dados = try Data(contentsOf: diretorio)
            
            guard let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? [Item] else { return }
            
            itens = itensSalvos
        } catch {
            
        }
    }
    
    @objc func adicionarItens() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)  // Passamos a classe ViewController para o atributo delegate, que só conforma com o protocolo AdicionarItemDelegate, por tanto, só podemos acessar o método "add" com ele
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item){
        itens.append(item)
        if let tableView = itensTableView {
            tableView.reloadData()
        } else {
            Alerta(controller: self).exibe(titulo: "Desculpe", mensagem: "Não foi possível atualizar a tabela")
        }
        
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            guard let caminho = recuperaDiretorio() else { return }
            try dados.write(to: caminho)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func recuperaDiretorio() ->  URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let caminho = diretorio.appending(path: "itens")
        
        return caminho
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
    
    func recuperaRefeicaoDoFormulario() -> Refeicao? {
        guard let nomeRef = nomeTextField?.text else {
            return nil
        }
        
        guard let felicidadeRef = felicidadeTextField?.text, let felicidade = Int(felicidadeRef) else {
            return nil
        }
        
        let newRef = Refeicao(nome: nomeRef, felicidade: felicidade, itens: itensSelecionados)
        return newRef
    }
    
    
    // MARK: - IBActions
    
    @IBAction func adicionar(){
        if let newRef = recuperaRefeicaoDoFormulario() {
            delegate?.add(newRef)
            navigationController?.popViewController(animated: true)
        } else {
            Alerta(controller: self).exibe(mensagem: "Erro ao ler dados do formulário.")
        }
    }
}

