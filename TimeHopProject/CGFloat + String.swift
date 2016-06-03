//
//  CGFloat + String.swift
//  TimeHopProject
//
//  Created by Daniel No on 5/23/16.
//  Copyright © 2016 Daniel No. All rights reserved.
//

import Foundation
import UIKit

extension String{
    func convertToFloat() -> CGFloat{
        let floatVal = CGFloat((self as NSString).floatValue)
        return floatVal
    }
    
}