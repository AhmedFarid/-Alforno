//
//  signUpVC.swift
//  Alforno
//
//  Created by Ahmed farid on 2/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class signUpVC: UIViewController  {
    
    var hide:Bool = true
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var fullNameText: UITextField!
    @IBOutlet weak var scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.delegate = self
        customNB()
    }
    
    
    func customNB() {
           let backImage = UIImage(named: "BACK-1")
           self.navigationController?.navigationBar.backIndicatorImage = backImage
           self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
           self.navigationController?.navigationBar.backItem?.title = ""
       }
    
    
    @IBAction func registerBtnAction(_ sender: Any) {
        
        registerApi.register(name: fullNameText.text ?? "", phone: phoneText.text ?? "", email: emailText.text ?? "", password: passwordText.text ?? "") { (error, success, Register) in
            if success {
                if Register?.status == false{
                    self.showAlert(title: "Sign Up", message: "Faild your mail is used")
                }else{
                    let login = Register?.data
                    print(login?.email ?? "")
                }
            }else {
                self.showAlert(title: "SignUp", message: "Check your network")
            }
        }
    }
}

extension signUpVC: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y>0) {
            //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
            UIView.animate(withDuration: 1.0, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.hide = false
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 1.0, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.hide = true
            }, completion: nil)
        }
    }
}
