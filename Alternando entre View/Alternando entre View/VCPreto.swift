//
//  VCPreto.swift
//  Alternando entre View
//
//  Created by Patrick on 01/07/17.
//  Copyright © 2017 Patrick. All rights reserved.
//

import UIKit

class VCPreto: UIViewController {
    
    @IBOutlet weak var nomeIn: UITextField!
    
    var nome : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomeIn.text = nome
    }
    
}
