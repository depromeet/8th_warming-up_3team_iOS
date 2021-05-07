//
//  ImageUtils.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/21.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

class ImageUtils {
    static func getColorBookIcon(_ color: String) -> UIImage {
        var image = UIImage()
        
        switch color {
        case "NAVY" :
            image = #imageLiteral(resourceName: "icnNavy")
            
        case "GRAY" :
            image = #imageLiteral(resourceName: "icnGray")
            
        case "MINT" :
            image = #imageLiteral(resourceName: "icnMint")
            
        case "PINK" :
            image = #imageLiteral(resourceName: "icnPink")
            
        case "LEMON" :
            image = #imageLiteral(resourceName: "icnLemon")
            
        case "BLUE" :
            image = #imageLiteral(resourceName: "icnBlue")
            
        case "ORANGE" :
            image = #imageLiteral(resourceName: "icnOrange")
            
        case "BROWN" :
            image = #imageLiteral(resourceName: "icnBrown")
            
        case "GREEN" :
            image = #imageLiteral(resourceName: "icnGreen")
            
        case "IVORY" :
            image = #imageLiteral(resourceName: "icnIvory")
            
        case "PURPLE" :
            image = #imageLiteral(resourceName: "icnPurple")
            
        case "RED" :
            image = #imageLiteral(resourceName: "icnRed")
            
        case "PEACH" :
            image = #imageLiteral(resourceName: "icnPeach")
            
        case "BLACK" :
            image = #imageLiteral(resourceName: "icnBlack")
            
        default:
            print("-------- 정의되지 않은 값:  ", color)
            break
        }
        
        return image
    }
}
