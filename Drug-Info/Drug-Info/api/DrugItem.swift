//
//  DrugItem.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/01/15.
//

// API로부터 전달받을 알약 클래스
struct DrugItem: Decodable {
    let itemImage: String? // 알약 이미지 링크 (옵셔널)
    let itemName: String // 알약 이름
    let entpName: String // 알약 제조사
    let efcyQesitm: String? // 알약 효능 요약 (옵셔널)
    let useMethodQesitm: String? // 복용 방법 (옵셔널)
    let depositMethodQesitm: String? // 보관 방법 (옵셔널)
}
