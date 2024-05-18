//
//  SignUpViewController.swift
//  Drug-Info
//
//  Created by Choi76 on 5/13/24.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
            // 회원가입 성공시 uid를 바탕으로 리얼타임 데이터베이스에 값 저장
            if let uid = authResult?.user.uid {
                self.saveUserInfo(uid: uid, email: email)
                ToastMessage.shared.showToast(message: "가입이 완료되었습니다.", fontSize: 14.0, view: self.view)
                
                // 토스트 메시지를 확인할 시간을 주기 위함
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    
    // 회원 가입 로직
    private func saveUserInfo(uid: String, email: String) {
        let ref = Database.database().reference()
        let userReference = ref.child("users").child(uid) // 데이터베이스 참조
        
        // 사용자 이메일 저장
        let values = ["email": email]
        
        userReference.setValue(values) { error, _ in
            if let error = error {
                print("Failed to save user info: \(error.localizedDescription)")
                return
            }
            print("Successfully saved user info")
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    // 유효성 검사
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}
