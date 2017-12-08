//
//  MovieViewController.swift
//  Project-01
//
//  Created by Raul Riera on 2017-12-02.
//  Copyright © 2017 Raul Riera. All rights reserved.
//

import UIKit
import FunctionalTableData

class MovieViewController: FunctionalViewController {
	let movie: Movie
	
	required init(movie: Movie) {
		self.movie = movie
		super.init(style: .plain)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = movie.title
		render()
	}
	
	private func render() {
		// In here, FunctionalTableData will diff the current
		// state of the tableView with the state being passed.
		// And only update the changes
		functionalData.renderAndDiff([tableState()])
	}
	
	private func tableState() -> TableSection {
		let summaryCell = LabelCell(key: "summary",
									state: LabelState(text: movie.summary),
									cellUpdater: LabelState.updateView)
		
		let padding = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
		let cellStyle = CellStyle(bottomSeparator: .inset, layoutMargins: padding)
		
		let rentInItunes = ButtonCell(key: "rent",
									  style: cellStyle,
									  state: ButtonState(title: "\(movie.price) Rent", action: { [weak self] in
										  print("Looks like you want to rent \(String(describing: self?.movie.title))")
									  }),
									  cellUpdater: ButtonState.updateView)
		
		let shareLink = ButtonCell(key: "share",
								  style: cellStyle,
								  state: ButtonState(title: "Share", action: { [weak self] in
									  print("Looks like you want to share \(String(describing: self?.movie.title))")
								  }),
								  cellUpdater: ButtonState.updateView)
		
		let cells: [CellConfigType] = [
			summaryCell,
			rentInItunes,
			shareLink
		]
		
		return TableSection(key: "section", rows: cells)
	}
}
