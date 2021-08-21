//
//  ViewController.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import UIKit

protocol MainFlowDisplayLogic: AnyObject {
    func display(request: MainFlowViewModel.Location.ResponseCurrent)
    func display(request: MainFlowViewModel.Tracking.State)
}

class MainViewController: UIViewController {

    
    //MARK: - properties
    
    var interactor: MainFlowInteractor?
    
    override func loadView() {
        let mainView = MainView()
        
        view = mainView
    }
    
    var mainView: MainView {
        guard let view = view as? MainView else { fatalError("View error")}
        
        return view
    }
    
    // MARK:- ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Track",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(trackAction)
        )
        
        navigationItem.title = "Map"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Current",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(currentAction)
        )
        
        interactor?.request(MainFlowViewModel.Location.RequestCurrent())
    }
    
    
    // MARK: - Actions
    
    @objc private func trackAction() {
        interactor?.request(MainFlowViewModel.Tracking.Toggle())
    }
    
    @objc private func currentAction() {
        interactor?.request(MainFlowViewModel.Location.RequestCurrent())
    }

}

//MARK: - MainFlowDisplayLogic
extension MainViewController: MainFlowDisplayLogic {
    func display(request: MainFlowViewModel.Tracking.State) {
        switch request {
        case .on:
            navigationItem.leftBarButtonItem?.title = "Stop Tracking"
        case .off:
            navigationItem.leftBarButtonItem?.title = "Track"
        }
    }
    
    func display(request: MainFlowViewModel.Location.ResponseCurrent) {
        mainView.display(request: request)
    }
}
