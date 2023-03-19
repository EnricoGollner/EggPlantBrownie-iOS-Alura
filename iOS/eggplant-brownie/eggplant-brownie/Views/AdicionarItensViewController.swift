//
//  AdicionarItensViewController.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 19/03/23.
//

import UIKit

class AdicionarItensViewController: UIViewController {

    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBAction
    
    @IBAction func adicionarItem(_ sender: Any) {
        // Navegar próxima
        
        navigationController?.popViewController(animated: true)
    }
    
}
