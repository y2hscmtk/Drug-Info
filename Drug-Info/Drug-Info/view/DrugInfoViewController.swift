//
//  DrugInfoViewController.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/01/16.
//

import UIKit

class DrugInfoViewController: UIViewController {
    
    var drug : DrugItem? // 전달 받은 알약 데이터

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentStackview: UIStackView!
    @IBOutlet weak var drugName: UILabel! // 알약 이름
    @IBOutlet weak var drugImageView: UIImageView! // 알약 이미지
    @IBOutlet weak var company: UILabel! // 제조사
    @IBOutlet weak var efficient: UILabel! // 효능
    @IBOutlet weak var howToUse: UILabel! // 복용방법
    @IBOutlet weak var howToStore: UILabel! // 보관방법
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setValue() // 알약 정보 화면에 뿌리기
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        // 스크롤뷰 높이 동적 변경
//        let contentHeight = contentStackview.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
//        heightConstraint.constant = contentHeight
//    }
    
    // 데이터 할당
    func setValue(){
        company.text = drug?.entpName ?? "제조사 정보가 없습니다"
        drugName.text = drug?.itemName
        efficient.text = drug?.efcyQesitm ?? "효능에 대한 정보가 서버에 없습니다."
        howToUse.text = drug?.useMethodQesitm ?? "복용 방법에 대한 정보가 서버에 없습니다."
        howToStore.text = drug?.depositMethodQesitm ?? "보관 방법에 대한 정보가 서버에 없습니다."
        
        // 이미지 할당 => 캐시를 사용하기 때문에 서버요청없이, 한번 다운받아둔 이미지를 그대로 사용
        if let link = drug?.itemImage{ // 링크가 nil이 아닌 경우에 한에(다운로드 이미지 링크가 존재한다면)
            drugImageView.imageDownload(link: link)
        }
        
//        view.setNeedsLayout()
//        view.layoutIfNeeded()
    }
}
