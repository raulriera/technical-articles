//
//  FunctionalViewController.swift
//  Project-01
//
//  Created by Raul Riera on 2017-12-02.
//  Copyright © 2017 Raul Riera. All rights reserved.
//

import UIKit
import FunctionalTableData

class FunctionalViewController: UITableViewController {
	let functionalData = FunctionalTableData()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.prefersLargeTitles = true
		functionalData.tableView = tableView
	}
}
