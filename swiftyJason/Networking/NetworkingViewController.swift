//
//  NetworkingViewController.swift
//  swiftyJason
//
//  Created by MYGOV4 on 24/10/18.
//  Copyright © 2018 MYGOV4. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class NetworkingViewController: NSObject {
    
    func getData(urlString : String ,compHandler:@escaping (NSArray?,Bool)->Void ){
        Alamofire.request(urlString).responseJSON { (resData) in
            print(resData.result.value!)
            if resData.result.isFailure{
                compHandler(nil, false)
            }
            else{
                let swiftyJsonVar = resData.result.value as! NSArray
                print(swiftyJsonVar)
                compHandler(swiftyJsonVar, true)
            }
            
        }
    }
}
