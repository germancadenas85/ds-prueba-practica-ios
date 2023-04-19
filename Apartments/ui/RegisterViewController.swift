//
//  RegisterViewController.swift
//  Apartments
//
//  Created by German Cadenas on 18/04/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var email_input: UITextField!
    @IBOutlet weak var password_input: UITextField!
    @IBOutlet weak var confirm_password_input: UITextField!
    @IBOutlet weak var register_button: UIButton!
    @IBOutlet weak var login_progress: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        password_input.enablePasswordToggle()
        confirm_password_input.enablePasswordToggle()
    }
    
    private func setup() {
        hideControls(hide: false)
    }
    
    private func hideControls(hide:Bool) {
        login_progress.isHidden = !hide
        register_button.isHidden = hide
    }

    @IBAction func register(_ sender: UIButton) {
        let email = email_input.text?.trim()
        let password = password_input.text?.trim()
        let confirm_password = confirm_password_input.text?.trim()
        
        if email?.count == 0 {
            showAlertDialog(mensaje: "Introduce tu correo electrónico")
        } else if password?.count == 0 {
            showAlertDialog(mensaje: "Introduce tu contraseña")
        } else if password != confirm_password {
            showAlertDialog(mensaje: "Las contraseñas no coinciden")
        } else if password!.count < 6 {
            showAlertDialog(mensaje: "La contraseña debe tener al menos 6 caracteres")
        } else {
            hideControls(hide: true)
            Auth.auth().createUser(withEmail: email!, password: password!) {
                (result, error) in
                if error == nil {
                    result?.user.sendEmailVerification()
                    self.showAlertDialog(mensajeClose: "El registro ha sido realizado correctamente. Es necesario que verifiques tu correo electrónico: " + (result?.user.email)!)
                    self.hideControls(hide: true)
                } else {
                    self.showAlertDialog(mensaje: "No se logró realizar el registro. Intente de nuevo")
                    self.hideControls(hide: true)
                }
            }
        }
    }
    
}
