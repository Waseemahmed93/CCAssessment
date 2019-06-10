//
//  HomeDetailViewController.swift
//  CCAssessment
//
//  Created by Waseem on 6/7/19.
//  Copyright © 2019 OVRS. All rights reserved.
//

import UIKit

class HomeDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadWeatherData()
        LocationService.shared.startTrackingLocation()
        // Do any additional setup after loading the view.
    }
    
    
    func loadWeatherData()
    {
        //https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=1500&type=restaurant&keyword=cruise&key=YOUR_API_KEY
       
        WebServiceApiModel.postRequestGoogleApi(urlString:"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(LocationService.shared.currentLocation.latitude),\(LocationService.shared.currentLocation.longitude)&radius=150000&type=restaurant&keyword=cruise&key=AIzaSyBTOTeRRHPO83OxrscCrTtlU-I5BD1t-_Y" , controllerView: self.view, parameter: ["":"" as AnyObject], controller: self) { (status, message, dictionary, error) in
            
                if status
                {
                    
                }
                print("mee")
            }
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
