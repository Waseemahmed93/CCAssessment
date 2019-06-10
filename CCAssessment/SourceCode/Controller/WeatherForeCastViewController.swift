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
    
     let itemsPerRow: CGFloat = 3
     let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    var lat = LocationService.shared.currentLocation.latitude
    var lon = LocationService.shared.currentLocation.longitude
    var foreCastData = Array<Any>()
    @IBOutlet weak var weathericon: UIImageView!
    
    
    let weatherObj = WeatherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.setUpCollectionOptions()
        self.loadWeatherData()
        // Do any additional setup after loading the view.
    }
    

    func loadWeatherData()
    {
        
        
        weatherObj.loadWeatherCurrentForecast(urlString: WebServiceApi.weatherCurrent + "appid=\(ThirdPartApiKeys.openWeatherAPIKey)&lat=\(lat)&lon=\(lon)", controllerView: self.view, parameter: ["":"" as AnyObject], controller: self) { (status, message, dictionary, error) in
            
            if status
            {
                self.weatherObj.getCurrentWeatherObject(weatherObject: dictionary as! [String : Any])
             self.loadData()
                self.loadForecastData()
            }
        }
    }
    
    
    
    func loadData()
    {
      
        self.cityLbl.text = self.weatherObj.name
        self.dayLbl.text = Utility.getTimeStampsForAds(byDate: self.weatherObj.dateTime as! Double)
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
        weatherObj.loadWeatherForecast(urlString: WebServiceApi.weatherForeCastUrl + "appid=\(ThirdPartApiKeys.openWeatherAPIKey)&lat=\(lat)&lon=\(lon)", controllerView: self.view, parameter: ["":"" as AnyObject], controller: self) { (status, message, dictionary, error) in
            
            if status
            {
               
                self.foreCastData = dictionary!["list"] as! Array<Any>
                self.collectionView.reloadData()
            }
        }
     
       
    }
    
    func setUpCollectionOptions(){
        
        
        
        let nibCell = UINib(nibName: WeatherForeCastCollectionViewCell.nameOfClass(), bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: WeatherForeCastCollectionViewCell.nameOfClass())
        if let flowLayout = collectionView.setCollectionViewLayout as? UICollectionViewFlowLayout
        {
            flowLayout.estimatedItemSize = CGSize(width: 100, height: 100)
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

extension WeatherForeCastViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foreCastData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherForeCastCollectionViewCell", for: indexPath) as! WeatherForeCastCollectionViewCell
        cell.setWeatherForeCastData(data: foreCastData[indexPath.row] as! Dictionary<String,Any>)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow


        return CGSize(width: widthPerItem, height: widthPerItem + 20)
    }

    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
