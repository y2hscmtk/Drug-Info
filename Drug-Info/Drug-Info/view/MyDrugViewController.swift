//
//  MyDrugViewController.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/04/06.
//

import UIKit
import FirebaseAuth
import Firebase

class MyDrugViewController: UIViewController {

    @IBOutlet weak var collectionview: UICollectionView!
    
    // 사용자가 저장한 알약 데이터
    var savedDrug : [DrugItem] = [] {
        didSet { // 변동발생시 컬렉션뷰 새로고침
            collectionview.reloadData()
        }
    } // 검색하기 전에는 빈 배열
    
    var padding: CGFloat = 7
    var totalPadding: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView() // 컬렉션 뷰 초기 설정
    }
    
    // DidAppear 될 때마다 알약 정보 로드
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    
    private func initCollectionView(){
        totalPadding = padding * 2 // 좌우 패딩만 포함
        collectionview.dataSource = self
        collectionview.delegate = self
        // 사용할 셀 등록
        collectionview.register(
            UINib(nibName: "MyDrugCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "MyDrugCollectionViewCell")
    }
    
    // 파이어베이스에 접속하여 저장한 알약 데이터 얻어오기
    private func loadData() {
        guard let user = Auth.auth().currentUser else {
            print("User not logged in")
            return
        }
        
        let ref = Database.database().reference()
        let userDrugsRef = ref.child("users").child(user.uid).child("drugs")
        
        // 사용자가 저장한 모든 알약 데이터를 로드
        userDrugsRef.observeSingleEvent(of: .value) { snapshot in
            var newSavedDrugs = [DrugItem]()
            
            // 스냅샷 내의 모든 데이터를 순회
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let drugData = childSnapshot.value as? [String: Any] {
                    // DrugItem 객체 생성
                    let drugItem = DrugItem(
                        entpName: drugData["entpName"] as? String,
                        itemName: drugData["itemName"] as? String,
                        itemSeq: drugData["itemSeq"] as? String,
                        efcyQesitm: drugData["efcyQesitm"] as? String,
                        useMethodQesitm: drugData["useMethodQesitm"] as? String,
                        atpnWarnQesitm: drugData["atpnWarnQesitm"] as? String,
                        depositMethodQesitm: drugData["depositMethodQesitm"] as? String,
                        itemImage: drugData["itemImage"] as? String
                    )
                    // 사용자가 저장한 알약 배열에 저장
                    newSavedDrugs.append(drugItem)
                }
            }
            
            // 메인 스레드에서 UI 업데이트
            DispatchQueue.main.async {
                self.savedDrug = newSavedDrugs
                self.collectionview.reloadData()
            }
        }
    }

}


extension MyDrugViewController: UICollectionViewDataSource,UICollectionViewDelegate{

    // 몇개의 셀을 보여줄 것인지
    // 현재 사용자가 저장해둔 약의 개수만큼
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return savedDrug.count
        return savedDrug.count
    }

    // 보여줄 셀의 모습 정의
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyDrugCollectionViewCell", for: indexPath) as? MyDrugCollectionViewCell else {
            return UICollectionViewCell()
        }
        // 이미지 크기 동적 조절
        let cellWidth = (collectionView.frame.width - totalPadding) / 2
        let imageSize = cellWidth - (padding * 2)
        if let originalImage = cell.drugImageView.image {
            cell.drugImageView.image = originalImage.resizedImage(newSize: CGSize(width: imageSize, height: imageSize))
        }
        
        return cell
    }

    // 컬렉션뷰 아이템 선택시 => 알약에 대한 상세 설명 페이지로 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let drugInfoView = storyboard.instantiateViewController(
            identifier: "DrugInfoViewController") as! DrugInfoViewController
        let drug = savedDrug[indexPath.row]
        drugInfoView.drug = drug // drugInfoView에 데이터 전달
        // 화면 이동
        navigationController?.pushViewController(drugInfoView, animated: true)
    }
    

}

extension MyDrugViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀의 크기 설정
        let individualWidth = (collectionView.frame.width - totalPadding - padding) / 2
        return CGSize(width: individualWidth, height: individualWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }

}



extension UIImage {
    func resizedImage(newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
