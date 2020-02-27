//
//  homeVC.swift
//  Alforno
//
//  Created by Ahmed farid on 2/19/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class homeVC: UIViewController {
    
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var offerTabelVIew: UITableView!
    @IBOutlet weak var bageControl: UIPageControl!
    @IBOutlet weak var countOFOffers: UILabel!
    
    var slider = [dataSlider]()
    var offers = [offfersData]()
    var timer : Timer?
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        setUpNavColore(true)
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        offerTabelVIew.delegate = self
        offerTabelVIew.dataSource = self
        
        
        self.bannerCollectionView.register(UINib.init(nibName: "homeBannerCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.offerTabelVIew.register(UINib(nibName: "offerCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        sliderHandelRefresh()
        offersHandelRefresh()
        startTimer()
        
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
    
    func setUpNav() {
        let nvImageTitle = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        nvImageTitle.contentMode = .scaleAspectFit
        let imageName = UIImage(named: "XMLID_1_")
        nvImageTitle.image = imageName
        navigationItem.titleView = nvImageTitle
        
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "menu-1"), style: .done, target: self, action: #selector(homeVC.sideMenu))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "bag nav"), style: .done, target: self, action: #selector(homeVC.showCart))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    @objc func sideMenu() {
        print("print")
        
    }
    
    @objc func showCart() {
        print("print")
        
    }
    
    
    func sliderHandelRefresh(){
        homeApi.sliderApi{ (error,success,slider) in
            if let slider = slider{
                self.slider = slider.data ?? []
                print(slider)
                self.bageControl.numberOfPages = self.slider.count
                self.bageControl.currentPage = 0
                self.bannerCollectionView.reloadData()
            }
        }
    }
    
    func offersHandelRefresh(){
        homeApi.offersApi{ (error,success,offers) in
            if let offers = offers{
                self.offers = offers.data ?? []
                print(offers)
                self.countOFOffers.text = ("\(self.offers.count) Dishes")
                self.offerTabelVIew.reloadData()
            }
        }
    }
    
    func startTimer(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        
        if currentIndex < slider.count {
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            bageControl.currentPage = currentIndex
            currentIndex += 1
        } else {
            currentIndex = 0
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.bannerCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            bageControl.currentPage = currentIndex
            currentIndex = 1
        }
        
    }
    
}

extension homeVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = offerTabelVIew.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? offerCell {
        cell.configureCell(offer: offers[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
        }else {
            return offerCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
        
    }
}

extension homeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("print")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slider.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? homeBannerCell {
            cell.configureCell(images: slider[indexPath.row])
            return cell
        }else {
            return homeBannerCell()
        }
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    //    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: bannerCollectionView.frame.size.width, height: bannerCollectionView.frame.size.height)
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 16.0
    //    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 16.0
    //
    //    }
}



