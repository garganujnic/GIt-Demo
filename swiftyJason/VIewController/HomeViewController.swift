//
//  HomeViewController.swift
//  swiftyJason
//
//  Created by MYGOV4 on 24/10/18.
//  Copyright © 2018 MYGOV4. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dashboardCollection: UICollectionView!
    
    var dashboardViewModel: DashboardViewModel = DashboardViewModel()
    let cellIdentifier = "Dashboard_Card"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let screenWidth = UIScreen.main.bounds.size.width
        _ = UIScreen.main.bounds.size.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: screenWidth/2.2, height: screenWidth/2.2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        dashboardCollection!.collectionViewLayout = layout
        
        dashboardViewModel.updateModel(vc: self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadList), name: Notification.Name("DashboardUpdated") , object: nil)
    }
}
   
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardViewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = CollectionViewCell()
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        let card = self.dashboardViewModel.cardsArray[indexPath.row]
        cell.setDashboardData(card: card)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    
    // Reloads the list
    @objc func reloadList(){
        DispatchQueue.main.async {
            self.dashboardCollection.reloadData()
        }
    }
    
    func showLoader(){
       self.activityIndicator.isHidden = false
       self.activityIndicator.startAnimating()
    }
    
    func hideLoader(){
         self.activityIndicator.stopAnimating()
         self.activityIndicator.isHidden = true
    }
}

