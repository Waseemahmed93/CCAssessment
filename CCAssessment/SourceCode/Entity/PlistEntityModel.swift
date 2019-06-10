//
//  PlistEntityModel.swift
//  CCAssessment
//
//  Created by Waseem on 6/7/19.
//  Copyright © 2019 OVRS. All rights reserved.
//

import UIKit

class PlistEntityModel: NSObject {

    @objc  var title:String!
    
    @objc  var controllerid:String!
   @objc  var navigationtitle:String!
    @objc  var cellidentifier:String!
    
    
    class func getHomeControllerData()->[PlistEntityModel]{
        
        var objects = [Any]()
        objects  = PlistUtility.getPlistDataForHomeController()
        var array = [PlistEntityModel]()
        
        for (_, value) in objects.enumerated() {
            
            let castValue = value as![String:Any]
            var modelHomeOption = PlistEntityModel()
            modelHomeOption =  DynamicParser.setValuesOnClass(object: castValue, classObj: modelHomeOption) as! PlistEntityModel
            
            array.append(modelHomeOption )
        }
        return array
    }
}
