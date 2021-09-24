//
//  ProfileViewController.swift
//  MyPath
//
//  Created by Дима Давыдов on 23.09.2021.
//

import UIKit
import SnapKit

protocol ProfileDisplayLogic: AnyObject {
    func display(viewModel: Profile.ViewModel)
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {
    var interactor: ProfileBusinessLogic?
    
    //MARK: - Views
    private lazy var avatarImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "avatar")
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var changeAvatarImage: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Change image", for: .normal)
        view.backgroundColor = .secondarySystemBackground
        view.addTarget(self, action: #selector(onChangeUserAvatar), for: .touchUpInside)
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.contentEdgeInsets.left = 8
        view.contentEdgeInsets.right = 8
        
        return view
    }()
    
    private lazy var cameraViewController: UIImagePickerController? = {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return nil }
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        return imagePickerController
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        interactor?.request(Profile.Request.Init())
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(avatarImage)
        view.addSubview(changeAvatarImage)
        
        avatarImage.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerY.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
        }
        
        changeAvatarImage.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
    }
    
    //MARK: - Actions
    @objc private func onChangeUserAvatar(_ sender: UIButton) {
        
        guard let imagePickerController = cameraViewController else { return }
        
        present(imagePickerController, animated: true)
    }
    
    //MARK: - ProfileDisplayLogic
    func display(viewModel: Profile.ViewModel) {
        avatarImage.image = viewModel.image
        avatarImage.setNeedsLayout()
        avatarImage.layoutIfNeeded()
    }
}

//MARK: - UIImagePickerControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo: [UIImagePickerController.InfoKey : Any]) {
        guard let image = extractImage(from: didFinishPickingMediaWithInfo) else { return }
        
        interactor?.request(Profile.Request.ChangeImage(image: image))
        
        picker.dismiss(animated: true)
    }
    
    private func extractImage(from info: [UIImagePickerController.InfoKey : Any]) -> UIImage? {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            return image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            return image
        }
        return nil
    }
}
