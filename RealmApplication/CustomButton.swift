//
//  CustomButton.swift
//  RealmApplication
//
//  Created by Skorodumov Dmitry on 18.10.2023.
//

import UIKit

class CustomButton: UIButton {
    
    var action: (() -> Void)?
    
    
    init(title : String , titleColor : UIColor , buttonBackgroundColor : UIColor, action: @escaping (() -> Void)) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = buttonBackgroundColor
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.action = action
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed(){
            action?()
    }
}


