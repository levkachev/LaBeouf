//
//  CustomButton.swift
//  LaBeouf
//
//  Created by Sergey Levkachev on 01/05/2018.
//  Copyright © 2018 Sergey Levkachev. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            zoom()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.size.height / 2
        layer.borderWidth = 1
        layer.borderColor = isSelected ? UIColor.clear.cgColor : UIColor.CustomButton.normalBorderColor.cgColor
        
        backgroundColor = isSelected ? UIColor.CustomButton.selectedColor : .white
    }
    
    @objc private func tapped() {
        isSelected = !isSelected
    }
    
    private func zoom(_ duration: TimeInterval = 0.2) {
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseIn], animations: {
            self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) : CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
}
