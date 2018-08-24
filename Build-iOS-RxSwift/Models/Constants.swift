//
//  App.swift
//  Build-iOS-RxSwift
//
//  Created by 123 on 24.08.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import UIKit
import Hue
import RealmSwift

struct App {
    
    // MARK: - Colors
    
    struct Color {
        static let coolGrey24 = UIColor(hex: "#95989a").withAlphaComponent(0.24)
        static let azure = UIColor(hex: "#108aeb")
        static let skyBlue = UIColor(hex: "#4fc3f7")
        static let black24 = UIColor(hex: "#333333").withAlphaComponent(0.24)
        static let midGreen = UIColor(hex: "#4caf50")
        static let darkSlateBlue = UIColor(hex: "#152957")
        static let silver = UIColor(hex: "#d1d1d6")
        static let mango = UIColor(hex: "#ffa726")
        static let white = UIColor(hex: "#fefefe")
        static let whiteSmoke = UIColor(hex: "#f5f5f5")
        static let blackDisable = UIColor(hex: "#333333").withAlphaComponent(0.4)
        static let grapefruit = UIColor(hex: "#ff5252")
        static let whiteTwo = UIColor(hex: "#f7f7f7")
        static let paleGrey = UIColor(hex: "#efeff4")
        static let black12 = UIColor(hex: "#000000").withAlphaComponent(0.12)
        static let paleGreyTwo = UIColor(hex: "#e5e8ef")
        static let steel = UIColor(hex: "#8e8e93")
        static let shadows = UIColor(hex: "#000000").withAlphaComponent(0.24)
        static let slateGrey = UIColor(hex: "#6d6d72")
        static let greyishBrown = UIColor(hex: "#444444")
        static let background = UIColor(hex: "#fafafa")
        static let coolGrey = UIColor(hex: "#bcbbc1")
        static let black = UIColor(hex: "#333333")
        static let sky = UIColor(hex: "#87cefa")
        
        static let blueGradient = [
            UIColor(hex: "#1a44a9"),
            UIColor(hex: "#175abe"),
            App.Color.azure
        ]
        
    }
    
    // MARK: - Layout
    
    struct Layout {
        static let buttonHeight: CGFloat = 48
        static let tabBarHeight: CGFloat = 56
        
        static let sideOffset: CGFloat = 24
        static let itemSpacingSmall: CGFloat = 8
        static let itemSpacingMedium: CGFloat = 16
        static let itemSpacingBig: CGFloat = 21
        
        static let cornerRadius: CGFloat = 14
        static let cornerRadiusSmall: CGFloat = 8
        
        static let zPositionCommon: CGFloat = 5
    }
    
    // MARK: - Fonts
    
    struct Font {
        static let titleAlts = regular(64)
        static let titleMedium = medium(34)
        static let titleSmall = medium(24)
        static let headline = medium(20)
        static let subheadAlts = medium(16)
        static let subhead = regular(16)
        static let subtitle = regular(16)
        static let navButton = medium(14)
        static let navButtonDisable = regular(14)
        static let bodyAlts = medium(14)
        static let body = regular(14)
        static let cardTitle = medium(14)
        static let button = medium(14)
        static let footnote = regular(13)
        static let captionAlts = medium(12)
        static let caption = regular(12)
        static let label = medium(12)
        static let buttonSmall = medium(12)
        
        // MARK: - Font Setup
        static func regular(_ size: CGFloat) -> UIFont {
            return UIFont(name: "Roboto-Regular", size: size) ??
                UIFont.systemFont(ofSize: size, weight: .regular)
        }
        
        static func medium(_ size: CGFloat) -> UIFont {
            return UIFont(name: "Roboto-Medium", size: size) ??
                UIFont.systemFont(ofSize: size, weight: .medium)
        }
    }
    
    
    
    
    
    
}







