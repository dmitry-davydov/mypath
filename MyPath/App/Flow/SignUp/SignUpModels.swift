//
//  SignUpModels.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

enum SignUp {
    struct Request {
        let email: String
        let password: String
    }
    
    enum Response {
        struct SuccessSignUp {}
        struct ErrorSignUp {
            let error: Error
        }
    }
    
    enum ViewModel {
        struct Success {}
        struct ErrorViewModel {
            let error: Error
        }
    }
}
