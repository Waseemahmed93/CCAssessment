//
//  PlistUtility.swift
//  CCAssessment
//
//  Created by Waseem on 6/7/19.
//  Copyright © 2019 OVRS. All rights reserved.
//

import UIKit

class PlistUtility: NSObject {

    class func getPlistDataForHomeController()->[Any]{
        return getContentOfFile(name: PlistName.HomePlist)
    }
 
    class  func getContentOfFile(name: String, fileType:String = FileTypes.Plist)->[Any]{
        
        if let path = Bundle.main.path(forResource:name , ofType: fileType) {
            
            print("=====>\(path)")
            
            //If your plist contain root as Array
            if let array = NSArray(contentsOfFile: path) as? [Any] {
                return array as [Any]
            }
        }
        return []
    }
    
}
