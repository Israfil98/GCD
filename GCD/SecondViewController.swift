//
//  SecondViewController.swift
//  GCD
//
//  Created by Исрафил Гусейнов on 11.03.2020.
//  Copyright © 2020 Исрафил Гусейнов. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        delay(5) {
            self.logInAlert()
        }
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func logInAlert() {
        let ac = UIAlertController(title: "Зарегистрированы?", message: "Введите логин и пароль", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        ac.addAction(okButton)
        ac.addAction(cancelButton)
        
        ac.addTextField { (userNameTF) in
            userNameTF.placeholder = "Введите логин"
        }
        
        ac.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Введите пароль"
            userPasswordTF.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://avatars.mds.yandex.net/get-pdb/1641066/f247a7ec-0836-403c-a399-1026b233f20c/s1200?webp=false")
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
