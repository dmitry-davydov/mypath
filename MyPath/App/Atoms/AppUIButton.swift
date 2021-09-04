//
//  AppUIButton.swift
//  MyPath
//
//  Created by Дима Давыдов on 04.09.2021.
//

import UIKit

class AppUIButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStyle() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 4
    }
}
