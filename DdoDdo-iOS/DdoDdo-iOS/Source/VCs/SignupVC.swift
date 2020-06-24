//
//  SigninVC.swift
//  DdoDdo-iOS
//
//  Created by 이예슬 on 6/22/20.
//  Copyright © 2020 이주혁. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

 
    @IBOutlet var signupBody: [UIView]!
    @IBOutlet weak var signupBtn: UIButton!

    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var profileMsg: UITextField!
    @IBAction func signupAction(_ sender: Any) {
        SignupService.shared.signup(id: id.text!,pwd: pwd.text!, name: name.text!, gender: gender.text!, profileMsg: profileMsg.text!){
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
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
