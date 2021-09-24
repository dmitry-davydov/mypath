//
//  ProfilePresenter.swift
//  MyPath
//
//  Created by Дима Давыдов on 23.09.2021.
//

import Foundation

protocol ProfilePresentLogic: AnyObject {
    var viewController: ProfileDisplayLogic? { get set }
    
    func present(_ response: Profile.Response.Init)
    func present(_ response: Profile.Response.ChangeImage)
}

class ProfilePresenter: ProfilePresentLogic {
    weak var viewController: ProfileDisplayLogic?
    
    func present(_ response: Profile.Response.Init) {
        viewController?.display(viewModel: Profile.ViewModel(image: response.image))
    }
    
    func present(_ response: Profile.Response.ChangeImage) {
        viewController?.display(viewModel: Profile.ViewModel(image: response.image))
    }
}
