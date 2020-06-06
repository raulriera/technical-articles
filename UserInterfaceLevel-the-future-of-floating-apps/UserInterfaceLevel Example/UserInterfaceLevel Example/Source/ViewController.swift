//
//  ViewController.swift
//  UserInterfaceLevel Example
//
//  Created by Raul Riera on 2020-06-06.
//  Copyright © 2020 Raul Riera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = AdaptiveColor(base: (light: .white, dark: .black),
											 elevated: (light: .lightGray, dark: .gray)).value
	}
}

