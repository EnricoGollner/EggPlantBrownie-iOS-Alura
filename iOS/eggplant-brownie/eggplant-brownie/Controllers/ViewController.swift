//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Enrico Sousa Gollner on 06/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    var refTableViewController: RefeicoesTableViewController?
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    
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
            
            refTableViewController?.add(newRef)
            
            navigationController?.popViewController(animated: true)  // Volta à tela anterior
        }
    }
    
}

