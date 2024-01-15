//
//  APIParameter.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/01/15.
//
struct APIParameter : Encodable{
    let ServiceKey = "mnM3G+Ve2TbLbL8c28uo0+8DPm1BWhypecdlULvO0JON8yo7ml/Crna3jiAd5vo9sM2U67ohzK8DWVt5xdPBnA==" // decoding
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
