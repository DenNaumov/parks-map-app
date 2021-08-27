//
//  ViewController.swift
//  vgs3-map
//
//  Created by Денис Наумов on 08.08.2021.
//  Copyright © 2021 Denis Naumov. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var viewModel = ParkListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.setSelectedPark(index: nil)
    }
}

// MARK: Setup
extension ListViewController {
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Show on map",
            style: .plain,
            target: self,
            action: #selector(didTapMapButton)
        )
    }
    
    @objc func didTapMapButton() {
        goToMap()
    }
}

// MARK: Transition
extension ListViewController {

    private func goToMap() {
        performSegue(withIdentifier: "toMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? MapViewController else { return }
        destinationVC.viewModel = viewModel
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension ListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.parks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "table-cell", for: indexPath) as! TableViewCell
        cell.setup(with: viewModel.parks[indexPath.item])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        viewModel.setSelectedPark(index: index)
        goToMap()
    }
}
