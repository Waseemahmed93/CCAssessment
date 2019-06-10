 //
//  WebServices.swift
//  SeatUs
//
//  Created by Qazi Naveed on 10/19/17.
//  Copyright © 2017 Qazi Naveed. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import AlamofireImage
import MBProgressHUD

 
class WebServices : NSObject{
    
    var webHeader:HTTPHeaders = ["Accept":"application/json","Content-Type":"application/x-www-form-urlencoded"]
    var hudView : MBProgressHUD!
    var alertWindow : UIWindow!

    static let sharedInstance = WebServices()

    private override init() {
       self.hudView = MBProgressHUD()
      // self.hudView =  KRProgressHUD()
    }

    class func getServiceStatus(dic:NSDictionary) -> Bool {
        if let status = dic.value(forKey: "status") as? NSNumber {
            if status == 0 { return false } else { return true }
        }
        return false
    }
    
    func sendRequestToServerInBackground(urlString: String,
                             methodType : HTTPMethod,
                             param:[String : AnyObject]?,
                             shouldShowHud : Bool = false,
                             completionHandler: @escaping (AnyObject?, NSDictionary?, Bool?, Error?) -> ())
    {
        
        if shouldShowHud{
            showHud(message: "")
        }
        let typeMethod: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)!
        Alamofire.request(urlString , method:typeMethod , parameters: param, headers:webHeader)
            .responseJSON { response in
                
                print("Param : ",param ?? "")
                print(response)
                self.hideHud()
                switch response.result {
                case .success(let JSON):
                    let object = JSON as? NSDictionary
                    let status = object!["status"] as AnyObject as! Bool
                    completionHandler(response as AnyObject , object, status,nil)
                case .failure(let error):
                    print(error)
                    if shouldShowHud{
                        self.showAlertController(message: error.localizedDescription)
                    }
                    else
                    {
                        completionHandler(nil, nil, false,error)
                        
                    }
                }
        }
    }

    
    func sendRequestToServerWithHeaderLeadForm(urlString: String,
                                                    methodType : HTTPMethod,
                                                    param:[String : AnyObject]?,
                                                    shouldShowHud : Bool = true,userToken:String,
                                                    completionHandler: @escaping (AnyObject?, NSDictionary?, Bool?, Error?) -> ())
    {
        
        if shouldShowHud{
            showHud(message: "")
        }
        let typeMethod: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)!
        webHeader.updateValue(param!["name"] as! String , forKey:"name")
        webHeader.updateValue(param!["phone"] as! String , forKey:"phone")
        webHeader.updateValue(param!["user_mail"] as! String , forKey:"user_mail")
        webHeader.updateValue(param!["acc_id"] as! String , forKey:"acc_id")
        webHeader.updateValue(param!["best_time_to_call"] as! String , forKey:"best_time_to_call")
        
        Alamofire.request(urlString , method:typeMethod , parameters: ["":""], headers:webHeader)
            .responseJSON { response in
                
                print("Param : ",param ?? "")
                print(response)
                self.hideHud()
                switch response.result {
                case .success(let JSON):
                    let object = JSON as? NSDictionary
                    let status = object!["status"] as AnyObject as! Bool
                    completionHandler(response as AnyObject , object, status,nil)
                case .failure(let error):
                    print(error)
                    if shouldShowHud{
                        
                        self.showAlertController(message: error.localizedDescription)
                    }
                    else
                    {
                        completionHandler(nil, nil, false,error)
                        
                    }
                }
        }
    }
    
    func sendRequestToServerWithHeaderAuthorization(urlString: String,
                             methodType : HTTPMethod,
                             param:[String : AnyObject]?,
                             shouldShowHud : Bool = true,userToken:String,
                             completionHandler: @escaping (AnyObject?, NSDictionary?, Bool?, Error?) -> ())
    {
        
        if shouldShowHud{
            showHud(message: "")
        }
        let typeMethod: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)!
      
        Alamofire.request(urlString , method:typeMethod , parameters: param, headers:webHeader)
            .responseJSON { response in
                
                print("Param : ",param ?? "")
                print(response)
                self.hideHud()
                switch response.result {
                case .success(let JSON):
                    let object = JSON as? NSDictionary
                    let status = object!["status"] as AnyObject as! Bool
                    completionHandler(response as AnyObject , object, status,nil)
                case .failure(let error):
                    print(error)
                    if shouldShowHud{
                       
                        self.showAlertController(message: error.localizedDescription)
                    }
                    else
                    {
                        completionHandler(nil, nil, false,error)
                        
                    }
                }
        }
    }
    
    
    func sendRequestToGoogleApi(urlString: String,
                             methodType : HTTPMethod,
                             param:[String : AnyObject]?,
                             shouldShowHud : Bool = true,
                             completionHandler: @escaping (AnyObject?, NSDictionary?, Bool?, Error?) -> ())
    {
        
        if shouldShowHud{
            showHud(message: "")
        }
        let typeMethod: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)!
        Alamofire.request(urlString , method:typeMethod , parameters: param, headers:webHeader)
            .responseJSON { response in
                
                print("Param : ",param ?? "")
                print(response)
                self.hideHud()
                switch response.result {
                case .success(let JSON):
                    let object = JSON as? NSDictionary
                   // let status = object!["status"] as AnyObject as! Bool
                    completionHandler(response as AnyObject , object, true,nil)
                case .failure(let error):
                    print(error)
                    if shouldShowHud{
                        self.showAlertController(message: error.localizedDescription)
                    }
                    else
                    {
                        completionHandler(nil, nil, false,error)
                        
                    }
                }
        }
    }

    func sendRequestToServerLogin(urlString: String,
                             methodType : HTTPMethod,
                             param:[String : AnyObject]?,
                             shouldShowHud : Bool = true,
                             completionHandler: @escaping (AnyObject?, NSDictionary?, String?, Error?) -> ())
    {
        
        if shouldShowHud{
            showHud(message: "")
        }
        let typeMethod: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)!
        Alamofire.request(urlString , method:typeMethod , parameters: param, headers:webHeader)
            .responseJSON { response in
                
                print("Param : ",param ?? "")
                print(response)
                self.hideHud()
                switch response.result {
                case .success(let JSON):
                    let object = JSON as? NSDictionary
                    let status = object!["status"] as! String
                    completionHandler(response as AnyObject , object, status,nil)
                case .failure(let error):
                    print(error)
                    if shouldShowHud{
                        self.showAlertController(message: error.localizedDescription)
                    }
                    else
                    {
                        completionHandler(nil, nil, "0",error)
                        
                    }
                }
        }
    }
    
    func sendRequestToServer(urlString: String,
                               methodType : HTTPMethod,
                               param:[String : AnyObject]?,
                               shouldShowHud : Bool = true,
                               completionHandler: @escaping (AnyObject?, NSDictionary?, Bool?, Error?) -> ())
    {

        if shouldShowHud{
            showHud(message: "")
        }
        let typeMethod: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)!
        Alamofire.request(urlString , method:typeMethod , parameters: param, headers:webHeader)
            .responseJSON { response in
              
                print("url :",urlString)
                print("Param : ",param ?? "")
                print(response)
                self.hideHud()
//                switch response.result {
//                case .success(let JSON):
//                    let object = JSON as? NSDictionary
//                    let status = object!["status"] as AnyObject as! Bool
//                    completionHandler(response as AnyObject , object, status,nil)
//                case .failure(let error):
//                    print(error)
//                    if shouldShowHud{
//                        self.showAlertController(message: error.localizedDescription)
//                    }
//                    else
//                    {
//                        completionHandler(nil, nil, false,error)
//
//                    }
//                }
        }
    }

    
    func sendRequestToOpenMapWeather(urlString: String,
                             methodType : HTTPMethod,
                             param:[String : AnyObject]?,
                             shouldShowHud : Bool = true,
                             completionHandler: @escaping (AnyObject?, NSDictionary?, Bool?, Error?) -> ())
    {
        
        if shouldShowHud{
            showHud(message: "")
        }
        let typeMethod: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)!
        Alamofire.request(urlString , method:typeMethod , parameters: param, headers:webHeader)
            .responseJSON { response in
                
                print("url :",urlString)
                print("Param : ",param ?? "")
                print(response)
                self.hideHud()
                                switch response.result {
                                case .success(let JSON):
                                    let object = JSON as? NSDictionary
//                                    let status = object![JsonParserObject.code] as AnyObject as! Int
                                    completionHandler(response as AnyObject , object, true,nil)
                                case .failure(let error):
                                    print(error)
                                    if shouldShowHud{
                                        self.showAlertController(message: error.localizedDescription)
                                    }
                                    else
                                    {
                                        completionHandler(nil, nil, false,error)
                
                                    }
                                }
        }
    }
    
    func sendRequestToThirdPartyServer(urlString: String,
                             methodType : HTTPMethod,
                             param:[String : AnyObject]? = nil,
                             shouldShowHud : Bool = true,
                             completionHandler: @escaping (AnyObject?, NSDictionary?, Bool?, Error?) -> ())
    {

        if shouldShowHud{
            showHud(message: "")
        }
        let typeMethod: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)!
        Alamofire.request(urlString, method:typeMethod , parameters: param, headers:webHeader)
            .responseJSON { response in
                print("Request URL : " + urlString)
                print("Param : ",param ?? "")
                print(response)
                self.hideHud()
                switch response.result {
                case .success(let JSON):
                    let object = JSON
                    completionHandler(object as AnyObject , nil, true,nil)
                case .failure(let error):
                    print(error)
                    self.showAlertController(message: error.localizedDescription)
                    //                    completionHandler(nil, nil, false,error)
                }
        }
    }

    
    func getImageFromUrl(urlStr : String,completionHandler: @escaping (UIImage) -> ())
    {
        print(urlStr)
        Alamofire.request(urlStr).responseImage { response in
            debugPrint(response)
            print(response.request as Any)
            print(response.response as Any)
            debugPrint(response.result)
            var imageDownloaded : UIImage!
            if let image = response.result.value {

                print("image downloaded: \(image)")
                imageDownloaded = image
                completionHandler(imageDownloaded)
            }

        }

    }
    func showHud(message:String){

        let window: UIView =  UIApplication.shared.keyWindow!
      
//        KRProgressHUD.show()
    }

    func hideHud(){


        
        let window: UIView =  UIApplication.shared.keyWindow!
        DispatchQueue.global(qos: .background).async {
            // Go back to the main thread to update the UI
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: window, animated: true)
            }
        }
    }

    func showAlertController(message:String){

        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action -> Void in
            alert.dismiss(animated: true, completion: nil)
            self.alertWindow=nil
        })
        alert.addAction(okAction)

        self.alertWindow = UIWindow.init(frame: UIScreen.main.bounds)
        self.alertWindow.rootViewController = UIViewController()
        self.alertWindow.windowLevel = UIWindow.Level.alert + 1
        self.alertWindow.makeKeyAndVisible()
        self.alertWindow.rootViewController?.present(alert, animated: false, completion: nil)
    }
}
