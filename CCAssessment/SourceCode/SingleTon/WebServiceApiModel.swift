//
//  WebServiceApiModel.swift
//  UdioRental
//
//  Created by Waseem Ahmed on 10/01/2019.
//  Copyright © 2019 Shahrukh Jamil. All rights reserved.
//

import UIKit

struct WebServiceApiModel {

    
    static func postRequestWithAuthorizationToken(urlString:String,controllerView:UIView,parameter:[String:AnyObject],controller : UIViewController,completionHanlder:@escaping (Bool,String,NSDictionary?, NSError?) -> ())
    {
       
    }
    
    static func postRequestGoogleApi(urlString:String,controllerView:UIView,parameter:[String:AnyObject],controller : UIViewController,completionHanlder:@escaping (Bool,String,NSDictionary?, NSError?) -> ())
    {
        WebServices.sharedInstance.sendRequestToServer(urlString: urlString, methodType: .post, param: parameter) { (object, response, status, error) in
            if error == nil
            {
                //     print("object",object as Any)
                completionHanlder(true,"message",response,nil)
                
            }
            else
            {
                completionHanlder(true,"message",response,error! as NSError)
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    
    static func postRequest(urlString:String,controllerView:UIView,parameter:[String:AnyObject],controller : UIViewController,completionHanlder:@escaping (Bool,String,NSDictionary?, NSError?) -> ())
    {
        WebServices.sharedInstance.sendRequestToOpenMapWeather(urlString: urlString, methodType: .post, param: parameter) { (object, response, status, error) in
            if error == nil
            {
             //     print("object",object as Any)
                completionHanlder(true,"message",response,nil)
              
            }
            else
            {
                completionHanlder(true,"message",response,error! as NSError)
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    static func postRequestWithImage(urlString:String,controllerView:UIView,parameter:[String:AnyObject],imageParams:[[String:AnyObject]],controller : UIViewController,completionHanlder:@escaping (Bool,String,NSDictionary?, NSError?) -> ())
    {
       
    }
    
    
   
    
    
  
//    // show alert Message with custom handler
 static func showAlertViewPopUpForVehicle(message:String,showCancelBtn:Bool,errorCodeError:Bool ,viewcontroller:UIViewController)  {
        
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let okayEvent = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            
            if errorCodeError
            {
              //  self.logoutFromApp(viewcontroller: viewcontroller)
            }
            else
            {
             // self.okayEventHandlerOfAlertView(ViewController: viewcontroller)
            }
            
        }
        let cancelEvent = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
            
            
        }
        
        alertController.addAction(okayEvent)
        if showCancelBtn {
            alertController.addAction(cancelEvent)
        }
        
        
        viewcontroller.present(alertController, animated: true, completion: nil)
        
    }
    
    
 
    

   
}
