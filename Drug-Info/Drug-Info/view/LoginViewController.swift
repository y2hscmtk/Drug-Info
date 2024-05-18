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
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInLabel.isUserInteractionEnabled = true
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        
        let signInLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(signInLabelDidTapped))
        signInLabel.addGestureRecognizer(signInLabelTapGesture) // 이벤트 등록
        
        // dismiss 키보드 용
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func loginBtnDidTapped(_ sender: UIButton) {
        
        // 사용자가 입력한 아이디와 비밀번호가 파이어베이스에 실제로 존재하는지 확인
        guard let email = userIdTexField.text, !email.isEmpty else {
            emailErrorLabel.isHidden = false
            emailErrorLabel.text = "이메일을 확인해주세요."
            return
        }
        guard let password = userPasswordTextField.text, !password.isEmpty else {
            passwordErrorLabel.isHidden = false
            passwordErrorLabel.text = "비밀번호를 확인해주세요."
            return
        }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                    switch errorCode {
                    case .invalidEmail:
                        self.emailErrorLabel.isHidden = false
                        self.emailErrorLabel.text = "이메일 형식이 올바르지 않습니다."
                    case .wrongPassword:
                        self.passwordErrorLabel.isHidden = false
                        self.passwordErrorLabel.text = "비밀번호가 틀렸습니다."
                    default:
                        self.passwordErrorLabel.isHidden = false
                        self.passwordErrorLabel.text = "오류가 발생하였습니다. \(error.localizedDescription)"
                    }
                }
                return
            }
            // 로그인 성공
            print("User signed in: \(authResult?.user.uid ?? "")")
            // 존재한다면 로그인 허용 => 사용자 정보 UserDefault에 저장(사용자 이메일)후 화면 전환
            UserDefaults.standard.set("uid",forKey: String((authResult?.user.uid)!))
            
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
    
    @objc private func dismissKeyboard() {
       view.endEditing(true)
    }
   
    // 뷰 위로 올리기
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height + 30)
            }
        }
    }
   
    // 뷰 다시 아래로 내리기
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}
