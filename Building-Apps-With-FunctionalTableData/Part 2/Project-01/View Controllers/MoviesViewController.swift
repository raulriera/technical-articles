//
//  MoviesViewController.swift
//  Project-01
//
//  Created by Raul Riera on 2017-12-03.
//  Copyright © 2017 Raul Riera. All rights reserved.
//

import Foundation
import FunctionalTableData

class MoviesViewController: FunctionalViewController {
	let movies: [Movie] = [toyStory, toyStory2, findingNemo]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Movies"
		render()
	}
	
	private func render() {
		// In here, FunctionalTableData will diff the current
		// state of the tableView with the state being passed.
		// And only update the changes
		functionalData.renderAndDiff([tableState()])
	}
	
	private func tableState() -> TableSection {		
		let cells: [CellConfigType] = movies.map { movie in
			let actions = CellActions(selectionAction: { [weak self] _ in
				self?.present(movie: movie)
				return .selected
			})
			return LabelCell(key: "key-\(movie)",
				actions: actions,
				state: LabelState(text: movie.title),
				cellUpdater: LabelState.updateView)
		}
		
		return TableSection(key: "section", rows: cells, style: SectionStyle(separators: .default))
	}
	
	private func present(movie: Movie) {
		let viewController = MovieViewController(movie: movie)
		navigationController?.pushViewController(viewController, animated: true)
	}
}
