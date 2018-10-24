//
//  CollectionViewCell.swift
//  swiftyJason
//
//  Created by MYGOV4 on 24/10/18.
//  Copyright © 2018 MYGOV4. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var SchemeName: UILabel!
    @IBOutlet weak var smallText: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var DataValue: UILabel!

    
    
    func setDashboardData(card:dashboardCard){
        // self.SchemeName.text = card.scheme
        self.smallText.text = card.scheme
        
        let url = card.icon
        self.icon.sd_setImage(with: url)
        // self.DataValue.format = "%d"
        
        let intValue = Int64(card.data_value!)
        print("Float value",intValue!)
        self.DataValue.text = card.pre_data_unit! + (" \(intValue!)")
    }
    
    
}
