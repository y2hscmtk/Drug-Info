//
//  DrugAPI.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/01/15.
//

import Foundation
import Alamofire

// 공공 데이터 포탈 : https://www.data.go.kr/data/15075057/openapi.do
// "식품의약품안전처_의약품개요정보(e약은요)"
// End Point : https://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList

// 응답 데이터 형식
/*
 
 {
   "header": {
     "resultCode": "String",
     "resultMsg": "String"
   },
   "body": {
     "items": [ // items는 배열임
       {
         // 약품 정보 필드들...
       }
     ]
     // 기타 필드들...
   }
 }
 */

// header, body
struct DrugResponse: Decodable {
    let header: Header
    let body: Body
}

// header
struct Header: Decodable {
    let resultCode: String
    let resultMsg: String
}

// body
// 일치하는 알약 결과값이 여러개 존재할 경우, 배열의 형태로 전달받음
struct Body: Decodable {
    let items: [DrugItem]
}

// Alamofire를 활용하여 API코드 작성
class DrugAPI{
    static let shared = DrugAPI()
    
    let url = "https://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList"
    
    // 알약 검색 => 파라미터를 매개변수로 받아서 요청
    func searchDrug(_ parameter : APIParameter, _ view : MainViewController){
        AF.request(url, method: .get, parameters: parameter)
            .validate()
            .responseDecodable(of: DrugResponse.self) { response in
                switch response.result {
                case .success(let drugResponse):
                    let searchResult = drugResponse.body.items
                    view.setSearchResultArray(searchResult: searchResult)
                case .failure(let error):
                    print("API 요청 실패: \(error.localizedDescription)")
                }
            }
    }
}
