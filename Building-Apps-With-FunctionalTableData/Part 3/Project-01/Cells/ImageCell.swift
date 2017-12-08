//
//  ImageCell.swift
//  Project-01
//
//  Created by Raul Riera on 2017-12-08.
//  Copyright © 2017 Raul Riera. All rights reserved.
//

import FunctionalTableData

typealias ImageCell = HostCell<UIImageView, ImageState, LayoutMarginsTableItemLayout>

struct ImageState: Equatable {
	let image: UIImage
	let tintColor: UIColor
	
	public static func updateView(_ view: UIImageView, state: ImageState?) {
		guard let state = state else {
			view.tintColor = UIColor.blue
			view.image = nil
			return
		}
		
		view.tintColor = state.tintColor
		view.image = state.image
	}
	
	static func ==(lhs: ImageState, rhs: ImageState) -> Bool {
		return lhs.image == rhs.image &&  lhs.tintColor == rhs.tintColor
	}
}
