//
//  DetallesViewController.swift
//  Apartments
//
//  Created by German Cadenas on 19/04/23.
//

import UIKit

class DetallesViewController: UIViewController {
    
    var apartamento = Apartment()
    
    @IBOutlet weak var apartment_image: UIImageView!
    @IBOutlet weak var apartment_title: UILabel!
    @IBOutlet weak var apartment_description: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        apartment_image.image = UIImage(named: apartamento.imagen)
        apartment_title.text = apartamento.title
        apartment_description.text = apartamento.descripcion

    }
    
    @IBAction func share(_ sender: UIButton) {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.sync {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let bounds = UIScreen.main.bounds
                    UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
                    self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
                    let img = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    let activityViewController = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
                    activityViewController.popoverPresentationController?.sourceView = self.view
                    self.present(activityViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func ventas(_ sender: UIButton) {
        showAlertDialog(mensaje: "Historial de Ventas ToDO")
    }
    
    @IBAction func star1(_ sender: UIButton) {
        showAlertDialog(mensaje: "1 estrella ToDO")
    }
    
    @IBAction func starr2(_ sender: UIButton) {
        showAlertDialog(mensaje: "5 estrella ToDO")
    }
    
    
}
