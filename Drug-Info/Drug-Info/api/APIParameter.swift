//
//  APIParameter.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/01/15.
//

import Foundation
struct APIParameter : Encodable{
    let ServiceKey = Bundle.main.apiKey // Secrets.plist 파일로부터 공공데이터포탈 api키 로드
    var pageNo : Int = 1
    var numOfRows : Int = 10 // 얻어올 결과값 개수
    var efcyQesitm : String
    let type = "json"
    init(pageNo: Int = 1, numOfRows: Int = 10, efcyQesitm: String) {
        self.pageNo = pageNo
        self.numOfRows = numOfRows
        self.efcyQesitm = efcyQesitm
    }
}

// api키 숨김 처리를 위한 Bundle 확장
extension Bundle {
    
    var apiKey: String? {
        guard let file = self.path(forResource: "Secrets", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_KEY"] as? String else {
            print("Fail To Load API KEY")
            return nil
        }
        return key
    }
    
}
