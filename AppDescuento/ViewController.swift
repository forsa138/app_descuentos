//
//  ViewController.swift
//  AppDescuento
//
//  Created by Familia Ordenes Silva on 6/27/19.
//  Copyright © 2019 Familia Ordenes Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bottomConstrain: NSLayoutConstraint!

    @IBOutlet weak var descuento: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var monto: UITextField!
    @IBOutlet weak var porcentaje: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pantalla()
        // Do any additional setup after loading the view.
    }

    func pantalla(){
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height{
            case 1136:
                print("IPHONE 5 O SE")
            case 1334:
                print("IPHONE 6 6S 7 8")
            case 1920:
                print("IPHONE PLUS")
            case 2436:
                print("IPHONE X XS")
                self.bottomConstrain.constant = 300
            case 1792:
                print("IPHONE XR")
            case 2688:
                print("IPHONE XS MAX")
            default:
                print("cualquier otro tamaño")
            }
        }
    }
    
    @objc func teclado(notificacion: Notification){
        guard let tecladoUp = (notificacion.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return  }
        
        if notificacion.name == UIResponder.keyboardWillShowNotification {
            if UIScreen.main.nativeBounds.height == 1136 {
                self.view.frame.origin.y = -tecladoUp.height
            }
        }else{
            self.view.frame.origin.y = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func calcular(_ sender: UIButton) {
        
        if monto.text != "" && porcentaje.text != ""  {
            self.view.endEditing(true)
            guard let numero = monto.text else { return }
            guard let porc = porcentaje.text else { return  }
            let cant = (numero as NSString).floatValue
            let porciento = (porc as NSString).floatValue
            
            let desc = cant * porciento / 100
            let totalFinal = cant - desc
            
            total.text = "$\(totalFinal)"
            descuento.text = "$\(desc)"
        }else{
            let alert = UIAlertController(title: "alerta", message: "Escribe cantidad y porcentaje", preferredStyle: .alert)
            let accion = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(accion)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func limpiar(_ sender: UIButton) {
        self.view.endEditing(true)
        total.text = "$0.00"
        descuento.text = "$0.00"
        monto.text = ""
        porcentaje.text = ""
    }
    
}





