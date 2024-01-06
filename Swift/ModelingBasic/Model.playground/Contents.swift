import UIKit

// 앱에서 가장 중요한 기능을 제공하는 화면 어떤 데이터를 표시하고 있는지 파악 -> 모델링

// 온라인 강의 어플 예시
struct Course {
    let courseId: Int
    
    // 인스턴스 속성. Instance Property
    let title: String // 상수 저장 속성, Stored Property
    let subtitle: String
    
    let cardImageUrlStr: String
//    let cardImageUrl: URL
    
    // 계산 속성. Computed Property
    var cardImageUrl: URL? {
        URL(string: cardImageUrlStr)
        // 읽기 전용 계산 속성. read-onlt Computed Property
    }
    
    let thumbnailImageUrlStr: String?
    var thumbanilImageUrl: URL? {
        guard let str = thumbnailImageUrlStr else {
            return nil
        }
        return URL(string: str)
    }
    
    let reviewScore: Double?
    var reviewScoreStr: String? {
        guard let score = reviewScore else { return nil }
        
        // 포맷팅 -> 어떤 값을 내가 원하는 문자로 바꾸는 방법.  iOS Formatter
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        
        return formatter.string(for: score)
    }
    
    let isCertificationAvailable: Bool
    
    var isFree: Bool {
        return price == nil
    }
    
    let lectureCount: Int
    let totalDuration: Int
    var totalDurationStr: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .full
        
        return formatter.string(from: TimeInterval(totalDuration))
    }
    
    let priority: Int
    
    let isPublic: Bool
    
    let period: Int?
    
    let price: Double?
    let discountedPrice: Double?
    
    // String? 사용하는 이유: var text: String? 코드 간단. -> SwiftUI에서는 옵셔널X가 편함
    var priceString: String? {
        guard let price else { return "무료" }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency // 설정된 지역에 맞게 포멧팅
        formatter.locale = Locale(identifier: "ko_KR") // 지역 설정. 국가마다 지정됨 -> 대한민국: ko_KR
        
        if let discountedPrice {
            return formatter.string(for: discountedPrice)
        }
        
        return formatter.string(for: price)
    }
}

struct Camp {
    let campId: Int
    
    // 인스턴스 속성. Instance Property
    let title: String // 상수 저장 속성, Stored Property
    let subtitle: String
    
    let cardImageUrlStr: String
//    let cardImageUrl: URL
    
    // 계산 속성. Computed Property
    var cardImageUrl: URL? {
        URL(string: cardImageUrlStr)
        // 읽기 전용 계산 속성. read-onlt Computed Property
    }
    
    let thumbnailImageUrlStr: String?
    var thumbanilImageUrl: URL? {
        guard let str = thumbnailImageUrlStr else {
            return nil
        }
        return URL(string: str)
    }
    
    let reviewScore: Double?
    var reviewScoreStr: String? {
        guard let score = reviewScore else { return nil }
        
        // 포맷팅 -> 어떤 값을 내가 원하는 문자로 바꾸는 방법.  iOS Formatter
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        
        return formatter.string(for: score)
    }
    
    let isCertificationAvailable: Bool
    
    let startDate: Date
    var startDateString: String? {
        let formatter = DateFormatter()
//        formatter.dateStyle = .full
//        formatter.timeStyle = .none
        
        formatter.dateFormat = "M월 d일 개강"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: startDate)
    }
    
    let endDate: Date
    var endDateString: String? {
        let formatter = DateFormatter()
        //        formatter.dateStyle = .full
        //        formatter.timeStyle = .none
        
        formatter.dateFormat = "M월 d일 종강"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: endDate)
    }
    
    let isOnlineCamp: Bool
    
    let locationUrl: URL?
    
    let latitude: Double?
    let longitude: Double?
    
    // Nested Type
    // Camp.CampStatus
    enum Status: String {
        case preparingForOpening    = "개강 준비중"
        case recruiting             = "모집중"
        case recruitingEnded        = "모집마감"
        case onGoing                = "개강중"
        case ended                  = "종강"
    }

    let status: Status
    let generation: Int
    
    var statusString: String? {
        return "\(generation)기 \(status.rawValue)"
    }
    
    let priority: Int
    
    let isPublic: Bool
    
    let period: Int?
    
    let price: Double?
    let discountedPrice: Double?
    
    // String? 사용하는 이유: var text: String? 코드 간단. -> SwiftUI에서는 옵셔널X가 편함
    var priceString: String? {
        guard let price else { return "무료" }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency // 설정된 지역에 맞게 포멧팅
        formatter.locale = Locale(identifier: "ko_KR") // 지역 설정. 국가마다 지정됨 -> 대한민국: ko_KR
        
        if let discountedPrice {
            return formatter.string(for: discountedPrice)
        }
        
        return formatter.string(for: price)
    }
}

// raw value, 원시값
enum Alignment: Int {
    case left
    case right = 100
    case center
}

Alignment.left.rawValue
Alignment.right.rawValue
Alignment.center.rawValue

Alignment(rawValue: 0)
Alignment(rawValue: 200)

//Alignment.left.rawValue = 10

enum Weekday: String {
    case sunday
    case monday = "MON"
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

Weekday.sunday.rawValue
Weekday.monday.rawValue
