//
//  TrackingListViewController.swift
//  MyPath
//
//  Created by Дима Давыдов on 21.08.2021.
//

import UIKit
import SnapKit

protocol TrackingListFlowDisplayLogic {
    func display(_ viewModel: TrackingListModel.MoveEntries.Response)
    func display(_ viewController: UIViewController)
}

class TrackingListViewController: UIViewController {
    
    enum SectionsCategory: CaseIterable {
        case tracking
    }
    
    private let sections: [SectionsCategory] = [.tracking]
    
    private var dataSource: [MoveEntry] = []
    
    var interactor: TrackingFlowLogicProtocol?
    
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        
        return tableView
    }()
    
    private func setupController() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TrackingListTableViewCell.self, forCellReuseIdentifier: TrackingListTableViewCell.reuseIdentifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "New",
            style: .plain,
            target: self,
            action: #selector(startNewTrackingAction)
        )
        
        navigationItem.title = "Your tracks"
    }
    
    // MARK: - View Controller lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // запросить сохраненные передвижения
        interactor?.request(TrackingListModel.MoveEntries.Request())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
    }
    
    // MARK: actions
    @objc private func startNewTrackingAction() {
        interactor?.request(TrackingListModel.NewMove.Request())
    }
}

// MARK: - UITableViewDataSource
extension TrackingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackingListTableViewCell.reuseIdentifier, for: indexPath) as? TrackingListTableViewCell else { fatalError("Can not dequeue cell")}
        
        let viewModel = dataSource[indexPath.row]
        
        
        cell.textLabel?.text = viewModel.startAt.description
        
        return cell
    }
}

extension TrackingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = dataSource[indexPath.row]
        interactor?.request(TrackingListModel.MoveEntries.HistoryRequest(item: viewModel))
    }
}

// MARK: - TrackingListFlowDisplayLogic
extension TrackingListViewController: TrackingListFlowDisplayLogic {
    func display(_ viewModel: TrackingListModel.MoveEntries.Response) {
        dataSource = viewModel.items
        tableView.reloadData()
    }
    
    func display(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}


