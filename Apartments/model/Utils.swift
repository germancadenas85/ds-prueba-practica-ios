//
//  Utils.swift
//  Apartments
//
//  Created by German Cadenas on 18/04/23.
//

import UIKit

extension UITextField {
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(UIImage(named: "eye-fill"), for: .normal)
        }else{
            button.setImage(UIImage(named: "eye-slash-fill"), for: .normal)
        }
    }
    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}

extension UIViewController {
    func showAlertDialog(mensaje: String) {
        let alert = UIAlertController(title: "Apartments", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertDialog(mensajeClose: String) {
        let alert = UIAlertController(title: "Apartments", message: mensajeClose, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { (action) -> Void in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension UIViewController {
    func pushView(target: String, animated: Bool) {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: target)
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    func replaceView(target:String, animated:Bool) {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: target)
        self.navigationController?.setViewControllers([vc], animated: animated)
    }
}
