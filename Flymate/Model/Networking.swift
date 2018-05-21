//
//  Networking.swift
//  Flymate
//
//  Created by AmirMacbook on 5/20/18.
//  Copyright © 2018 AmirMacbook. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Networking {
    
    static let sharedInstance = Networking()
    private var request : String = Constants.sharedInstanc.requestString
    private let lockQueue = DispatchQueue(label: "Networking.lockQueue")
    private var _jsonResponse : [String : Any]
    
    var jsonResponse: [String : Any] {
        get {
            return lockQueue.sync {
                _jsonResponse
            }
        }
    }
    
    func handleTheRequest(callback: @escaping ([String:Any])->()) {

        Alamofire.request(request).responseJSON { (response) in
            print(response.result.value)
            do {
                let json = try JSON(data: response.data!)
                self._jsonResponse["timeZone"] = json["timezone"].string
                //print("this is the time zone : \(timeZone1)")
                
                let currently = json["currently"]
                self._jsonResponse["temp"] = currently["temperature"].double
                self._jsonResponse["humidity"] = currently["humidity"].double
                self._jsonResponse["windSpeed"] = currently["windSpeed"].double
                callback(self._jsonResponse)
            } catch {
            
            }
            
        }
//
//      Alamofire.request(request).validate().responseJSON { response in
//        print("JSON:\(String(describing: response.result.value))")
//            switch(response.result) {
//            case .success(_):
//                if let data = response.result.value{
//    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
//    {
//
//    }
//    else{
//
//                    }
//                    print(data)
//                }
//
//            case .failure(_):
//
//                print("Error message:\(String(describing: response.result.error))")
//                break
//
//            }
//            }
//
//        Alamofire.request(request).validate().responseJSON { (response) in
//            switch response.result {
//
//            case .success(_):
//                let data = response.result.value
//                do {
//
//                                guard let jsonData = try? JSONDecoder().decode(jsonBlock.self, from: response.result.value as! Data) else {
//
//                                    print("error decoding the json...")
//                                    return
//                                }
//
//                } catch let error as NSError {
//
//
//
//                    print(error)
//                }
//                break
//
//            case .failure(_): break
//
//            }
////
//            print("this is the response result: \(response.result)")
//            print(response.result.value)
//            //jsonTmp = JSON(response.result.value)
////            guard let jsonData = try? JSONDecoder().decode(jsonBlock.self, from: response.result.value as! Data) else {
////
////                print("error decoding the json...")
////                return
////            }
//
//            if let jsonResult = response.data, let utf8Text = String(data: jsonResult, encoding: .utf8) {
//                print(jsonResult)
//            }
//        }
    }
    
    private init() {
        _jsonResponse = ["test":"test"]
    }
}
