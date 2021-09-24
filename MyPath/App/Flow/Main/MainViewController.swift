//
//  ViewController.swift
//  MyPath
//
//  Created by Дима Давыдов on 18.08.2021.
//

import UIKit

protocol MainFlowDisplayLogic: AnyObject {
    func display(viewModel: MainFlowViewModel.Location.ResponseCurrent)
    func display(viewModel: MainFlowViewModel.Tracking.State)
    func display(viewModel: MainFlowViewModel.History.ViewModel)
    func display(viewModel: MainFlowViewModel.UserImage.ViewModel)
    func displayPreviouseScreen()
}

class MainViewController: UIViewController {

    enum State {
        /// только просмотр передвижений
        case view(MoveEntry)
        
        /// трекинг
        case tracking(MoveEntry)
    }
    
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
    
    var state: State?
    
    init(state: State) {
        super.init(nibName: nil, bundle: nil)
        self.state = state
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK:- ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Map"
        navigationController?.navigationBar.backgroundColor = .systemBackground
        
        switch state {
        case .view(let model):
            configureWithViewState(model)
        case .tracking(let model):
            configureWithTrackingState(model)
        case .none:
            navigationItem.title = "Unknown"
        }
    }
    
    private func configureWithViewState(_ model: MoveEntry) {
        navigationItem.title = "Tracking history"
        navigationController?.navigationBar.isUserInteractionEnabled = true
        navigationItem.hidesBackButton = false
        
        interactor?.request(MainFlowViewModel.History.Request(moveEntry: model))
    }
    
    private func configureWithTrackingState(_ model: MoveEntry) {
        navigationItem.title = "Tracking in progress"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "End",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(endTrackingAction)
        )
        
        navigationItem.leftBarButtonItem = nil
        navigationController?.navigationBar.isUserInteractionEnabled = false
        navigationItem.hidesBackButton = true
        interactor?.request(MainFlowViewModel.UserImage.Request())
        interactor?.request(MainFlowViewModel.Location.RequestStartTracking(model: model))
    }
    
    // MARK: - Actions
    
    @objc private func endTrackingAction() {
        interactor?.request(MainFlowViewModel.Location.RequestEndTracking())
    }
}

//MARK: - MainFlowDisplayLogic
extension MainViewController: MainFlowDisplayLogic {
    func display(viewModel: MainFlowViewModel.Tracking.State) {
        switch viewModel {
        case .on:
            navigationItem.leftBarButtonItem?.title = "Stop Tracking"
        case .off:
            navigationItem.leftBarButtonItem?.title = "Track"
        }
    }
    
    func display(viewModel: MainFlowViewModel.Location.ResponseCurrent) {
        mainView.display(viewModel: viewModel)
    }
    
    func displayPreviouseScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func display(viewModel: MainFlowViewModel.History.ViewModel) {
        mainView.display(viewModel: viewModel)
    }
    
    func display(viewModel: MainFlowViewModel.UserImage.ViewModel) {
        mainView.display(viewModel: viewModel)
    }
}
