//
//  salario.swift
//  Folha de Pagamento
//
//  Created by Patrick on 01/07/17.
//  Copyright © 2017 Patrick. All rights reserved.
//

import UIKit

class salario: UIViewController {
    
    
    @IBOutlet weak var txtSalario: UITextField!
    @IBOutlet weak var txtIR: UITextField!
    @IBOutlet weak var txtINSS: UITextField!
    @IBOutlet weak var txtFGTS: UITextField!
    @IBOutlet weak var txtDescontos: UITextField!
    @IBOutlet weak var txtSalarioLiquido: UITextField!
    
    var vlrHora : Double = 0.0;
    var qtdHora : Double = 0.0;
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        
        txtSalario.text = String(calcularSalarioBruto(vlrHora: vlrHora, qtdHoras: qtdHora))
        txtIR.text = String(calculaIR(salarioBruto : Double(txtSalario.text!)!))
        txtINSS.text = String(calcularINSS(salario: Double(txtSalario.text!)!))
        txtFGTS.text = String(calcularFGTS(salario: Double(txtSalario.text!)!))
        txtDescontos.text = String(calcularDescontos(valorIR: Double(txtIR.text!)!, valorINSS: Double(txtINSS.text!)!))
        txtSalarioLiquido.text = String( Double(txtSalario.text!)! - Double(txtDescontos.text!)!)
    }

    func calcularSalarioBruto(vlrHora: Double, qtdHoras: Double) -> Double{
        return vlrHora * qtdHoras
    }
    
    func calculaIR(salarioBruto : Double) -> Double{
        if(salarioBruto > 900 && salarioBruto <= 1500.00){
            return salarioBruto * 0.05
        }else if(salarioBruto > 1500 && salarioBruto <= 2500.00){
            return salarioBruto * 0.10
        }else if(salarioBruto > 2500){
            return salarioBruto * 0.20
        }
        return 0.0
    }
    
    func calcularINSS(salario: Double) -> Double{
        return salario * 0.10
    }
    
    func calcularFGTS(salario: Double) -> Double{
        return salario * 0.11
    }
    
    func calcularDescontos(valorIR: Double, valorINSS: Double) -> Double{
        return valorIR + valorINSS
    }
    
    
}
