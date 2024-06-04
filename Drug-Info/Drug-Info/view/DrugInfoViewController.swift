//
//  DrugInfoViewController.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/01/16.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class DrugInfoViewController: UIViewController {
    
    var drug : DrugItem? // 전달 받은 알약 데이터

    @IBOutlet weak var drugName: UILabel! // 알약 이름
    @IBOutlet weak var drugImageView: UIImageView! // 알약 이미지
    @IBOutlet weak var company: UILabel! // 제조사
    @IBOutlet weak var efficient: UILabel! // 효능
    @IBOutlet weak var howToUse: UILabel! // 복용방법
    @IBOutlet weak var howToStore: UILabel! // 보관방법
    
    @IBOutlet weak var saveBtn: UIBarButtonItem! // 알약 저장용 버튼
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setValue() // 알약 정보 화면에 뿌리기
    }
    
    // 알약 데이터 할당
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
    }
    
    // 저장 버튼 클릭시
    @IBAction func saveBtnTapped(_ sender: UIBarButtonItem) {
        guard let drug = drug else { return }
        // 현재 로그인한 사용자 정보 확인
        guard let user = Auth.auth().currentUser else {
            print("User not logged in")
            return
        }

        let ref = Database.database().reference()
        let safeDrugName = safeDatabaseKey(drug.itemName ?? "UnknownDrug")
        // 알약 이름으로 데이터 저장
        let userDrugRef = ref.child("users").child(user.uid).child("drugs").child(safeDrugName)

        // 중복 확인
        userDrugRef.observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                // 이미 저장된 알약이 존재하는 경우
                print("Drug is already saved")
                self.showAllert(title: "알림", message: "이미 저장된 알약입니다!") {
                    self.showDeleteConfirmationAlert(drugName: drug.itemName ?? "알약") { confirmed in
                        if confirmed {
                            // 사용자가 삭제를 선택한 경우
                            userDrugRef.removeValue { error, _ in
                                if let error = error {
                                    self.showAllert(title: "삭제 실패", message: "오류가 발생하였습니다. \(error.localizedDescription)")
                                    return
                                }
                                self.showAllert(title: "삭제 완료", message: "알약을 '나의 알약'에서 삭제 하였습니다.")
                            }
                        }
                    }
                }
            } else {
                // 저장되지 않은 경우에만 저장 수행
                let drugData: [String: Any] = [
                    "entpName": drug.entpName ?? "",
                    "itemName": drug.itemName ?? "",
                    "itemSeq": drug.itemSeq ?? "",
                    "efcyQesitm": drug.efcyQesitm ?? "",
                    "useMethodQesitm": drug.useMethodQesitm ?? "",
                    "atpnWarnQesitm": drug.atpnWarnQesitm ?? "",
                    "depositMethodQesitm": drug.depositMethodQesitm ?? "",
                    "itemImage": drug.itemImage ?? ""
                ]

                userDrugRef.setValue(drugData) { error, _ in
                    if let error = error {
                        self.showAllert(title: "저장 실패", message: "오류가 발생하였습니다. \(error.localizedDescription)")
                        return
                    }
                    self.showAllert(title: "저장 완료", message: "'나의 알약'에 저장되었습니다.")
                }
            }
        }
    }
    
    // 파이어베이스 경로에는 .,#,$,[,] 이 들어갈 수 없음 => 존재한다면 -로 변경하는 함수 작성
    func safeDatabaseKey(_ string: String) -> String {
        let unsafeCharacters: Set<Character> = [".", "#", "$", "[", "]"]
        return string.reduce("") { result, character in
            return result + (unsafeCharacters.contains(character) ? "-" : String(character))
        }
    }
    
    
    // 알람 띄우기
    func showAllert(title: String, message: String, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                completion?()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // 삭제 알람 띄우기
    func showDeleteConfirmationAlert(drugName: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "알림", message: "\(drugName)을(를) 삭제하시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
                completion(true)
            }))
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in
                completion(false)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    
}
