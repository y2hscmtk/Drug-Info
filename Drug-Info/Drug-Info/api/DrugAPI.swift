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

// Alamofire를 활용하여 API코드 작성
class DrugAPI{
    static let shared = DrugAPI()
    
    let url = "https://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList"
    
    // 알약 검색 => 파라미터를 매개변수로 받아서 요청
    func searchDrug(_ parameter : APIParameter, _ completion : @escaping (Bool,[DrugItem]) -> (Void)){
        AF.request(url, method: .get, parameters: parameter)
            .validate()
            .responseDecodable(of: DrugResponse.self) { response in
                switch response.result {
                case .success(let drugResponse):
                    let searchResult = drugResponse.body?.items
                    self.log("searchDrug API 요청 성공 : \(searchResult!)")
                    completion(true,searchResult!)
                case .failure(let error):
                    self.log("searchDrug API 요청 실패 : \(error)")
                    completion(false,[])
                }
            }
    }
}

extension DrugAPI {
    private func log(_ message : String){
        print("🛜[DrugAPI] : \(message)🛜")
    }
}
