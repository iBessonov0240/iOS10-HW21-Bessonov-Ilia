//
//  UIViewController+Extensions.swift
//  iOS10-HW21-Bessonov Ilia
//
//  Created by i0240 on 02.09.2023.
//

import UIKit

extension UIViewController {

    func presentAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = AlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
