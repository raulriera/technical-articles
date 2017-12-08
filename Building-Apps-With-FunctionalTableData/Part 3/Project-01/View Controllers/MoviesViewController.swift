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
	var movies: [Movie] = [toyStory, toyStory2, findingNemo]
	
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
			let rowAction = UITableViewRowAction(style: .normal, title: movie.isFavorite ? "Unfave" : "Fave", handler: { [weak self] _, _ in
				self?.toggleFavorite(movie: movie)
			})
			
			let actions = CellActions(selectionAction: { [weak self] _ in
				self?.present(movie: movie)
				return .selected
			}, rowActions: [rowAction])
			
			// Create the two states and combined them
			let labelState = LabelState(text: movie.title)
			let iconState = ImageState(image: UIImage(named: "heart")!, tintColor: movie.isFavorite ? .red : UIColor.gray.withAlphaComponent(0.2))
			let combinedState = CombinedState(state1: labelState, state2: iconState)
			
			// Yup, that is very long, we can always use our little `typealias` trick to make them shorter.
			// Maybe something like `LabelIconCell` if we plan to reuse it.
			let combinedCell = CombinedCell<UILabel, LabelState, UIImageView, ImageState, LayoutMarginsTableItemLayout>(
				key: "key-\(movie)",
				style: CellStyle(highlight: true),
				actions: actions,
				state: combinedState,
				cellUpdater: { view, state in
					view.view2.setContentHuggingPriority(.required, for: .horizontal)
					
					// Combined cell is just two cells side by side, call their individual
					// cellUpdater in order to update their content.
					LabelState.updateView(view.view1, state: state?.state1)
					ImageState.updateView(view.view2, state: state?.state2)
				})
			
			return combinedCell
		}
		
		return TableSection(key: "section", rows: cells, style: SectionStyle(separators: .default))
	}
	
	private func present(movie: Movie) {
		let viewController = MovieViewController(movie: movie)
		navigationController?.pushViewController(viewController, animated: true)
	}
	
	private func toggleFavorite(movie: Movie) {
		guard let index = movies.index(where: { $0 == movie }) else { return }

		var movieCopy = movie
		movieCopy.isFavorite = !movieCopy.isFavorite
		
		movies[index] = movieCopy
		
		render()
	}
}
