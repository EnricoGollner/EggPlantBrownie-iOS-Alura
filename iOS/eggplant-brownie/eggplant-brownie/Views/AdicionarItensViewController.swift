//
//  AdicionarItensViewController.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 19/03/23.
//

import UIKit

protocol AdicionarItemDelegate {
    func add(_ item: Item)
}

class AdicionarItensViewController: UIViewController {
    
    // MARK: - Atributos:
    
    var delegate: AdicionarItemDelegate?
    
    init(delegate: AdicionarItemDelegate?) {
        super.init(nibName: "AdicionarItensViewController", bundle: nil)  // nibName é o nome da view que está conectada a esse viewController
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - IBOutlets:
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var caloriasTextField: UITextField!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBAction
    
    @IBAction func adicionarItem(_ sender: Any) {
        guard let nome = nomeTextField.text, let calorias = caloriasTextField.text else { return }
        
        if let numCalorias = Double(calorias) {
            let newItem = Item(nome: nome, calorias: numCalorias)
            delegate?.add(newItem)
            navigationController?.popViewController(animated: true)
        }
    }
    
}
