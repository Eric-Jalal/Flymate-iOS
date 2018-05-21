//
//  ViewController.swift
//  Flymate
//
//  Created by AmirMacbook on 5/20/18.
//  Copyright © 2018 AmirMacbook. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initializeRequest = Constants.sharedInstanc
        let networking = Networking.sharedInstance.handleTheRequest(callback: {(result) in
            DispatchQueue.main.async {
                self.updateUI(result: result)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateUI(result: [String : Any]) {
        
        
       
        var stringFromDouble:String = String(format:"%.1f", result["temp"] as! CVarArg)
        tempLabel.text = stringFromDouble + "°"
        windSpeed.text = String(format:"%.1f", result["windSpeed"] as! CVarArg) 
        humidityLabel.text = String(format:"%.1f", result["humidity"] as! CVarArg) + "%"
        locationLabel.text = result["timeZone"] as! String
        updateViewConstraints()
        loadViewIfNeeded()
    }
}

