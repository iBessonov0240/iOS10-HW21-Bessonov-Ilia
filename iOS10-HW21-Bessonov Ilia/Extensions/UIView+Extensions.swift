//
//  UIView+Extensions.swift
//  iOS10-HW21-Bessonov Ilia
//
//  Created by i0240 on 30.08.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}
