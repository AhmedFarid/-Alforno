//
//  contactUsVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/3/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SideMenu

class contactUsVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var message: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        message.delegate = self
        message.text = "Message"
        message.textColor = UIColor.lightGray
        setUpNav()
        
    }
    
    func setUpNav() {
        let nvImageTitle = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        nvImageTitle.contentMode = .scaleAspectFit
        let imageName = UIImage(named: "XMLID_1_")
        nvImageTitle.image = imageName
        navigationItem.titleView = nvImageTitle
        
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "menu-1"), style: .done, target: self, action: #selector(contactUsVC.sideMenu))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "bag nav"), style: .done, target: self, action: #selector(contactUsVC.showCart))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    @objc func sideMenu() {
        let menu = UIStoryboard(name: "sideMenu", bundle: nil).instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = view.frame.size.width - 50
        
        present(menu, animated: true, completion: nil)
    }
    
    @objc func showCart() {
        print("print")
        
    }
    
    
    @IBAction func sendAction(_ sender: Any) {
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        contactUsApi.message(name: name.text ?? "", email: email.text ?? "", phone: phone.text ?? "", message: message.text ?? "") { (error, success, addTofav) in
            if success {
                self.stopAnimating()
                self.showAlert(title: "contact us", message: addTofav?.data ?? "")
            }else {
                self.showAlert(title: "contact us", message: "Check your network")
                self.stopAnimating()
            }
        }
        
    }
}

extension contactUsVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Message"
            textView.textColor = UIColor.lightGray
        }
    }
}
