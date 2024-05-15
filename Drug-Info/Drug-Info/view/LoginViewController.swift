//
//  LoginViewController.swift
//  Drug-Info
//
//  Created by Choi76 on 5/13/24.
//

import UIKit

// 로그인
class LoginViewController: UIViewController {

    
    @IBOutlet weak var userIdTexField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var signInLabel: UILabel! // 회원가입 버튼 용으로 사용하기 위한 라벨
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInLabel.isUserInteractionEnabled = true
        
        let signInLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(signInLabelDidTapped))
        signInLabel.addGestureRecognizer(signInLabelTapGesture) // 이벤트 등록
    }
    
    @IBAction func loginBtnDidTapped(_ sender: UIButton) {
        
        
    }
    
    @objc private func signInLabelDidTapped(sender : UITapGestureRecognizer){
        // 1. 스토리보드 찾기
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // 2. 이동할 뷰 찾기 => 스토리보드의 identifier를 통해
        let signUpViewController = storyboard
            .instantiateViewController(identifier: "SignUpViewController") as SignUpViewController
        signUpViewController.modalPresentationStyle = .fullScreen //전체 화면으로 변경
        // 3. 화면 이동
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
}
