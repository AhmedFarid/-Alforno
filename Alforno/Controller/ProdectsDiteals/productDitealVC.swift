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
    @IBOutlet weak var priceLabel: UILabel!
    
    var singlItem: offfersData?
    var size = [dataSize]()
    var additonal = [offfersData]()
    var additonalId = [Int]()
    var additonaIdsString = String()
    var hide:Bool = true
    var qty = 1
    var isFav = 1
    var isSelcete = false
    var price = 0
    var additonals = 0
    var selectedSize: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scroll.delegate = self
        
        sizeCollectionView.delegate = self
        sizeCollectionView.dataSource = self
        
        addtionalTabelView.delegate = self
        addtionalTabelView.dataSource = self
        
        addtionalTabelView.allowsMultipleSelection = true
        addtionalTabelView.allowsMultipleSelectionDuringEditing = true
        
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
                    let tabelViewHight:CGFloat = CGFloat((74 * self.additonal.count) + 600)
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
                self.priceLabel.text = "\((Int(self.size[0].price ?? "0") ?? 1) * self.qty + self.additonals)"
                self.price = Int(self.size[0].price ?? "0") ?? 0
                self.sizeCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
                //self..selectItem(at: 0, animated: true, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
                self.stopAnimating()
            }
        }
    }
    
    @IBAction func minQtyAction(_ sender: Any) {
        qty = qty - 1
        self.priceLabel.text = "\((self.price + self.additonals) * self.qty)"
        self.qtyText.text = "\(qty)"
        if qty == 1 {
            
            minQtyBTN.isHidden = true
        }else {
            minQtyBTN.isHidden = false
        }
    }
    
    @IBAction func pluseQtyAction(_ sender: Any) {
        qty = qty + 1
        self.priceLabel.text = "\((self.price + self.additonals) * self.qty)"
        self.qtyText.text = "\(qty)"
        if qty == 1 {
            minQtyBTN.isHidden = true
        }else {
            minQtyBTN.isHidden = false
        }
        
    }
    
    @IBAction func addToCartBTN(_ sender: Any) {
        var extra = ""
        additonaIdsString = ""
        if additonalId.count == 0{
            extra = ""
        }else{
            for item in 0...additonalId.count - 1{
                self.additonaIdsString.append(contentsOf: "\(additonalId[item]),")
            }
            extra = String(additonaIdsString.dropLast())
        }
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        cartApi.addCarts(product_id: "\(singlItem?.id ?? 0)", product_quantity: "\(qty)", size_id: "\(selectedSize ?? self.size[0].id ?? 0)", addition_id: extra){ (error, success, addTofav) in
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.price = Int(size[indexPath.row].price ?? "0") ?? 0
        self.priceLabel.text = "\((price + additonals) * qty)"
        self.selectedSize = size[indexPath.row].id
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: sizeCollectionView.frame.size.width / 2.02, height: sizeCollectionView.frame.size.height)
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
            return cell
        }else {
            return productsAdditionsCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !additonalId.contains(additonal[indexPath.row].id ?? 0){
            additonalId.append(additonal[indexPath.row].id ?? 0)
            self.additonals += Int(self.additonal[indexPath.row].priceGeneral ?? "0") ?? 0
            self.priceLabel.text = "\((self.price + self.additonals) * self.qty)"
        }
        print(additonalId)
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        var currentIndex = 0
        for id in additonalId{
            if id == additonal[indexPath.row].id {
                additonalId.remove(at: currentIndex)
                self.additonals -= Int(self.additonal[indexPath.row].priceGeneral ?? "0") ?? 0
                self.priceLabel.text = "\((self.price + self.additonals) * self.qty)"
                break
            }
            currentIndex += 1
        }
        print(additonalId)
    }
}
