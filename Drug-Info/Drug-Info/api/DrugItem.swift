//
//  DrugItem.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/01/15.
//

// API로부터 전달받을 알약 클래스
struct DrugItem: Decodable {
    var entpName : String? // 알약 제조사
    var itemName : String? // 알약 이름
    var itemSeq : String?
    var efcyQesitm : String? // 알약 효능 요약
    var useMethodQesitm : String? // 복용 방법
    var atpnWarnQesitm : String?
    var atpnQesitm : String?
    var intrcQesitm : String?
    var seQesitm : String?
    var depositMethodQesitm : String? // 보관 방법
    var openDe : String?
    var updateDe : String?
    var itemImage : String? // 알약 이미지 링크
    var bizrno : String?
}
