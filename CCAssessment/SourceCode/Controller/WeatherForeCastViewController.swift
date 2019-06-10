//
//  WeatherForeCastViewController.swift
//  CCAssessment
//
//  Created by Waseem on 6/8/19.
//  Copyright © 2019 OVRS. All rights reserved.
//

import UIKit

class WeatherForeCastViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var humidityvalueLbl: UILabel!
    @IBOutlet weak var preciptiationLbl: UILabel!
    @IBOutlet weak var preciptionValueLbl: UILabel!
    @IBOutlet weak var degreeLbl: UILabel!
    @IBOutlet weak var descbLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    
    
    @IBOutlet weak var weathericon: UIImageView!
    
    
    let weatherObj = WeatherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadWeatherData()
        // Do any additional setup after loading the view.
    }
    

    func loadWeatherData()
    {
        let lat = LocationService.shared.currentLocation.latitude
        let lon = LocationService.shared.currentLocation.longitude
        
        weatherObj.loadWeatherCurrentForecast(urlString: WebServiceApi.weatherCurrent + "appid=\(ThirdPartApiKeys.openWeatherAPIKey)&lat=\(lat)&lon=\(lon)", controllerView: self.view, parameter: ["":"" as AnyObject], controller: self) { (status, message, dictionary, error) in
            
            if status
            {
                self.weatherObj.getCurrentWeatherObject(weatherObject: dictionary as! [String : Any])
             self.loadData()
            }
        }
    }
    
    
    
    func loadData()
    {
      
        self.cityLbl.text = self.weatherObj.name
        self.dayLbl.text = Utility.getTimeStamps(byDate: self.weatherObj.dateTime as! Double)
        self.descbLbl.text = self.weatherObj.descriptn
        self.degreeLbl.text = String(self.weatherObj.deg as! Int)
        self.windLbl.text = "Wind"
        self.windSpeedLbl.text = "\(self.weatherObj.speed ?? 0)" + " km/h"
        self.humidityLbl.text = "Humidity"
        self.humidityvalueLbl.text = String(self.weatherObj.humidity as! Int) + "%"
        self.preciptiationLbl.text = "Precipitation"
        self.preciptionValueLbl.text = String(self.weatherObj.pressure as! Int)  + "%"
  
        let url = NSURL(string: WebServiceApi.weatherImage + self.weatherObj.imageIcon! + ".png")
        weathericon.af_setImage(withURL: url! as URL)
    }
    
    func loadForecastData()
    {
        
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

extension WeatherForeCastViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherForeCastCollectionViewCell", for: indexPath) as! WeatherForeCastCollectionViewCell
        return cell
    }
    
    
}
