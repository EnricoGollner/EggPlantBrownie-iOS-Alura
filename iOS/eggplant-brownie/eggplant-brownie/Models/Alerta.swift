//
//  Alerta.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 21/03/23.
//

import Foundation
import UIKit

class Alerta {
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(titulo: String = "Atenção", mensagem: String) {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let btOk = UIAlertAction(title: "Ok", style: .cancel)
        alerta.addAction(btOk)
        
        controller.present(alerta, animated: true)  // o método present só existe na class UIViewController
    }
}
