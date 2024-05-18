//
//  APIParameter.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/01/15.
//

import Foundation
struct APIParameter : Encodable{
    var ServiceKey : String?
    var pageNo : Int = 1
    var numOfRows : Int = 15 // 얻어올 결과값 개수
    var efcyQesitm : String
    let type = "json"
    init(ServiceKey : String, pageNo: Int = 1, numOfRows: Int = 10, efcyQesitm: String) {
        self.ServiceKey = ServiceKey
        self.pageNo = pageNo
        self.numOfRows = numOfRows
        self.efcyQesitm = efcyQesitm
    }
}
