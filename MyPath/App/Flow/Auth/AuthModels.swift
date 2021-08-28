//
//  AuthModels.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

enum Auth {
    
    enum Request {
        struct Login {
            let email: String
            let password: String
        }
        
        struct RememberPassword {
            let email: String
            let password: String
        }
        
        struct SignIn {
            let email: String
            let password: String
        }
    }
    
    enum Response {
        struct LoginError {
            let err: Error
        }
        
        struct LoginSuccess {}
    }
    
    enum ViewModel {
        struct LoginError {
            let error: Error
        }
        struct LoginSuccess {}
    }
}
