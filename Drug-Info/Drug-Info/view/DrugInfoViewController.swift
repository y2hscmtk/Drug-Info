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
                let alert = UIAlertController(title: "알림", message: "이미 저장된 알약입니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
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
                        print("Failed to save drug info: \(error.localizedDescription)")
                        return
                    }
                    print("Successfully saved drug info")
                    let successAlert = UIAlertController(title: "저장 성공", message: "알약 정보가 성공적으로 저장되었습니다.", preferredStyle: .alert)
                    successAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                    self.present(successAlert, animated: true, completion: nil)
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

    
}
