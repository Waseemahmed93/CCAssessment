//
//
//  FILE: LocationService.swift
//  AUTHOR: Can Sürmeli (c_surmeli@icloud.com - cansurmeli.com)
//  DESCRIPTION: How to use CLLocationManager as a singleton object with Swift. Modify according
//  to your needs.
//  SOURCE: https://github.com/cansurmeli/Singleton-CLLocationManager
//
//
//  IMPORTANT
//	  You MUST include one of the keys below in your Info.plist file with an appropiate description
//	according to the respected permission you've asked for. Otherwise CoreLocation won't function!
//
//	  - NSLocationWhenInUseUsageDescription - <your_description>
//	  - NSLocationAlwaysUsageDescription - <your_description>					(required by iBeacon usage)
//

import Foundation
import CoreLocation
import UIKit


protocol TodoDelegate: class {
    func completed(todo: Bool)
}

class LocationService: NSObject, CLLocationManagerDelegate {
  static let shared = LocationService()     // Swifty way of singleton :]
  
    
    var locationFoundBlock: ((_ latitude: String,_ longitude:String)->())?

	// set the manager object right when it gets initialized
  let manager: CLLocationManager = {
        $0.desiredAccuracy = kCLLocationAccuracyBest
        $0.distanceFilter = kCLLocationAccuracyBest
        $0.requestWhenInUseAuthorization()
        $0.allowsBackgroundLocationUpdates = true
        return $0
    }(CLLocationManager())

     var zoomLevel: Float = 15.0
    // var camera = GMSCameraPosition()

    
  private(set) var currentLocation: CLLocationCoordinate2D!
	private(set) var currentHeading: CLHeading!

  private override init() {
    super.init()
    manager.delegate = self
  }
    
    // start tracking
    func startTrackingLocation(){

        LocationService.shared.escalateLocationServiceAuthorization()
        // updates MUST start here
        manager.delegate = self
        manager.startUpdatingLocation()
//        manager.startUpdatingHeading()
    }
    
    func trackLocation(locationFound: @escaping ((_ latitude: String, _ longitude:String)->())){
        LocationService.shared.escalateLocationServiceAuthorization()
        // updates MUST start here
        locationFoundBlock = locationFound
        
         manager.delegate = self
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()

    }
    
    func stopTrackingLocation(){
        
//locationFoundBlock = nil
        manager.delegate = nil
        manager.stopUpdatingLocation()
        manager.stopUpdatingHeading()
    }
    
    
    func escalateLocationServiceAuthorization() {
        // Escalate only when the authorization is set to when-in-use
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            manager.requestAlwaysAuthorization()
        }
       
    }

    func locationNotEnableAlertMessage(onController:UIViewController){
        //WarningMessages.LocationWarning
        let alert = UIAlertController(title: "", message: "Allow App to access your location While you are using the UPull App", preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { action -> Void in
            //Just dismiss the action sheet
        })
        
        let okAction = UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action -> Void in
            //Just dismiss the action sheet
            Utility.goToApplicationSettings()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        onController.present(alert, animated: false, completion: nil)
    }
    
    
    func getLocationServiceStatus()->(CLAuthorizationStatus) {
        return CLLocationManager.authorizationStatus()
    }



  // MARK: Location Updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // If location data can be determined
       // print("didUpdateLocations")
        if let location = locations.last! as CLLocation! {
            
            print("location.coordinate.latitude :",location.coordinate.latitude)
         
            let latFloat = location.coordinate.latitude //+ Double(kRandom)
            let lonFloat = location.coordinate.longitude //+ Double(kRandom)
            
            
            _ = "\(latFloat)" + "," + "\(lonFloat)"
            if locationFoundBlock != nil{
                locationFoundBlock!("\(latFloat)","\(lonFloat)")
            }
            currentLocation = location.coordinate
            
            
        }
  }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Location Manager Error: \(error)")
  }

  // MARK: Heading Updates
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        currentHeading = newHeading
  }

    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
    return true
  }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {   switch status {
    case .restricted, .denied:
        // Disable your app's location features
      
        print("restricted, denied from didChangeAuthorization")
        break
        
    case .authorizedWhenInUse:
        // Enable only your app's when-in-use features.
        print("enableMyWhenInUseFeatures from didChangeAuthorization")
        startTrackingLocation()
        break
        
    case .authorizedAlways:
        // Enable any of your app's location services.
        print("authorizedAlways from didChangeAuthorization")
        startTrackingLocation()
        break
        
    case .notDetermined:
      
        print("notDetermined from didChangeAuthorization")
        break
        }
    }

}
