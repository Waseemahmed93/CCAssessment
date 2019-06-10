//
//  WeatherForeCastCollectionViewCell.swift
//  CCAssessment
//
//  Created by Waseem on 6/9/19.
//  Copyright © 2019 OVRS. All rights reserved.
//

import UIKit
import AlamofireImage

class WeatherForeCastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherImgIcon: UIImageView!
    
    @IBOutlet weak var tempLbl: UILabel!
    
    
    func setWeatherForeCastData(data:Dictionary<String, Any>)
    {
        self.dayLbl.text = Utility.getTimeStampsForAds(byDate: data["dt"] as! Double)
        let mainDic = data["main"] as! Dictionary<String,Any>
        print("mainDic",mainDic["temp"] as! NSNumber)
        tempLbl.text = "\(mainDic["temp"] as! NSNumber)"
        let weatherarray = data["weather"] as! Array<Any>
        let weatherDic = weatherarray[0] as! Dictionary<String,Any>
        
        let url = NSURL(string: WebServiceApi.weatherImage + "\(weatherDic["icon"] as! String)" + ".png")
        weatherImgIcon.af_setImage(withURL: url! as URL)
    }
}
