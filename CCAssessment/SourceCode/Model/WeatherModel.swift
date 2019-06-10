//
//  WeatherModel.swift
//  CCAssessment
//
//  Created by Waseem on 6/9/19.
//  Copyright © 2019 OVRS. All rights reserved.
//

import UIKit

class WeatherModel: NSObject {

    var cod:String?
    var name:String?
    var imageIcon:String?
    var weather = Array<Any>()
    var weatherDic = [String:Any]()
    var descriptn:String?
    var wind = Dictionary<String,Any>()
    var speed:NSNumber!
    var deg:NSNumber?
     var dateTime:NSNumber?
    var node:String?
    var mainDic = Dictionary<String,Any>()
    var humidity:NSNumber?
    var  pressure:NSNumber?
      var temp:String?
      var temp_max:String?
      var temp_min:String?
    
    
    func getCurrentWeatherObject(weatherObject:[String:Any]){
        
       // self.cod = (weatherObject[JsonParserObject.code]  as! String)
        self.name = weatherObject[JsonParserObject.name] as? String ?? ""
        self.weather = weatherObject[JsonParserObject.weather] as! Array<Any>
        self.mainDic = weatherObject[JsonParserObject.main] as! Dictionary<String,Any>
        self.humidity = (mainDic[JsonParserObject.humidity] as! NSNumber)
        self.pressure = (mainDic[JsonParserObject.pressure] as! NSNumber)
        self.temp = mainDic[JsonParserObject.temp] as? String ?? ""
        self.temp_max = mainDic[JsonParserObject.temp_max] as? String ?? ""
        self.temp_min = mainDic[JsonParserObject.temp_min] as? String ?? ""
        self.weatherDic = weather[0] as! Dictionary<String,Any>
        self.descriptn = weatherDic[JsonParserObject.description] as? String ?? ""
        self.imageIcon = weatherDic[JsonParserObject.icon] as? String ?? ""
         self.wind = weatherObject[JsonParserObject.wind] as! Dictionary<String,Any>
        self.deg = wind[JsonParserObject.deg] as? NSNumber ?? 0
        self.speed = (wind[JsonParserObject.speed] as! NSNumber)
        self.dateTime = (weatherObject[JsonParserObject.dateTime] as! NSNumber)
        
        
        
    }
    
    
    func getForeCastData(weatherObject:[String:Any])
    {
        
    }
    
    func loadWeatherCurrentForecast(urlString:String,controllerView:UIView,parameter:[String:AnyObject],controller:UIViewController,completionHanlder:@escaping((Bool,String,NSDictionary?, NSError?) -> ())) {
        
        WebServiceApiModel.postRequest(urlString: urlString, controllerView: controllerView, parameter: parameter, controller: controller) { (status, message, dictionary, error) in
            
            let statusCode = dictionary![JsonParserObject.code] as! NSNumber
            if statusCode == 200
            {
             completionHanlder(true,"",dictionary,nil)
            }
            print("dictionary: ",dictionary)
            print("mee")
        }
        
    }
    
    func loadWeatherForecast(urlString:String,controllerView:UIView,parameter:[String:AnyObject],controller:UIViewController,completionHanlder:@escaping((Bool,String,NSDictionary?, NSError?) -> ())) {
        
        WebServiceApiModel.postRequest(urlString: urlString, controllerView: controllerView, parameter: parameter, controller: controller) { (status, message, dictionary, error) in
            
            let statusCode = dictionary![JsonParserObject.code] as! NSNumber
            if statusCode == 200
            {
                completionHanlder(true,"",dictionary,nil)
            }
            print("dictionary: ",dictionary)
            print("mee")
        }
        
    }

    
}
