//
//  View.swift
//  vgs3-map
//
//  Created by Денис Наумов on 25.06.2022.
//  Copyright © 2022 Denis Naumov. All rights reserved.
//

import UIKit
import MapKit

class MapMethodView: UIView {
    @IBOutlet weak var mapView: MKMapView!
//    override var backgroundColor: UIColor? = .blue
}

class TableMethodView: UIView {
    @IBOutlet weak var tableView: UITableView!
//    override var backgroundColor: UIColor? = .blue
}

class ParksViewController: UIViewController {

    var flagView: Bool = true

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (flagView) {
            let view = MapMethodView()
            self.view.addSubview(view)
        } else {
            let view = TableMethodView()
            self.view.addSubview(view)
        }
        createView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Show on map",
            style: .plain,
            target: self,
            action: #selector(didTapMapButton)
        )
    }
    
    @objc func didTapMapButton() {
        createView()
    }

    private func createView() {
        if flagView {
            flagView = false
            let newview = MapMethodView()
            view.addSubview(newview)
            navigationItem.rightBarButtonItem?.title = "Show on table"
            newview.bounds = CGRect(x: 80, y: 100, width: 200, height: 100)
        } else {
            flagView = true
            let newview = TableMethodView()
            view.addSubview(newview)
            navigationItem.rightBarButtonItem?.title = "Show on map"
            newview.bounds = CGRect(x: 80, y: 100, width: 200, height: 100)
        }
//        self.viewDidAppear(true)
        print(flagView)
    }
}
