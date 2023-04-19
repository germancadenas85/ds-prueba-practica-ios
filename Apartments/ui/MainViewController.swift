//
//  MainViewController.swift
//  Apartments
//
//  Created by German Cadenas on 19/04/23.
//

import UIKit
import Firebase
import FirebaseDatabase


class cellApartment: UICollectionViewCell {
    @IBOutlet weak var apartment_image: UIImageView!
    @IBOutlet weak var apartment_title: UILabel!
    @IBOutlet weak var apartment_description: UILabel!
}

class Apartment : NSObject {
    private var _imagen: String!
    private var _title: String!
    private var _descripcion: String?
    private var _latitude: Float? = 0
    private var _longitude: Float? = 0
    private var _recomendation: Int? = 0
    private var _key: String? = ""
    
    var imagen: String! {
        get {
            return _imagen
        } set {
            _imagen = newValue
        }
    }
    
    var title : String! {
        get {
            return _title
        } set {
            _title = newValue
        }
    }

    var descripcion : String! {
        get {
            return _descripcion
        } set {
            _descripcion = newValue
        }
    }
    
    var latitude : Float? {
        get {
            return _latitude
        } set {
            _latitude = newValue
        }
    }
    
    var longitude : Float? {
        get {
            return _longitude
        } set {
            _longitude = newValue
        }
    }
    
    var recomendation : Int? {
        get {
            return _recomendation
        } set {
            _recomendation = newValue
        }
    }
    
    var key : String? {
        get {
            return _key
        } set {
            _key = newValue
        }
    }
    
    override init() {
        
    }
    
    init(data: [String : Any]){
        print(data)
        self._imagen = data["imagen"] as? String
        self._title = data["title"] as? String
        self._descripcion = data["descripcion"] as? String
        self._recomendation = data["recomendation"] as? Int
    }
    
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var form_title: UILabel!
    @IBOutlet weak var progress: UIActivityIndicatorView!

    var ref: DatabaseReference!
    
    var dataArray = [Apartment]()
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self

        ref = Database.database().reference().child("apartments_table")
        
        ref.observe(.value, with: { snapshot in
            self.dataArray.removeAll()
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let data = snapshot.value as? [String: Any] {
                    self.dataArray.append(Apartment(data:data))
                }
            }
            
            self.collection.reloadData()
            self.progress.isHidden = true
        })
    }
    
    @IBAction func recomendados(_ sender: UIButton) {
        showAlertDialog(mensaje: "Recomendados ToDO")
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView( _ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! cellApartment
        let data = dataArray[indexPath.row]
        cell.apartment_title.text = data.title
        cell.apartment_description.text = data.descripcion
        cell.apartment_image.image = UIImage(named: data.imagen)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collection.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let seleccion = dataArray[indexPath.row]
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: "detalle_from") as! DetallesViewController
        vc.apartamento = seleccion
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
