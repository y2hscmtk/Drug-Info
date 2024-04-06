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
//
//        collectionview.dataSource = self
//        collectionview.delegate = self
        // 사용할 셀 등록
    }

}


//extension MyDrugViewController: UICollectionViewDataSource,UICollectionViewDelegate{
//    
//    // 몇개의 셀을 보여줄 것인지
//    // 현재 사용자가 저장해둔 약의 개수만큼
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        5
//    }
//    
//    // 보여줄 셀의 모습 정의
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    }
//    
//    
//}
