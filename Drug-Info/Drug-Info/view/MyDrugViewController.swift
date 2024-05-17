//
//  MyDrugViewController.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/04/06.
//

import UIKit

class MyDrugViewController: UIViewController {

    
    @IBOutlet weak var collectionview: UICollectionView!
    
    var padding: CGFloat = 7
    var totalPadding: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalPadding = padding * 2 // 좌우 패딩만 포함
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
        // 이미지 크기 동적 조절
        let cellWidth = (collectionView.frame.width - totalPadding) / 2
        let imageSize = cellWidth - (padding * 2)
        if let originalImage = cell.drugImageView.image {
            cell.drugImageView.image = originalImage.resizedImage(newSize: CGSize(width: imageSize, height: imageSize))
        }
        
        return cell
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
