//
//  ResetPasswordViewModel.swift
//  MyPath
//
//  Created by Дима Давыдов on 28.08.2021.
//

import Foundation

enum ResetPassword {
    enum Request {
        struct NewPassword {
            let email: String
            let password: String
        }
    }
    
    enum Response {
        struct NewPasswordError {
            let error: Error
        }
        
        struct NewPasswordSuccess {}
    }
    
    enum ViewModel {
        struct ResetPasswordSuccess {}
        struct ResetPasswordError {
            let error: Error
        }
        
    }
}
