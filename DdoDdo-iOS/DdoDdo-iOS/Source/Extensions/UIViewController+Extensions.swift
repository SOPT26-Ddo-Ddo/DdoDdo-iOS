//
//  UIViewController+Extensions.swift
//  DdoDdo-iOS
//
//  Created by 이주혁 on 2020/06/15.
//  Copyright © 2020 이주혁. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // UIAlertController without handler
    func simpleAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // UIAlertController with Handler
    func simpleAlertwithHandler(title: String, message: String, okHandler : ((UIAlertAction) -> Void)?, cancleHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: cancleHandler)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
