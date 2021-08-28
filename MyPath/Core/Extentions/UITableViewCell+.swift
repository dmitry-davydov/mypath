//
//  UITableViewCell+.swift
//  MyPath
//
//  Created by Дима Давыдов on 21.08.2021.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return "\(type(of: self)).reuseIdentifier"
    }
}
