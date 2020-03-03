//
//  productDitealVC.swift
//  Alforno
//
//  Created by Ahmed farid on 2/27/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class productDitealVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var smallDec: UILabel!
    @IBOutlet weak var allDiscr: UILabel!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var plusQtyBTN: UIButton!
    @IBOutlet weak var minQtyBTN: UIButton!
    @IBOutlet weak var qtyText: UITextField!
    @IBOutlet weak var viewHight: NSLayoutConstraint!
    @IBOutlet weak var addtionalTabelView: UITableView!
    
    var singlItem: offfersData?
    var size = [dataSize]()
    var additonal = [offfersData]()
    var hide:Bool = true
    var qty = 1
    var isFav = 1
    var isSelcete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scroll.delegate = self
        
        sizeCollectionView.delegate = self
        sizeCollectionView.dataSource = self
        
        addtionalTabelView.delegate = self
        addtionalTabelView.dataSource = self
        
        self.sizeCollectionView.register(UINib.init(nibName: "productSizeCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.addtionalTabelView.register(UINib.init(nibName: "productsAdditionsCell", bundle: nil), forCellReuseIdentifier: "cell")
        //isFav = singlItem?.wishlistState ?? 0
        
        customNB()
        setUpData()
        sizesHandelRefresh()
        offersHandelRefresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    func offersHandelRefresh(){
        productDitealsAPi.productsAdditions(product_id: "\(singlItem?.id ?? 0)"){ (error,success,additonal) in
            if success {
                if let additonal = additonal{
                    self.additonal = additonal.data ?? []
                    self.addtionalTabelView.reloadData()
                    let tabelViewHight:CGFloat = CGFloat((74 * self.additonal.count) + 555)
                    self.viewHight.constant = self.imageView.frame.size.height + self.smallDec.frame.size.height + self.allDiscr.frame.size.height + tabelViewHight
                    print(additonal)
                }else {
                    
                }
            }else {
            }
        }
    }
    
    func setUpData(){
        self.titleProduct.text = singlItem?.title
        self.smallDec.text = singlItem?.shortDescription
        self.allDiscr.text = singlItem?.offerDescription
        let urlWithoutEncoding = ("\(URLs.mainImage)\(singlItem?.image ?? "")")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        imageView.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            imageView.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
    func customNB() {
        
        let nvImageTitle = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        nvImageTitle.contentMode = .scaleAspectFit
        let imageName = UIImage(named: "XMLID_1_")
        nvImageTitle.image = imageName
        navigationItem.titleView = nvImageTitle
        
        let backImage = UIImage(named: "BACK-1")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.backItem?.title = ""
        
        if isFav == 1 {
            let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 257"), style: .done, target: self, action: #selector(productDitealVC.addToFav))
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
        }else {
            let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 258"), style: .done, target: self, action: #selector(productDitealVC.addToFav))
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    
    @objc func addToFav() {
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        favoriteAPI.add(product_id: "\(singlItem?.id ?? 0)") { (error, success, addTofav) in
            if success {
                if addTofav?.status == true {
                    if self.isFav == 0 {
                        self.isFav = 1
                        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 257"), style: .done, target: self, action: #selector(productDitealVC.addToFav))
                        self.navigationItem.rightBarButtonItem = rightBarButtonItem
                        self.stopAnimating()
                    }else if self.isFav == 1 {
                        self.isFav = 0
                        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 258"), style: .done, target: self, action: #selector(productDitealVC.addToFav))
                        self.navigationItem.rightBarButtonItem = rightBarButtonItem
                        self.stopAnimating()
                    }
                }else {
                    self.showAlert(title: "Favorite", message: addTofav?.data ?? "")
                    self.stopAnimating()
                }
            }else {
                self.showAlert(title: "Favorite", message: "Check your network")
                self.stopAnimating()
            }
        }
        
    }
    
    func sizesHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        productDitealsAPi.productSizes(product_id: "\(singlItem?.id ?? 0)"){ (error,success,size) in
            if let size = size{
                self.size = size.data ?? []
                print(size)
                self.sizeCollectionView.reloadData()
                self.stopAnimating()
            }
        }
    }
    
    @IBAction func minQtyAction(_ sender: Any) {
        qty = qty - 1
        self.qtyText.text = "\(qty)"
        if qty == 1 {
            minQtyBTN.isHidden = true
        }else {
            minQtyBTN.isHidden = false
        }
    }
    
    @IBAction func pluseQtyAction(_ sender: Any) {
        qty = qty + 1
        self.qtyText.text = "\(qty)"
        if qty == 1 {
            minQtyBTN.isHidden = true
        }else {
            minQtyBTN.isHidden = false
        }
        
    }
    
}


extension productDitealVC: UIScrollViewDelegate {
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


extension productDitealVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return size.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = sizeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? productSizeCell{
            cell.configureCell(sizes: size[indexPath.row])
            return cell
        }else {
            return productSizeCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: sizeCollectionView.frame.size.width / 2, height: sizeCollectionView.frame.size.height)
    }
}


extension productDitealVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return additonal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = addtionalTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? productsAdditionsCell {
            cell.configureCell(offer: additonal[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.chech = {
                if self.isSelcete == false{
                    self.isSelcete = true
                    cell.chechOutlet.setImage(UIImage(named: "Group 19"), for: .normal)
                }else {
                    self.isSelcete = false
                    cell.chechOutlet.setImage(UIImage(named: "Group 19-1"), for: .normal)
                }
            }
            
            return cell
        }else {
            return productsAdditionsCell()
        }
    }
}
