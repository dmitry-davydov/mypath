//
//  ProfileInteractor.swift
//  MyPath
//
//  Created by Дима Давыдов on 23.09.2021.
//

import Foundation

protocol ProfileBusinessLogic: AnyObject {
    func request(_ request: Profile.Request.Init)
    func request(_ request: Profile.Request.ChangeImage)
}

class ProfileInteractor: ProfileBusinessLogic {
    var presenter: ProfilePresentLogic?
    
    private var fileStorage: FileStorageProtocol
    
    init(fileStorage: FileStorageProtocol) {
        self.fileStorage = fileStorage
    }
    
    func request(_ request: Profile.Request.Init) {
        // сходить в сторейдж и запросить сохраненную картинку
        
        guard let image = fileStorage.readUserAvatar() else { return }
        presenter?.present(Profile.Response.Init(image: image))
    }
    
    func request(_ request: Profile.Request.ChangeImage) {
        let result = fileStorage.saveUserAvatar(request.image)
        switch result {
        case .success:
            presenter?.present(Profile.Response.ChangeImage(image: request.image))
        case .failure(let error):
            debugPrint(error.localizedDescription)
        }
    }
}
