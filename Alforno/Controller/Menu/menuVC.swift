//
//  menuVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import SideMenu
import NVActivityIndicatorView


class menuVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var menuTabelView: UITableView!
    
    var menus = [catData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        
        menuTabelView.delegate = self
        menuTabelView.dataSource = self
        self.menuTabelView.register(UINib(nibName: "menuCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        catsHandelRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavColore(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setUpNavColore(false)
    }
    
    func setUpNavColore(_ isTranslucent: Bool){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.03921568627, green: 0.1254901961, blue: 0.1921568627, alpha: 1)
    }
    
    
    func catsHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        mnueApi.mnue{ (error,success,menus) in
            if let menus = menus{
                self.menus = menus.data ?? []
                print(menus)
                self.menuTabelView.reloadData()
                self.stopAnimating()
            }
         self.stopAnimating()
        }
        
    }
    
    func setUpNav() {
//        let nvImageTitle = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        nvImageTitle.contentMode = .scaleAspectFit
//        let imageName = UIImage(named: "XMLID_1_")
//        nvImageTitle.image = imageName
//        navigationItem.titleView = nvImageTitle
        
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "menu-1"), style: .done, target: self, action: #selector(homeVC.sideMenu))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "bag nav"), style: .done, target: self, action: #selector(homeVC.showCart))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    @objc func sideMenu() {
        let menu = UIStoryboard(name: "sideMenu", bundle: nil).instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
        menu.presentationStyle = .menuSlideIn
        present(menu, animated: true, completion: nil)
    }
    
    @objc func showCart() {
        print("print")
        
    }
}


extension menuVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = menuTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? menuCell {
            cell.configureCell(menus:  menus[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return menuCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = allProdectsVC(nibName: "allProdectsVC", bundle: nil)
        vc.singelItem = menus[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
}
