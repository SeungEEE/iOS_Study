import UIKit

// 주소
"http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=20120101&key=본인키값"

// 쿼리 파라미터
"?targetDt=20120101&key=본인의키값&multiMovieYn=N"

let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=20120101&key=53bb646446cdb78fd29149458cf98611"

let structUrl = URL(string: movieURL)!

//let session = URLSession(configuration: .default)
//let session = URLSession.shared // 싱글톤 객체(객체가 하나만 존재하도록)


URLSession.shared.dataTask(with: structUrl) { data, response, error in
    if error != nil {
        print(error!)
        return
    }
    
    if let safeData = data {
        print(String(decoding: safeData, as: UTF8.self))
        // 데이터를 우리가 사용하려는 형태(구조체 / 클래스)로 변형해서 사용
    }
    
}.resume()




