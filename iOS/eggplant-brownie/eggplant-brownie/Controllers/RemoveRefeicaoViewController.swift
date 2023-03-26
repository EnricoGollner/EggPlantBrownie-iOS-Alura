//
//  RemoverRefeicaoViewController.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 26/03/23.
//

import UIKit

class RemoveRefeicaoViewController {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(_ refeicaoTouched: Refeicao, handler: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: refeicaoTouched.nome, message: refeicaoTouched.detalhes(), preferredStyle: .alert)
        
        let botaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        alertController.addAction(botaoCancelar)
        
        let botaoRemover = UIAlertAction(title: "Remover", style: .destructive, handler: handler)
        alertController.addAction(botaoRemover)
        
        controller.present(alertController, animated: true)
    }
}
