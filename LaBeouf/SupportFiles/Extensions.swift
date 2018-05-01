//
//  Extensions.swift
//  LaBeouf
//
//  Created by Sergey Levkachev on 01/05/2018.
//  Copyright © 2018 Sergey Levkachev. All rights reserved.
//

import UIKit

extension UIViewController {
    func embed(viewController: UIViewController, in containerView: UIView) {
        viewController.view.frame = containerView.bounds
        viewController.willMove(toParentViewController: self)
        containerView.addSubview(viewController.view)
        addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIColor {
    enum CustomButton {
        static let selectedColor = UIColor(hex: "845CEE")
        static let normalBorderColor = UIColor(hex: "E8E8E8")
    }
}
