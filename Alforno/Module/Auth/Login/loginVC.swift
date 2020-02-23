//
//  loginVC.swift
//  Alforno
//
//  Created by Ahmed farid on 2/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class loginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setUpNavColore(_ isTranslucent: Bool){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barStyle = .black
        //self.navigationController?.navigationBar.tintColor = .white
    }
    
    @IBAction func loginBTN(_ sender: Any) {
        let vc = homeVC	(nibName: "homeVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func signupActionButton(_ sender: Any) {
        let vc = signUpVC(nibName: "signUpVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
