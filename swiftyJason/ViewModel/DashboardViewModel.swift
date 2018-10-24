//
//  DashboardViewModel.swift
//  swiftyJason
//
//  Created by MYGOV4 on 24/10/18.
//  Copyright © 2018 MYGOV4. All rights reserved.
//


import UIKit

class DashboardViewModel: NSObject {
    
    var cardsArray = [dashboardCard]()
    var cardsArr: [[String: Any]]! = nil
    
    func updateModel(vc: UIViewController) {
        //Start loader to wait for response
        DispatchQueue.main.async {
            
        }
            // GET DATA FROM SERVER
            //Call the web service to update the model
      
            DashboardModel.getDataFromServer { (dashboardModel,success) in
                if success{
                    //Process on live data
                    self.cardsArr = dashboardModel?.arCards as! [[String : Any]]
                    self.setData(onView: vc)
                }
                else{
                    //failure case
                    self.showAlertMessage(viewController: vc, title: "Error", msg: "There is an error fetching data!")
                }
            }
    }
    
    // returns the total number of news sources
    func numberOfRowsInSection() -> Int {
        return self.cardsArray.count
    }
    
    func setData(onView: UIViewController){
        let shuffuledArray =  cardsArr! as NSArray

        for i in 0...shuffuledArray.count-1{
            var cardDict = dashboardCard()
            cardDict.scheme = (shuffuledArray[i] as! NSDictionary).value(forKey: "scheme") as? String
            let  urlString = (shuffuledArray[i] as! NSDictionary).value(forKey: "icon") as! String
            let url = URL(string: urlString)
            cardDict.icon = url
            cardDict.data_value = (shuffuledArray[i] as! NSDictionary).value(forKey: "data_value") as? String
            cardDict.pre_data_unit = (shuffuledArray[i] as! NSDictionary).value(forKey: "pre_data_unit") as? String
            cardDict.data_unit = (shuffuledArray[i] as! NSDictionary).value(forKey: "data_unit") as? String
            cardDict.small_text = (shuffuledArray[i] as! NSDictionary).value(forKey: "small_text") as? String
            cardDict.date = (shuffuledArray[i] as! NSDictionary).value(forKey: "date") as? String
            cardDict.web_link = (shuffuledArray[i] as! NSDictionary).value(forKey: "web_link") as? String
            self.cardsArray.append(cardDict)
        }

        //post the notification to update the view
        NotificationCenter.default.post(name: Notification.Name("DashboardUpdated"), object: nil)
        
        // Stop the loader in main thread
        DispatchQueue.main.async {
            //hide the loader
            //shareDeleagte.hideLoader(onView: onView)
        }
    }
    
    func showAlertMessage(viewController: UIViewController, title: String, msg: String) {
        let alert = UIAlertController (title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        viewController.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
    }
    
}


