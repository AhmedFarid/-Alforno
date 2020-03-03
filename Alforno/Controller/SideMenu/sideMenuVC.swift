//
//  sideMenuVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class sideMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(true)
    }
    
    func setUpNavColore(_ isTranslucent: Bool){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.03921568627, green: 0.1254901961, blue: 0.1921568627, alpha: 1)
    }
    
    @IBAction func homeBTN(_ sender: Any) {
        let vc = homeVC(nibName: "homeVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func menuBTN(_ sender: Any) {
        let vc = menuVC(nibName: "menuVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cartBTN(_ sender: Any) {
    }
    @IBAction func orderBTN(_ sender: Any) {
    }
    @IBAction func favBTN(_ sender: Any) {
        let vc = favouritesVC(nibName: "favouritesVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func profileBTN(_ sender: Any) {
        let vc = profileVC(nibName: "profileVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func contactUSBTN(_ sender: Any) {
        let vc = contactUsVC(nibName: "contactUsVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func aboutUSBTN(_ sender: Any) {
        let vc = aboutUsVC(nibName: "aboutUsVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutBTN(_ sender: Any) {
        helperLogin.dleteAPIToken()
    }
}
