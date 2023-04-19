//
//  ViewController.swift
//  Apartments
//
//  Created by German Cadenas on 18/04/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email_input: UITextField!
    @IBOutlet weak var password_input: UITextField!
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var login_progress: UIActivityIndicatorView!
    @IBOutlet weak var register_text: UIButton!
    @IBOutlet weak var forgot_password_text: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        password_input.enablePasswordToggle()
    }
    
    private func setup() {
        hideControls(hide: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _ = Auth.auth().addStateDidChangeListener { auth, user in
            self.email_input.text = user?.email
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        let email = email_input.text?.trim()
        let password = password_input.text?.trim()
        if email?.count == 0 || password?.count == 0 {
            showAlertDialog(mensaje: "Introduce el correo electrónico y/o contraseña")
        } else {
            hideControls(hide: true)
            Auth.auth().signIn(withEmail: email!, password: password!) {
                (result, error) in
                if let result = result, error == nil {
                    if result.user.isEmailVerified {
                        self.replaceView(target: "main_form", animated: true)
                    } else {
                        self.showAlertDialog(mensaje: "Es necesario que verifiques tu correo electrónico para poder ingresar.")
                    }
                } else {
                    self.showAlertDialog(mensaje: "El correo electrónico y/o contraseña son incorrectos")
                }
                DispatchQueue.main.async {
                    self.hideControls(hide: false)
                }
            }
        }
    }
    
    private func hideControls(hide:Bool) {
        login_progress.isHidden = !hide
        login_button.isHidden = hide
    }
    
    @IBAction func register(_ sender: UIButton) {
        pushView(target: "register_form", animated: true)
    }
    
    @IBAction func forgot(_ sender: UIButton) {
        pushView(target: "forgot_form", animated: true)
    }
    
}
