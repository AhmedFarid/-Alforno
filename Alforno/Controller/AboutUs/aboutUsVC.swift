//
//  aboutUsVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/3/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SideMenu

class aboutUsVC: UIViewController, NVActivityIndicatorViewable {
    
    var about = [Datum]()
    
    @IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var decs: UILabel!
    @IBOutlet weak var viewHight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutHandelRefresh()
        setUpNav()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewHight.constant = self.imageBack.frame.size.height + self.decs.frame.size.height + self.titles.frame.size.height
    }
    
    func setUpNav() {
        let nvImageTitle = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        nvImageTitle.contentMode = .scaleAspectFit
        let imageName = UIImage(named: "XMLID_1_")
        nvImageTitle.image = imageName
        navigationItem.titleView = nvImageTitle
        
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "menu-1"), style: .done, target: self, action: #selector(aboutUsVC.sideMenu))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "bag nav"), style: .done, target: self, action: #selector(aboutUsVC.showCart))
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
    
    
    func aboutHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        aboutApi.aboutApi{ (error,networkSuccess,codeSucess,about) in
            if networkSuccess {
                if codeSucess {
                    if about?.status == true {
                        if let about = about{
                            self.about = about.data ?? []
                            print("zzzz\(about)")
                            self.titles.text = self.about[0].title
                            self.decs.text = self.about[0].datumDescription
                            //self.viewHight.constant = self.imageBack.frame.size.height + self.decs.frame.size.height + self.titles.frame.size.height
                            self.stopAnimating()
                        }else {
                            self.stopAnimating()
                            self.showAlert(title: "Error", message: "Error favorite")
                        }
                    }else {
                        self.stopAnimating()
                        self.showAlert(title: "Favorite", message: "Error favorite")
                    }
                }else {
                    self.stopAnimating()
                    self.showAlert(title: "Favorite", message: "Favorite is empty")
                }
            }else {
                self.stopAnimating()
                self.showAlert(title: "Network", message: "Check your network connection")
            }
        }
    }
    
    
}
