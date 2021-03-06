//
//  LoginVC.swift
//  DdoDdo-iOS
//
//  Created by 이주혁 on 2020/06/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    var constraintY: CGFloat = 0
    var id : String?
    var pw : String?
    
    // MARK:- IBOutlet
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var stackViewConstraintY: NSLayoutConstraint!
    @IBOutlet var idBackgroundView: UIView!
    @IBOutlet var pwBackgroundView: UIView!
    
    @IBAction func signupBtn(_ sender: Any) {
        guard let signupVC = self.storyboard?.instantiateViewController(identifier : "SignupVC") as? SignupVC else {return}
        signupVC.modalPresentationStyle = .fullScreen
        self.present(signupVC, animated: true)
    }
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        UIView.animate(withDuration: 1, animations: {
            
        })
        super.viewDidLoad()
        self.constraintY = self.stackViewConstraintY.constant
        setLayout()
        initGestureRecognizer()
        idTextField.text = id
        pwTextField.text = pw
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
        self.idTextField.text = ""
        self.pwTextField.text = ""
    }
    //MARK:- Custom Method
    
    func setLayout(){
        self.loginButton.backgroundColor = UIColor.paleGold
        self.loginButton.layer.cornerRadius = 24;
        self.loginButton.layer.masksToBounds = true;
        
        self.loginButton.dropShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
                                    offSet: CGSize(width: 0, height: 3),
                                    opacity: 0.16,
                                    radius: 6)
        self.idBackgroundView.layer.borderWidth = 0.5
        self.idBackgroundView.layer.borderColor = CGColor(srgbRed: 112 / 255, green: 112 / 255, blue: 112 / 255, alpha: 1.0)
        self.idBackgroundView.layer.cornerRadius = 26
        self.idBackgroundView.layer.masksToBounds = true
        
        self.pwBackgroundView.layer.borderWidth = 0.5
        self.pwBackgroundView.layer.borderColor = CGColor(srgbRed: 112 / 255, green: 112 / 255, blue: 112 / 255, alpha: 1.0)
        self.pwBackgroundView.layer.cornerRadius = 26
        self.pwBackgroundView.layer.masksToBounds = true
        
    }
    

    //MARK:- Set Gesture
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        self.view.addGestureRecognizer(textFieldTap)
    }
    
    // 다른 위치 탭했을 때 키보드 없어지는 코드
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.idTextField.resignFirstResponder()
        self.pwTextField.resignFirstResponder()
    }
    // https://nsios.tistory.com/17?category=803407
    // MARK:- Keyboard Notification Selector Method
    // keyboard가 보여질 때 어떤 동작을 수행
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }
        
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight: CGFloat // 키보드의 높이
        
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        // animation 함수
        // 최종 결과물 보여줄 상태만 선언해주면 애니메이션은 알아서
        // duration은 간격
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            
            self.logoImageView.alpha = 0
            
            // +로 갈수록 y값이 내려가고 -로 갈수록 y값이 올라간다.
            self.stackViewConstraintY.constant = +keyboardHeight/2 + 100
        })
        
        self.view.layoutIfNeeded()
    }
    
    // keyboard가 사라질 때 어떤 동작을 수행
    @objc func keyboardWillHide(_ notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        guard let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {return}
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .init(rawValue: curve), animations: {
            
            // 원래대로 돌아가도록
            self.logoImageView.alpha = 1.0
            self.stackViewConstraintY.constant = self.constraintY
        })
        
        self.view.layoutIfNeeded()
    }
    // MARK:- register/unregister Notification Observer
    // observer
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK:- IBAction Method
    
    @IBAction func touchUpLoginButton(_ sender: UIButton) {
        
        guard idTextField.hasText && pwTextField.hasText else {
            self.simpleAlert(title: "잘못된 입력", message: "아이디나 비밀번호를 입력해주세요")
            return
        }
        
        AuthService.shared.login(id: self.idTextField.text!, pw: self.pwTextField.text!) { result in
            switch result {
            case .success(let jwt):
                guard let token = jwt as? String else {
                    return
                }
                UserDefaults.standard.set(token, forKey: "token")
                let sb = UIStoryboard.init(name: "Home", bundle: nil)
                if let dvc = sb.instantiateViewController(identifier: "HomeVC") as? UINavigationController {
                    dvc.modalPresentationStyle = .fullScreen
                    self.present(dvc, animated: true)
                    
                }
                
            case .requestErr(let msg):
                self.simpleAlert(title: "로그인 실패", message: msg as! String)
                
            case .pathErr:
                break
            case .serverErr:
                break
            case .networkFail:
                break
            }
        }
        
    }
    
}
//MARK:- UIGestureRecognizerDelegate Extension
extension LoginVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestrueRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.idTextField))! || (touch.view?.isDescendant(of: self.pwTextField))! {

            return false
        }
        return true
    }
}
