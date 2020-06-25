//
//  SigninVC.swift
//  DdoDdo-iOS
//
//  Created by 이예슬 on 6/22/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {
    private var pickerController = UIImagePickerController()
    var constraintY: CGFloat = 0
    var profileImg :UIImage?
    //var profileImgName:String?
    var profileURL:URL?
    
    @IBOutlet weak var uploadProfileImg: UIButton!
    @IBOutlet var signupBody: [UIView]!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var profileMsg: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var stackViewConstraintY: NSLayoutConstraint!
    @IBOutlet weak var back: UIButton!
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated:true,completion: nil)
    }
    @IBAction func uploadImg(_ sender: Any) {
        self.openLibrary()
    }
    @IBAction func signupAction(_ sender: Any) {
        SignupService.shared.signup(id: id.text!,pwd: pwd.text!, name: name.text!, gender: gender.text!, profileMsg: profileMsg.text!,profileImgName:profileURL!.lastPathComponent,profileImg:profileImg!){
            networkResult in
            switch networkResult {
            case .success(let userid):
                print(userid)
                guard let userID = userid as? String else { return }
                guard let loginViewController = self.storyboard?.instantiateViewController(identifier:
                    "LoginVC") as? LoginVC else { return
                }
                loginViewController.id = userID
                loginViewController.pw = self.pwd.text
                //firstViewController.flag = true
                loginViewController.modalPresentationStyle = .fullScreen
                self.present(loginViewController, animated: true, completion: nil)
                
            case .requestErr(let message):
                guard let message = message as? String else { return }
                let alertViewController = UIAlertController(title: "회원가입 실패", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertViewController.addAction(action)
                self.present(alertViewController, animated: true, completion: nil)
            case .pathErr: print("pathErr")
            case .serverErr: print("serverErr")
            case .networkFail: print("networkFail")
                
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        self.constraintY = self.stackViewConstraintY.constant
        let radius : CGFloat = 26
        for view in signupBody{
            view.layer.cornerRadius = radius
            view.layer.borderWidth = 0.5
            view.layer.borderColor = CGColor(srgbRed: 112 / 255, green: 112 / 255, blue: 112 / 255, alpha: 1.0)
        }
        self.signupBtn.backgroundColor = UIColor.paleGold
        self.signupBtn.layer.cornerRadius = 24;
        self.signupBtn.layer.masksToBounds = true;
        
        self.signupBtn.dropShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
                                  offSet: CGSize(width: 0, height: 3),
                                  opacity: 0.16,
                                  radius: 6)
        initGestureRecognizer()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    //MARK:- Set Gesture
    func initGestureRecognizer() {
        let textFieldTap = UITapGestureRecognizer(target: self, action: #selector(handleTapTextField(_:)))
        textFieldTap.delegate = self
        self.view.addGestureRecognizer(textFieldTap)
    }
    
    // 다른 위치 탭했을 때 키보드 없어지는 코드
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.id.resignFirstResponder()
        self.pwd.resignFirstResponder()
        self.name.resignFirstResponder()
        self.gender.resignFirstResponder()
        self.profileMsg.resignFirstResponder()
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
            self.uploadProfileImg.isHidden = true
            self.back.alpha = 0
        
            // +로 갈수록 y값이 내려가고 -로 갈수록 y값이 올라간다.
            self.stackViewConstraintY.constant = +keyboardHeight/2 - 120
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
            self.uploadProfileImg.isHidden = false
            self.back.alpha = 1.0
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
    
    
    
}
//MARK:- UIGestureRecognizerDelegate Extension
extension SignupVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestrueRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.id))! || (touch.view?.isDescendant(of: self.pwd))! {
            
            return false
        }
        return true
    }
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


extension SignupVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func openLibrary(){
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated:true,completion:nil)
    }
    func openCamera(){
        pickerController.sourceType = .camera
        self.present(pickerController, animated:true, completion:nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            profileImg = image ?? UIImage()
            profileURL = url ?? nil
            self.logoImageView.image = profileImg
            self.logoImageView.layer.cornerRadius = self.logoImageView.bounds.width / 2
            self.logoImageView.contentMode = .scaleAspectFill
            }
        
        dismiss(animated:true,completion:nil)
    }
}
