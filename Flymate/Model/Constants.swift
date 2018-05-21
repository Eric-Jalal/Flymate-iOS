//
//  Constants.swift
//  Flymate
//
//  Created by AmirMacbook on 5/20/18.
//  Copyright © 2018 AmirMacbook. All rights reserved.
//

import Foundation
import Alamofire

class Constants {
    
    static let sharedInstanc = Constants()
    private let lockQueue = DispatchQueue(label: "Constants.lockQueue")
    private let fixedString = "https://api.darksky.net/forecast/ac4c35b7945c6a2eebb2e27a53ab7b52/"
    
    private var _requestTail : String
    var requestTail : String {
        get {
            return lockQueue.sync {return _requestTail}
        } set {
            lockQueue.sync {_requestTail = newValue}
        }
    }

    var requestString : String {
        get {
            return lockQueue.sync {fixedString + _requestTail}
        }
    }
    
    private init () {
        _requestTail = "60.1698664,24.937643,19"
    }
}
