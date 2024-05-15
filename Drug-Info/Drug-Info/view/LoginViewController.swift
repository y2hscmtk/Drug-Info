//
//  LoginViewController.swift
//  Drug-Info
//
//  Created by Choi76 on 5/13/24.
//

import UIKit
import FirebaseAuth

// 시뮬레이터에서 로그인 테스트 문제 해결
// https://kodean.tistory.com/25


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
        
        // 사용자가 입력한 아이디와 비밀번호가 파이어베이스에 실제로 존재하는지 확인
        guard let email = userIdTexField.text, !email.isEmpty,
              let password = userPasswordTextField.text, !password.isEmpty else {
            print("Missing email or password")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Failed to sign in: \(error)")
                return
            }
            // 로그인 성공
            print("User signed in: \(authResult?.user.uid ?? "")")
            // 존재한다면 로그인 허용 => 사용자 정보 UserDefault에 저장(사용자 이메일)후 화면 전환
            
            // 1. 스토리보드 찾기
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // 2. 이동할 뷰 찾기 => 스토리보드의 identifier를 통해
            let mainViewController = storyboard
                .instantiateViewController(identifier: "MainTabBarViewController") as MainTabBarViewController
            mainViewController.modalPresentationStyle = .fullScreen //전체 화면으로 변경
            // 3. 화면 이동
            self.navigationController?.pushViewController(mainViewController, animated: true)
        }
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
