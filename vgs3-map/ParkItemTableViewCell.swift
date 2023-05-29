//
//  TableViewCell.swift
//  vgs3-map
//
//  Created by Денис Наумов on 08.08.2021.
//  Copyright © 2021 Denis Naumov. All rights reserved.
//

import UIKit

class ParkItemTableViewCell: UITableViewCell {

    func setup(with park: ParkViewModel) {
        textLabel?.text = park.displayName
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = ""
    }
}
