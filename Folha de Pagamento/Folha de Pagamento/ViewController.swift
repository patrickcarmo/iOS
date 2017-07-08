//
//  ViewController.swift
//  Folha de Pagamento
//
//  Created by Patrick on 01/07/17.
//  Copyright © 2017 Patrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var valorHoras: UITextField!
    
    @IBOutlet weak var horasTrabalhadas: UITextField!
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        /*
        let vlrHora : Double = Double(valorHoras.text!)!
        let qtdHoras : Double = Double(horasTrabalhadas.text!)!
        
        let salarioBruto = calcularSalarioBruto(vlrHora:vlrHora, qtdHoras:qtdHoras)
        let ir = calculaIR(salarioBruto: salarioBruto)
        let inss = calcularINSS(salario: salarioBruto)
        let fgts = calcularFGTS(salario: salarioBruto)
        let descontos = calcularDescontos(valorIR: ir, valorINSS: inss)
        let salarioLiquido = salarioBruto - descontos
        
        let view = segue.destination as! salario
        
        txtSalarioBruto = segue.destination as! salarioBruto
        txtIR = segue.destination as! ir
        txtINSS = segue.destination as! inss
        txtFGTS = segue.destination as! fgts
        txtDescontos = segue.destination as! descontos
        txtSalarioLiquido = segue.destination as! salarioLiquido
         */
        
        let view = segue.destination as! salario
        view.vlrHora = Double(valorHoras.text!)!
        view.qtdHora = Double(horasTrabalhadas.text!)!
    }
    

    
}

