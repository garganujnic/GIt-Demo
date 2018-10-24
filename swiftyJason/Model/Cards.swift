//
//  Cards.swift
//  swiftyJason
//
//  Created by MYGOV4 on 24/10/18.
//  Copyright © 2018 MYGOV4. All rights reserved.
//

import UIKit

struct dashboardCard {
    var scheme: String?
    var small_text : String?
    var pre_data_unit: String?
    var data_unit : String?
    var icon: URL?
    var data_value: String?
    var date : String?
    var web_link : String?
}


struct DashboardModel {
    var arCards : NSMutableArray
    var cards : [dashboardCard]?
    
    init(arCards : NSMutableArray) {
        self.arCards = arCards
    }
}

extension DashboardModel{
    
    public static func getDataFromServer(compHandler:@escaping (DashboardModel?,Bool)->Void ){
        let urlString = "https://48months.mygov.in/wp-content/uploads/dashboard.json"
        
        let networkConnection = NetworkingViewController()
        networkConnection.getData(urlString: urlString) { (cardsArray, success) in
            if success{
                let dashboardModel = DashboardModel(arCards: NSMutableArray(array: cardsArray!) )
                print("Dashboard model\(dashboardModel)")
                compHandler(dashboardModel,true)
            }
            else{
                // prompt error
                compHandler(nil,false)
            }            
        }
    }
   
   
    
}
