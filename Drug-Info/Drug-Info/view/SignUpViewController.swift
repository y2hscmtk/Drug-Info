//
//  SignUpViewController.swift
//  Drug-Info
//
//  Created by Choi76 on 5/13/24.
//

import UIKit
import FirebaseAuth

// 회원가입
class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailValidLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // 초기에는 오류 문구 보이지 않도록 설정
        emailValidLabel.isHidden = true
        passwordValidLabel.isHidden = true
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        // 이메일이 비어있는지 확인
        guard let email = emailTextField.text, !email.isEmpty else{
            emailValidLabel.isHidden = false
            emailValidLabel.text = "이메일을 작성해주세요."
            return
        }
        
        // 비밀번호가 비어있는지 확인
        guard let password = passwordTextField.text, !password.isEmpty else{
            passwordValidLabel.isHidden = false
            passwordValidLabel.text = "비밀번호를 작성해주세요."
            return
        }
        
        // 이메일 유효성 검사
        guard isValidEmail(email) else {
            emailValidLabel.isHidden = false
            emailValidLabel.text = "이메일 형식이 올바르지 않습니다."
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                    switch errorCode {
                    case .emailAlreadyInUse:
                        self.emailValidLabel.isHidden = false
                        self.emailValidLabel.text = "이미 사용중인 이메일입니다."
                    case .invalidEmail:
                        self.emailValidLabel.isHidden = false
                        self.emailValidLabel.text = "이메일 형식이 올바르지 않습니다."
                    case .weakPassword:
                        self.passwordValidLabel.isHidden = false
                        self.passwordValidLabel.text = "비밀번호는 6글자 이상이어야 합니다."
                    default:
                        print("Error: \(error.localizedDescription)")
                    }
                }
                return
            }
            // 회원가입 성공
            print("User signed up: \(authResult?.user.uid ?? "")")
            // FireStorage에 회원 저장 과정 작성 필요(uid 저장 필요)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // 유효성 검사
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}
