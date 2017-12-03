//
//  ButtonCell.swift
//  Project-01
//
//  Created by Raul Riera on 2017-12-02.
//  Copyright © 2017 Raul Riera. All rights reserved.
//

import UIKit
import FunctionalTableData
import ActionKit

typealias ButtonCell = HostCell<UIButton, ButtonState, LayoutMarginsTableItemLayout>

struct ButtonState: Equatable {
	let title: String
	let action: () -> Void
	
	public static func updateView(_ view: UIButton, state: ButtonState?) {
		guard let state = state else {
			view.setTitle(nil, for: .normal)
			view.removeControlEvent(.touchUpInside)
			return
		}
		
		view.titleLabel?.font = UIFont.systemFont(ofSize: 22)
		view.contentHorizontalAlignment = .leading
		view.setTitle(state.title, for: .normal)
		// Callback support for UIControl using the `ActionKit` library.
		// Use whatever technique you prefer to achieve the same
		view.addControlEvent(.touchUpInside) {
			state.action()
		}
	}
	
	static func ==(lhs: ButtonState, rhs: ButtonState) -> Bool {
		return lhs.title == rhs.title
	}
}
