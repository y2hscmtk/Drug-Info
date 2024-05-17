//
//  DrugItem.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/01/15.
//

// header, body
struct DrugResponse: Decodable {
    var header: Header?
    var body: Body?
}

// header
struct Header: Decodable {
    var resultCode: String?
    var resultMsg: String?
}

// body
// 일치하는 알약 결과값이 여러개 존재할 경우, 배열의 형태로 전달받음
struct Body: Decodable {
    var pageNo: Int?
    var totalCount: Int?
    var numOfRows: Int?
    var items: [DrugItem]
}

// API로부터 전달받을 알약 클래스
struct DrugItem: Decodable {
    var entpName : String? // 알약 제조사
    var itemName : String? // 알약 이름
    var itemSeq : String?
    var efcyQesitm : String? // 알약 효능 요약
    var useMethodQesitm : String? // 복용 방법
    var atpnWarnQesitm : String?
    var depositMethodQesitm : String? // 보관 방법
    var itemImage : String? // 알약 이미지 링크
}
