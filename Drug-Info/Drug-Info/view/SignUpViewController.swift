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
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Missing email or password")
            return
        }
        
        guard isValidEmail(email) else {
            print("Invalid email format")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Failed to sign up: \(error.localizedDescription)")
                return
            }
            // 회원가입 성공
            print("User signed up: \(authResult?.user.uid ?? "")")
            // 로그인 화면으로 이동 또는 자동 로그인 처리
        }
    }
    
    
    // 유효성 검사
    private func isValidEmail(_ email: String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailPred.evaluate(with: email)
    }

}
