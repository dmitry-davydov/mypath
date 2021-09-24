//
//  ProfileModels.swift
//  MyPath
//
//  Created by Дима Давыдов on 23.09.2021.
//

import Foundation
import UIKit

enum Profile {
    enum Request {
        struct Init {}
        struct ChangeImage {
            let image: UIImage
        }
    }
    
    enum Response {
        struct Init {
            let image: UIImage
        }
        struct ChangeImage {
            let image: UIImage
        }
    }
    
    struct ViewModel {
        let image: UIImage
    }
}
