//
//  ViewController.swift
//  vgs3-map
//
//  Created by Денис Наумов on 08.08.2021.
//  Copyright © 2021 Denis Naumov. All rights reserved.
//

import UIKit
//TODO: make switch between map and list VCs
class ParkListView: UITableViewController {

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
extension ParkListView {

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    private func setupNavigationBar() {

        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
            navigationBar.barTintColor = UIColor.lightGray
            view.addSubview(navigationBar)

            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)

            let navigationItem = UINavigationItem(title: "Title")
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = doneButton

            navigationBar.items = [navigationItem]

        navigationItem.title = "Parks list"
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
extension ParkListView {

    private func goToMap() {
        
        performSegue(withIdentifier: "toMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? MapView else { return }
        destinationVC.viewModel = viewModel
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension ParkListView {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.parks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "table-cell", for: indexPath) as? ParkItemTableViewCell else { fatalError() }
        cell.setup(with: viewModel.parks[indexPath.item])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        viewModel.setSelectedPark(index: index)
        goToMap()
    }
}
