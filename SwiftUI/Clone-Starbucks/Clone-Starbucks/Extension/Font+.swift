//
//  Font+.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/17/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case black
        case bold
        case extraBold
        case extraLight
        case light
        case medium
        case regular
        case semiBold
        case thin
        
        var value: String {
            switch self {
            case .black:
                return "Pretendard-Black"
            case .bold:
                return "Pretendard-Bold"
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .extraLight:
                return "Pretendard-ExtraLight"
            case .light:
                return "Pretendard-Light"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .semiBold:
                return "Pretendard-SemiBold"
            case .thin:
                return "Pretendard-Thin"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    /// ExtraBold
    static var mainTextExtraBold24: Font {
        return .pretend(type: .extraBold, size: 24)
    }
    
    /// Bold
    static var mainTextBold24: Font {
        return .pretend(type: .bold, size: 24)
    }
    
    static var mainTextBold20: Font {
        return .pretend(type: .bold, size: 20)
    }
    
    
    /// SemiBold
    
    static var mainTextSemiBold38: Font {
        return .pretend(type: .semiBold, size: 38)
    }
    
    static var mainTextSemiBold24: Font {
        return .pretend(type: .semiBold, size: 24)
    }
    
    static var mainTextSemiBold18: Font {
        return .pretend(type: .semiBold, size: 18)
    }
    
    static var mainTextSemiBold16: Font {
        return .pretend(type: .semiBold, size: 16)
    }
    
    static var mainTextSemiBold14: Font {
        return .pretend(type: .semiBold, size: 14)
    }
    
    static var mainTextSemiBold13: Font {
        return .pretend(type: .semiBold, size: 13)
    }
    
    /// Medium
    static var mainTextMedium18: Font {
        return .pretend(type: .medium, size: 18)
    }
    
    static var mainTextMedium16: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    
    /// Regular
    static var mainTextRegular18: Font {
        return .pretend(type: .regular, size: 18)
    }
    
    static var mainTextRegular13: Font {
        return .pretend(type: .regular, size: 13)
    }
    
    static var mainTextRegular12: Font {
        return .pretend(type: .regular, size: 12)
    }
    
    static var mainTextRegular09: Font {
        return .pretend(type: .regular, size: 9)
    }
    
    /// Light
    static var mainTextLight24: Font {
        return .pretend(type: .light, size: 24)
    }
    
    static var mainTextLight14: Font {
        return .pretend(type: .light, size: 14)
    }
    
    static var makeMedium18: Font {
        return .pretend(type: .medium, size: 18)
    }
}
