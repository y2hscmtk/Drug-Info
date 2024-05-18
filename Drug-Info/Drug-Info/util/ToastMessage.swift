//
//  ToastMessage.swift
//  Drug-Info
//
//  Created by Choi76 on 5/19/24.
//

import UIKit

// 싱글톤 패턴으로 토스트 메시지 클래스 작성
class ToastMessage {
    
    static let shared = ToastMessage()
    
    private init(){}
    
    func showToast(message: String, fontSize: CGFloat, view: UIView) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 75, y: view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: fontSize)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        view.addSubview(toastLabel)

        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { (isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
