//
//  ColorUtols.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/08/12.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

class ColorUtils {
    
    static let colorProfileBoard = UIColor(r: 84, g: 90, b: 124)
    
    static let color34 = UIColor(r: 34, g: 34, b: 34)
    
    static let color68 = UIColor(r: 68, g: 68, b: 68)
    
    static let color136 = UIColor(r: 136, g: 136, b: 136)
    
    static let color170 = UIColor(r: 170, g: 170, b: 170)
    
    static let color187 = UIColor(r: 187, g: 187, b: 187)
    
    static let color221 = UIColor(r: 221, g: 221, b: 221)
    
    static let color231 = UIColor(r: 231, g: 231, b: 231)
    
    static let color242 = UIColor(r: 242, g: 242, b: 242)
    
    static let color243 = UIColor(r: 243, g: 243, b: 243)
    
    static let color247 = UIColor(r: 247, g: 247, b: 247)
    
    static let colorTimeSelected = UIColor(r: 84, g: 90, b: 124)
    
    static let colorCoverWhite = UIColor(r: 250, g: 249, b: 248)
    
    // MARK: 컬러칩
    
    static let colorNavy = UIColor(hex: "#455F7C")
    static let colorBgNavy = UIColor(hex: "#D9DFE7")
    
    static let colorGray = UIColor(hex: "#D9D8D4")
    static let colorBgGray = UIColor(hex: "#EBEBEB")
    
    static let colorMint = UIColor(hex: "#84A2A4")
    static let colorBgMint = UIColor(hex: "#E2ECED")
    
    static let colorPink = UIColor(hex: "#CFB4C1")
    static let colorBgPink = UIColor(hex: "#F5F1F3")
    
    static let colorLemon = UIColor(hex: "#EEE6A1")
    static let colorBgLemon = UIColor(hex: "#F8F6EB")
    
    static let colorBlue = UIColor(hex: "#7A8DA9")
    static let colorBgBlue = UIColor(hex: "#E1E5EB")
    
    static let colorPlum = UIColor(hex: "#A77D91")
    static let colorBgPlum = UIColor(hex: "#F0E7EB")
    
    static let colorOrange = UIColor(hex: "#F9C589")
    static let colorBGOrange = UIColor(hex: "#F4EDE4")
    
    static let colorBrown = UIColor(hex: "#8C7369")
    static let colorBgBrown = UIColor(hex: "#EDE4E0")
    
    static let colorGreen = UIColor(hex: "#778D7D")
    static let colorBgGreen = UIColor(hex: "#E1E8E3")
    
    static let colorIvory = UIColor(hex: "#DFC6B8")
    static let colorBgIvory = UIColor(hex: "#F3EDEA")
    
    static let colorPurple = UIColor(hex: "#9F87B7")
    static let colorBgPurple = UIColor(hex: "#EEEAF1")
    
    static let colorRed = UIColor(hex: "#B16B67")
    static let colorBgRed = UIColor(hex: "#ECE1E0")
    
    static let colorPeach = UIColor(hex: "#F5B693")
    static let colorBgPeach = UIColor(hex: "#ECDDD5")
    
    static let colorBlack = UIColor(hex: "#636363")
    static let colorBgBlack = UIColor(hex: "#EBE9E9")
    
    static func getColorChip(_ color: String) -> (bookColor: UIColor, bgColor: UIColor) {
        var colorChip = (bookColor: UIColor.clear, bgColor: UIColor.clear)
        
        switch color {
        case "NAVY" :
            colorChip = (bookColor: colorNavy, bgColor: colorBgNavy)
            
        case "GRAY" :
            colorChip = (bookColor: colorGray, bgColor: colorBgGray)
            
        case "MINT" :
            colorChip = (bookColor: colorMint, bgColor: colorBgMint)
            
        case "PINK" :
            colorChip = (bookColor: colorPink, bgColor: colorBgPink)
            
        case "LEMON" :
            colorChip = (bookColor: colorLemon, bgColor: colorBgLemon)
            
        case "BLUE" :
            colorChip = (bookColor: colorBlue, bgColor: colorBgBlue)
            
        case "ORANGE" :
            colorChip = (bookColor: colorOrange, bgColor: colorBGOrange)
            
        case "BROWN" :
            colorChip = (bookColor: colorBrown, bgColor: colorBgBrown)
            
        case "GREEN" :
            colorChip = (bookColor: colorGreen, bgColor: colorBgGreen)
            
        case "IVORY" :
            colorChip = (bookColor: colorIvory, bgColor: colorBgIvory)
            
        case "PURPLE" :
            colorChip = (bookColor: colorPurple, bgColor: colorBgPurple)
            
        case "RED" :
            colorChip = (bookColor: colorRed, bgColor: colorBgRed)
            
        case "PEACH" :
            colorChip = (bookColor: colorPeach, bgColor: colorBgPeach)
            
        case "BLACK" :
            colorChip = (bookColor: colorBlack, bgColor: colorBgBlack)
            
        default:
            print("-------- 정의되지 않은 값:  ", color)
            break
        }
        
        return colorChip
    }
    
}

