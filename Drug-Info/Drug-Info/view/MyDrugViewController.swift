//
//  MyDrugViewController.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/04/06.
//

import UIKit

class MyDrugViewController: UIViewController {

    
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.dataSource = self
        collectionview.delegate = self
        // 사용할 셀 등록
        collectionview.register(
            UINib(nibName: "MyDrugCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "MyDrugCollectionViewCell")
    }

}


extension MyDrugViewController: UICollectionViewDataSource,UICollectionViewDelegate{

    // 몇개의 셀을 보여줄 것인지
    // 현재 사용자가 저장해둔 약의 개수만큼
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    // 보여줄 셀의 모습 정의
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyDrugCollectionViewCell", for: indexPath) as? MyDrugCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }


}

extension MyDrugViewController: UICollectionViewDelegateFlowLayout {
    // 셀의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 한 화면에 2개씩 보여주기
        let width: CGFloat = (collectionView.frame.width / 2) - 7
        
        return CGSize(width: width, height: width)
    }

    // 라인 간의 최소 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
}
