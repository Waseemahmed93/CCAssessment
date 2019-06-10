//
//  String+ClassName.swift
//  GlobalDents
//
//  Created by Waseem on 6/7/19.
//  Copyright © 2019 OVRS. All rights reserved.
//

import Swift
import UIKit

extension NSObject {
    static func nameOfClass() -> String {
        return NSStringFromClass(self as AnyClass).components(separatedBy: ".").last!
    }
    
    
}
