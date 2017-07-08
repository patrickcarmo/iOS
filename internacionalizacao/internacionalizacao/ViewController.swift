//
//  ViewController.swift
//  internacionalizacao
//
//  Created by Patrick on 08/07/17.
//  Copyright © 2017 Patrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtMensagem: UILabel!
    @IBOutlet weak var resultado: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var valor: UITextField!
    @IBOutlet weak var botao: UIButton!
    
    @IBAction func calcular(_ sender: Any) {
        
        let campo : Int = Int(valor.text!)!
        var msg : String = ""
        if( campo % 2 == 0 ){
            resultado.text = NSLocalizedString("par", comment: "")
            msg = NSLocalizedString("par", comment: "")
        }else{
            resultado.text = NSLocalizedString("impar", comment: "")
            msg = NSLocalizedString("impar", comment: "")
        }
        
        showMessage(msg: msg)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let msgTitulo : String = NSLocalizedString("titulo", comment: "")
        
        let msgBotao : String = NSLocalizedString("botao", comment: "")
        
        let msgDescricao : String = NSLocalizedString("descricao", comment: "")
        
        descricao.text = msgDescricao
        botao.setTitle(msgBotao, for: .normal)
        txtMensagem.text = msgTitulo
        
    }
    
    func showMessage(msg: String){
        
        let janela : UIAlertController
        let btnOK : UIAlertAction
        
        janela = UIAlertController (
            title: NSLocalizedString("resultado", comment: ""),
            message: msg,
            preferredStyle: UIAlertControllerStyle.actionSheet
        )
        
        btnOK = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: {
                (ACTION: UIAlertAction!) in self.reset()
            }
        )
        
        janela.addAction(btnOK)
        self.present(janela, animated: true, completion:  nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reset(){
        resultado.text = ""
        valor.text = ""
        
    }

}

